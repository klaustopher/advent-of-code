Program = Struct.new(:name, :weight, :parent, :children_names, keyword_init: true)

input = File.read('day7.txt').lines.map(&:chomp)

programs = {}

input.each do |line|
  match = line.match(%r{^(?<name>\w+) \((?<weight>\d+)\)( -> (?<children>[\w,\s]+))?$})

  program = Program.new(
    name: match[:name],
    weight: match[:weight]&.to_i,
    children_names: match[:children] ? match[:children].split(/,\s+/) : []
  )
  programs[program.name] = program
end

programs.values.each do |program|
  program.children_names.each do |child|
    programs[child].parent = program
  end
end

puts programs.values.find { |prog| prog.parent.nil? }.name
