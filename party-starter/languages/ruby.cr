

class Languages::Ruby < Languages::Base
  def setup_code
    puts "💎 for #{@day}-#{@year}"

    code_files.each do |file|
      filename = folder.join(file)
      file_exists?(filename)

      puts "- Creating #{filename.colorize(:yellow)} from ruby code template"
      File.open(filename, "w") do |handle|
        ECR.embed "templates/ruby.ecr", handle
      end
      File.chmod(filename, 0o755)
    end

    input_files.each do |file|
      filename = folder.join(file)
      file_exists?(filename)

      puts "- Creating #{filename.colorize(:yellow)} as an empty txt file for input"
      FileUtils.touch(filename)
    end
  end

  def folder
    Path.new("./#{@year}/ruby")
  end

  def files
    code_files + input_files
  end

  def code_files
    [
      "#{"%02d" % @day}-1.rb",
      "#{"%02d" % @day}-2.rb"
    ]
  end

  def input_files
    [
      "#{"%02d" % @day}-sample.txt",
      "#{"%02d" % @day}-test.txt",
    ]
  end
end
