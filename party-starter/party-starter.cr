require "option_parser"
require "colorize"
require "file_utils"

require "./cli_option_parser"
require "./languages/*"

LANGUAGE_MAPPING = {
  "ruby"    => Languages::Ruby,
  "go"      => Languages::Go,
  "crystal" => Languages::Crystal,
}

current_time = Time.local
default_lang_filename = "#{current_time.year}/.party-starter-language"
default_language = File.exists?(default_lang_filename) ? File.read(default_lang_filename).chomp : "ruby"

programming_language = parse_cli_options(LANGUAGE_MAPPING.keys, default_language: default_language)

if current_time.month != 12
  puts "Unfortunately, #{"Advent of Code".colorize(:yellow)} is only available in December"
  exit(5)
end

puts "We are programming in #{programming_language.colorize(:red)}, AoC #{current_time.year.colorize(:yellow)}, Day #{current_time.day.colorize(:green)}"

language_tool = LANGUAGE_MAPPING[programming_language].new(day: current_time.day, year: current_time.year)

# Make sure that the folder exists
FileUtils.mkdir_p(language_tool.folder)

language_tool.setup_code

puts "All Setup! Happy Coding and good luck!".colorize(:green)
