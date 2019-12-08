input = File.read('day-8.txt')

width = 25
height = 6

layers = input.scan(/\d{#{width * height}}/)

resulting_image = []

0.upto(width*height) do |pixel|
  current_layer = 0
  while layers[current_layer][pixel] == '2' do
    current_layer += 1
  end

  resulting_image[pixel] = layers[current_layer][pixel] == '1' ? 'X' : ' '
end

puts resulting_image.join('').scan(/.{#{width}}/)