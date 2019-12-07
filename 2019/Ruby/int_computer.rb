class IntComputer
  def initialize(code, inputs: [], name: nil)
    @memory = code.dup
    @pointer = 0
    @inputs = inputs
    @output = []
    @waiting = false
    @ended = false
    @name = name
  end

  attr_reader :pointer, :inputs, :output, :waiting, :ended

  def run
    @waiting = false

    while(!@ended && !@waiting) do
      instruction = read(pointer)
      case instruction % 100
      when 1 # add 
        write_indirect(pointer + 3, read_argument_with_mode(1) + read_argument_with_mode(2))
        self.pointer += 4
      when 2 # multiply
        write_indirect(pointer + 3, read_argument_with_mode(1) * read_argument_with_mode(2))
        self.pointer += 4
      when 3 # store input
        if inputs.length == 0
          puts "[#{@name}] waiting for input" if @name
          @waiting = true
        else
          puts "[#{@name}] using input #{inputs.first}" if @name
          write_indirect(pointer + 1, inputs.shift)
          self.pointer += 2
        end
      when 4 # output memory
        output << read_argument_with_mode(1)
        puts "[#{@name}] outputting #{output.last}" if @name
        self.pointer += 2
      when 5 # jump if true
        if read_argument_with_mode(1) != 0
          self.pointer = read_argument_with_mode(2)
        else
          self.pointer += 3
        end
      when 6 # jump if false
        if read_argument_with_mode(1) == 0
          self.pointer = read_argument_with_mode(2)
        else
          self.pointer += 3
        end
      when 7 # less than
        write_indirect(pointer + 3, read_argument_with_mode(1) < read_argument_with_mode(2) ? 1 : 0)
        self.pointer += 4
      when 8 # equals
        write_indirect(pointer + 3, read_argument_with_mode(1) == read_argument_with_mode(2) ? 1 : 0)
        self.pointer += 4
      when 99 # exit
        @ended = true
      end
    end
  end

  def dump_memory
    puts @memory
  end

  def read(address)
    @memory[address]
  end

  def read_indirect(address)
    read(read(address))
  end

  private

  attr_writer :pointer

  def write(address, value)
    @memory[address] = value
  end

  def write_indirect(address, value)
    write(read(address), value)
  end

  def read_argument_with_mode(position)
    parameter_modes = (read(pointer) / 100).digits
    mode = position <= parameter_modes.length ? parameter_modes[position - 1] : 0

    if mode == 1
      read(pointer + position)
    else
      read_indirect(pointer + position)
    end
  end
end