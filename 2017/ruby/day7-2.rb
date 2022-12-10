Program = Struct.new(:name, :weight, :parent, :children, :children_names, keyword_init: true) do
  def total_weight
    weight + children.sum(&:total_weight)
  end

  def balanced?
    children.empty? || children.map(&:total_weight).uniq.count == 1
  end
end

input = File.read('day7.txt').lines.map(&:chomp)

programs = {}

input.each do |line|
  match = line.match(%r{^(?<name>\w+) \((?<weight>\d+)\)( -> (?<children>[\w,\s]+))?$})

  program = Program.new(
    name: match[:name],
    weight: match[:weight]&.to_i,
    children: [],
    children_names: match[:children] ? match[:children].split(/,\s+/) : []
  )
  programs[program.name] = program
end

programs.values.each do |program|
  program.children_names.each do |child|
    programs[child].parent = program
    program.children << programs[child]
  end
end

pp programs.values.find { |prog| !prog.balanced? }.children.map { |x| "#{x.weight} - #{x.total_weight}" }
