require "ecr/macros"

class Languages::Base
  def initialize(year : Int32, day : Int32)
    @year = year
    @day = day
  end

  def file_exists?(file)
    if File.exists?(file)
      puts "File #{file.colorize(:red)} already exists!"
      exit(2)
    end
  end
end
