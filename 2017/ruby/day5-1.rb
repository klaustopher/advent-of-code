list = File.read('day5.txt').lines.map(&:to_i)
pointer = 0
step = 0

loop do
  break if pointer > list.size - 1

  # puts "Step #{step} - List: #{list}, Pointer: #{pointer}"

  list[pointer] += 1
  pointer += list[pointer] - 1
  step += 1
end

puts step
