class Languages::Crystal < Languages::Base
  def setup_code
    puts "🔮 for #{@day}-#{@year}"

    code_files.each do |file|
      filename = folder.join(file)
      file_exists?(filename)

      puts "- Creating #{filename.colorize(:yellow)} from crystal code template"
      File.open(filename, "w") do |handle|
        ECR.embed "templates/crystal.ecr", handle
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
    Path.new("./#{@year}/crystal")
  end

  def files
    code_files + input_files
  end

  def code_files
    [
      "day#{"%02d" % @day}-1.cr",
      "day#{"%02d" % @day}-2.cr",
    ]
  end

  def input_files
    [
      "day#{"%02d" % @day}-sample.txt",
      "day#{"%02d" % @day}.txt",
    ]
  end
end
