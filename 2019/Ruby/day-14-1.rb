require 'awesome_print'

input = File.read('day-14.txt')

Chemical = Struct.new(:quantity, :type, keyword_init: true) do
  def to_s
    "#{quantity} #{type}"
  end
end

$formulas = Hash.new { |h,k| h[k] = Array.new }
$ore_producing_chemicals = []

input.lines.each do |line|
  match = line.match(/(?<sources>.*) => (?<quantity>\d+) (?<type>\w+)/)
  target = Chemical.new(quantity: match[:quantity].to_i, type: match[:type])

  sources = match[:sources].scan(/(\d+) (\w+),?/)

  sources.each do |(quantity, type)|
    $ore_producing_chemicals << target.type if type == 'ORE'
    $formulas[target] << Chemical.new(quantity: quantity.to_i, type: type)
  end
end

def requirements_for(chemical_type, required_quantity)
  target = $formulas.keys.find { |c| c.type == chemical_type }
  sources = $formulas[target]
  multiplier = (required_quantity.to_f / target.quantity.to_f).ceil

  sources.map do |source|
    if $ore_producing_chemicals.include?(source.type)
      Chemical.new(type: source.type, quantity: source.quantity * multiplier)
    else
      requirements_for(source.type, source.quantity * multiplier)
    end
  end.flatten
end

def required_ore_for(chemical_type, required_quantity)
  target = $formulas.keys.find { |c| c.type == chemical_type }
  ore = $formulas[target].first
  multiplier = (required_quantity.to_f / target.quantity.to_f).ceil

  ore.quantity * multiplier
end

final_ore = requirements_for('FUEL', 1).
  group_by(&:type).
  map { |type, chemicals| [type, chemicals.sum(&:quantity)] }.
  sum { |type, qty| required_ore_for(type, qty) }

puts final_ore


