class IntComputer
  def initialize(code)
    @memory = code
    @pointer = 0
  end

  attr_reader :pointer

  def run
    loop do
      case read(pointer)
      when 1 # add 
        write_indirect(pointer + 3, read_indirect(pointer + 1) + read_indirect(pointer + 2))
        self.pointer += 4
      when 2 # multiply
        write_indirect(pointer + 3, read_indirect(pointer + 1) * read_indirect(pointer + 2))
        self.pointer += 4
      when 99 # exit
        break
      end
    end
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
end