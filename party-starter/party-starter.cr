require "option_parser"
require "colorize"

require "./cli_option_parser"
require "./languages/*"

LANGUAGE_MAPPING = {
  "ruby" => Languages::Ruby
}

programming_language = parse_cli_options(LANGUAGE_MAPPING.keys, default_language: "ruby")

current_time = Time.local

if current_time.month != 12
  puts "Unfortunately, #{"Advent of Code".colorize(:yellow)} is only available in December"
  exit(5)
end

puts "We are programming in #{programming_language.colorize(:red)}, AoC #{current_time.year.colorize(:yellow)}, Day #{current_time.day.colorize(:green)}"

language_tool = LANGUAGE_MAPPING[programming_language].new(day: current_time.day, year: current_time.year)
language_tool.setup_code
