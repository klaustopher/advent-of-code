require "ecr/macros"

abstract class Languages::Base
  def initialize(year : Int32, day : Int32)
    @year = year
    @day = day
  end

  abstract def folder
  abstract def setup_code

  def file_exists?(file)
    if File.exists?(file)
      puts "File #{file.colorize(:red)} already exists!"
      exit(2)
    end
  end
end
