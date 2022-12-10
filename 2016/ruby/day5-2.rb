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
password = Array.new(8, nil)

loop do
 result, start_at =  five_zeroes('ffykfhsq', start_at + 1)
 position = result[5].to_i(16)

 if position >= 0 && position <= 7 && !password[position]
   password[position] = result[6]
 end

 pp password
 break if password.compact.length == 8

end

puts password.join


