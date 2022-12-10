require 'digest'

def five_zeroes(prefix, index=0)
  loop do
    candidate = "#{prefix}#{index}"
    digest = Digest::MD5.hexdigest(candidate)
    return digest, index if digest.start_with?('00000')
    index += 1
  end
end

start_at = 0
password = ""

8.times do
 result, start_at =  five_zeroes('ffykfhsq', start_at + 1)
 password << result[5]
end

puts password

