# frozen_string_literal: true

LiteralValue = Struct.new(:version, :value, keyword_init: true) do
  def version_sum
    version
  end

  def to_s
    value
  end
end

class Operator
  attr_reader :version, :type, :packets

  def initialize(version:, type:)
    @version = version
    @type = type
    @packets = []
  end

  def version_sum
    version + packets.sum(&:version_sum)
  end

  def value
    case type
    when 0 then packets.map(&:value).reduce(:+)
    when 1 then packets.map(&:value).reduce(:*)
    when 2 then packets.map(&:value).min
    when 3 then packets.map(&:value).max
    when 5 then packets.first.value > packets.last.value ? 1 : 0
    when 6 then packets.first.value < packets.last.value ? 1 : 0
    when 7 then packets.first.value == packets.last.value ? 1 : 0
    end
  end

  def to_s
    formula = case type
              when 0 then packets.map(&:to_s).join('+')
              when 1 then packets.map(&:to_s).join('*')
              when 2 then "[#{packets.map(&:to_s).join(', ')}].max"
              when 3 then "[#{packets.map(&:to_s).join(', ')}].max"
              when 5 then "#{packets.first.value} > #{packets.last.value} ? 1 : 0"
              when 6 then "#{packets.first.value} < #{packets.last.value} ? 1 : 0"
              when 7 then "#{packets.first.value} == #{packets.last.value} ? 1 : 0"
              end

    "(#{formula})"
  end
end

class CountBasedOperator < Operator
  def initialize(version:, type:, number_of_packets:)
    super(version: version, type: type)

    @number_of_packets = number_of_packets
  end

  def completed?
    packets.size == @number_of_packets
  end
end

class BitBasedOperator < Operator
  attr_accessor :read_bits

  def initialize(version:, type:, number_of_bits:)
    super(version: version, type: type)

    @number_of_bits = number_of_bits
    @read_bits = 0
  end

  def completed?
    @read_bits >= @number_of_bits
  end
end

class BITSParser
  attr_reader :results

  def initialize(hex_string)
    @results = []
    @payload = hex_string.chars.map { |x| '%04d' % x.to_i(16).to_s(2) }.join
    @payload_pointer = 0
    @current_packet_buckets = [@results]
  end

  def parse
    loop do
      version = read_bits_to_integer(3)
      type = read_bits_to_integer(3)

      if type == 4
        value = parse_literal
        add_to_current_bucket LiteralValue.new(version: version, value: value)
      else
        length_type_identifier = read_bits_to_integer(1)

        operator = if length_type_identifier.zero?
                     sub_packets_bit_length = read_bits_to_integer(15)
                     BitBasedOperator.new(version: version, type: type, number_of_bits: sub_packets_bit_length)
                   else
                     sub_packets_count = read_bits_to_integer(11)
                     CountBasedOperator.new(version: version, type: type, number_of_packets: sub_packets_count)
                   end

        add_to_current_bucket operator
        @current_packet_buckets << operator
      end

      @current_packet_buckets.delete_if { |bucket| bucket.is_a?(Operator) && bucket.completed? }

      break if done?
    end
  end

  private

    def current_bucket
      @current_packet_buckets.last
    end

    def add_to_current_bucket(item)
      if current_bucket.is_a?(Array)
        current_bucket << item
      else
        current_bucket.packets << item
      end
    end

    def done?
      @payload_pointer == @payload.size || @payload[@payload_pointer..].chars.all? { |x| x == '0' }
    end

    def read_bits(number_of_bits)
      data = @payload[@payload_pointer...(@payload_pointer + number_of_bits)]

      @payload_pointer += number_of_bits

      @current_packet_buckets.each do |bucket|
        bucket.read_bits += number_of_bits if bucket.is_a?(BitBasedOperator)
      end

      data
    end

    def read_bits_to_integer(number_of_bits)
      read_bits(number_of_bits).to_i(2)
    end

    def parse_literal
      result = ''

      loop do
        data = read_bits(5)
        result += data[1..4]

        break if data[0] == '0'
      end

      result.to_i(2)
    end
end
