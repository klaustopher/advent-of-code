def sector_id_for_valid_room(name)
  encrypted_name, sector_id, checksum = name.scan(/([a-z\-]+)-(\d+)\[([a-z]+)\]/).first
  characters = encrypted_name.chars.select { |x| x =~ /[a-z]/ }.tally.to_a
  checksum_candidate = characters.sort do |a, b|
    if a.last == b.last
      a.first <=> b.first
    else
      b.last <=> a.last
    end
  end.map(&:first).first(5).join

  if checksum_candidate == checksum
    sector_id.to_i
  else
    0
  end
end

input = File.read('day4.txt').lines.map(&:chomp)
puts input.sum { |name| sector_id_for_valid_room(name) }

