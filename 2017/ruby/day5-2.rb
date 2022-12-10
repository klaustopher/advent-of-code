list = File.read('day5.txt').lines.map(&:to_i)
# list = [0, 3, 0, 1, -3]
pointer = 0
step = 0

loop do
  break if pointer > list.size - 1

  # puts "Step #{step} - List: #{list}, Pointer: #{pointer}"
  val = list[pointer]

  if list[pointer] >= 3
    list[pointer] -= 1
  else
    list[pointer] += 1
  end

  pointer += val
  step += 1
end

puts pointer
puts step
