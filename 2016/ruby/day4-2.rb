Room = Struct.new(:name, :sector_id, :checksum, keyword_init: true)

def build_room(name)
  encrypted_name, sector_id, checksum = name.scan(/([a-z\-]+)-(\d+)\[([a-z]+)\]/).first
  characters = encrypted_name.chars.select { |x| x =~ /[a-z]/ }.tally.to_a
  checksum_candidate = characters.sort do |a, b|
    if a.last == b.last
      a.first <=> b.first
    else
      b.last <=> a.last
    end
  end.map(&:first).first(5).join

  return nil if checksum != checksum_candidate

  decrypted = encrypted_name.chars.map do |char|
    next ' ' if char !~ /[a-z]/
    (((char.ord - 'a'.ord + sector_id.to_i) % 26) + 'a'.ord).chr
  end.join

  Room.new(name: decrypted, sector_id: sector_id.to_i, checksum: checksum)
end

input = File.read('day4.txt').lines.map(&:chomp)

rooms = input.map { |x| build_room(x) }.compact

pp rooms.select { |r| r.name == 'northpole object storage' }


