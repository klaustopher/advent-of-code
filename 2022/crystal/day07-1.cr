# Advent of Code 2022 - Day 7
# See https://adventofcode.com/2022/day/7

module AoC
  class Directory
    property parent
    getter files : Hash(String, File)
    getter directories : Hash(String, Directory)

    def initialize(@parent : Directory?)
      @files = {} of String => File
      @directories = {} of String => Directory
    end

    def size : Int32
      @directories.values.sum { |dir| dir.size } + @files.values.sum { |file| file.size }
    end
  end

  class File
    getter size : Int32

    def initialize(@size : Int32)
    end
  end
end

data = File.read_lines("day07.txt")

fs_root = AoC::Directory.new(nil)
current_dir = fs_root

data.each do |line|
  cmds = line.split(" ")

  if cmds[0] == "$"
    if cmds[1] == "cd"
      if cmds[2] == "/"
        current_dir = fs_root
      elsif cmds[2] == ".."
        current_dir = current_dir.parent.not_nil!
      else
        current_dir = current_dir.directories[cmds[2]]
      end
    elsif cmds[1] == "ls"
      # nothing to do here
    end
  else
    # file listing

    if cmds[0] == "dir"
      current_dir.directories[cmds[1]] = AoC::Directory.new(current_dir)
    else
      current_dir.files[cmds[1]] = AoC::File.new(cmds[0].to_i)
    end
  end
end

def sum_of_dirs_under_100_000(root) : Int32
  sum = 0
  size = root.size

  sum += size if size <= 100_000

  sum += root.directories.values.sum do |dir|
    sum_of_dirs_under_100_000(dir)
  end

  sum
end

puts sum_of_dirs_under_100_000(fs_root)
