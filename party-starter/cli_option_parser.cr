def parse_cli_options(available_languages, default_language)
  programming_language = default_language

  OptionParser.parse do |parser|
    parser.banner = "Advent of Code Daily Starter"

    parser.on "-h", "--help", "Show help" do
      puts parser
      exit
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

  return programming_language
end
