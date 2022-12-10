class ALU
  def initialize(code)
    @code = code
  end

  def run(input)
    input = input.chars.map(&:to_i)
    values = Hash.new(0)

    @code.each do |code|
      case code[0]
      when 'inp' then values[code[1]] = input.shift
      when 'add' then values[code[1]] += (code[2] =~ /[-\d]+/ ? code[2].to_i : values[code[2]])
      when 'mul' then values[code[1]] *= (code[2] =~ /[-\d]+/ ? code[2].to_i : values[code[2]])
      when 'div' then values[code[1]] /= (code[2] =~ /[-\d]+/ ? code[2].to_i : values[code[2]])
      when 'mod' then values[code[1]] %= (code[2] =~ /[-\d]+/ ? code[2].to_i : values[code[2]])
      when 'eql' then values[code[1]] = (code[2] =~ /[-\d]+/ ? code[2].to_i : values[code[2]]) == values[code[1]] ? 1 : 0
      end
    end

    values
  end
end
