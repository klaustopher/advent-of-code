def parse_cli_options(available_languages, default_language)
  programming_language = default_language
  puzzle_day = Time.local.day

  OptionParser.parse do |parser|
    parser.banner = "Advent of Code Daily Starter"

    parser.on "-h", "--help", "Show help" do
      puts parser
      exit
    end

    parser.on "-d DAY", "--day DAY", "Day of the Advent of Code challenge" do |day|
      if (1..25).includes? day.to_i
        puzzle_day = day.to_i
      else
        puts "Unfortunately, #{day.colorize(:red)} is not a valid day."
        puts "Valid days: 1-25"
        exit(1)
      end
    end

    parser.on "-l LANGUAGE", "--lang LANGUAGE", "Programming language that should be generated (default=#{default_language})" do |lang|
      if available_languages.includes?(lang.downcase)
        programming_language = lang.downcase
      else
        puts "Unfortunately, #{lang.colorize(:red)} is not supported."
        puts "Supported languages: #{available_languages.join(", ")}"
        exit(1)
      end
    end

    parser.missing_option do |option_flag|
      STDERR.puts "ERROR: #{option_flag} is missing something."
      STDERR.puts ""
      STDERR.puts parser
      exit(1)
    end

    parser.invalid_option do |option_flag|
      STDERR.puts "ERROR: #{option_flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end
  end

  return programming_language, puzzle_day
end
