# frozen_string_literal: true

class IntComputer
  def initialize(code, inputs: [], name: nil)
    @memory = Array.new(4096, 0)
    code.each_with_index { |op, i| @memory[i] = op }
    @pointer = 0
    @relative_base = 0
    @inputs = inputs
    @output = []
    @waiting = false
    @ended = false
    @name = name

    @instruction = 0
    @parameter_modes = []
  end

  attr_reader :pointer, :inputs, :output, :waiting, :ended, :relative_base, :instruction, :parameter_modes

  def run
    @waiting = false

    while !@ended && !@waiting
      parse_instruction!(pointer)
      case instruction
      when 1 # add
        write_to_argument_with_mode(3, read_argument_with_mode(1) + read_argument_with_mode(2))
        self.pointer += 4
      when 2 # multiply
        write_to_argument_with_mode(3, read_argument_with_mode(1) * read_argument_with_mode(2))
        self.pointer += 4
      when 3 # store input
        if inputs.length.zero?
          puts "[#{@name}] waiting for input" if @name
          @waiting = true
        else
          puts "[#{@name}] using input #{inputs.first}" if @name
          write_to_argument_with_mode(1, inputs.shift)
          self.pointer += 2
        end
      when 4 # output memory
        output << read_argument_with_mode(1)
        puts "[#{@name}] outputting #{output.last}" if @name
        self.pointer += 2
      when 5 # jump if true
        if read_argument_with_mode(1).zero?
          self.pointer += 3
        else
          self.pointer = read_argument_with_mode(2)
        end
      when 6 # jump if false
        if read_argument_with_mode(1).zero?
          self.pointer = read_argument_with_mode(2)
        else
          self.pointer += 3
        end
      when 7 # less than
        write_to_argument_with_mode(3, read_argument_with_mode(1) < read_argument_with_mode(2) ? 1 : 0)
        self.pointer += 4
      when 8 # equals
        write_to_argument_with_mode(3, read_argument_with_mode(1) == read_argument_with_mode(2) ? 1 : 0)
        self.pointer += 4
      when 9 # adjust relative base
        self.relative_base += read_argument_with_mode(1)
        self.pointer += 2
      when 99 # exit
        @ended = true
      else
        raise "Unknown OpCode #{instruction} encountered"
      end
    end
  end

  def parse_instruction!(address)
    @instruction = read(address) % 100
    @parameter_modes = (read(address) / 100).digits
  end

  def dump_memory
    puts @memory.inspect
  end

  def read(address)
    @memory[address]
  end

  def read_indirect(address)
    read(read(address))
  end

  private

    attr_writer :pointer, :relative_base

    def write(address, value)
      @memory[address] = value
    end

    def write_indirect(address, value)
      write(read(address), value)
    end

    def write_to_argument_with_mode(position, value)
      mode = position <= parameter_modes.length ? parameter_modes[position - 1] : 0

      if mode == 2
        write(read(pointer + position) + relative_base, value)
      else
        write(read(pointer + position), value)
      end
    end

    def read_argument_with_mode(position)
      mode = position <= parameter_modes.length ? parameter_modes[position - 1] : 0

      case mode
      when 1
        read(pointer + position)
      when 2
        read(relative_base + read(pointer + position))
      else
        read_indirect(pointer + position)
      end
    end
end
