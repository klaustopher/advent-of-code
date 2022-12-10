class Languages::Go < Languages::Base
  def setup_code
    puts "🚀 for #{@day}-#{@year}"

    initialize_go_mod

    code_files.each do |file|
      filename = folder.join(file)
      file_exists?(filename)

      puts "- Creating #{filename.colorize(:yellow)} from go code template"
      File.open(filename, "w") do |handle|
        ECR.embed "templates/go.ecr", handle
      end
    end

    input_files.each do |file|
      filename = folder.join(file)
      file_exists?(filename)

      puts "- Creating #{filename.colorize(:yellow)} as an empty txt file for input"
      FileUtils.touch(filename)
    end
  end

  def folder
    Path.new("./#{@year}/go")
  end

  def initialize_go_mod
    if !File.exists?(folder.join("go.mod"))
      puts "- Initializing Go Module"

      Dir.cd(folder) do
        system("go mod init klaustopher/advent_of_code/#{@year}")
      end
    end
  end

  def files
    code_files + input_files
  end

  def code_files
    [
      "day#{"%02d" % @day}-1.go",
      "day#{"%02d" % @day}-2.go",
    ]
  end

  def input_files
    [
      "day#{"%02d" % @day}-sample.txt",
      "day#{"%02d" % @day}.txt",
    ]
  end
end
