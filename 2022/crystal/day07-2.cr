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

total_size = 70_000_000
required_free_size = 30_000_000
current_free_space = total_size - fs_root.size
to_be_freed = required_free_size - current_free_space

def deletion_candidates(directory : AoC::Directory, to_be_freed : Int32) : Array(Int32)
  candidates = [] of Int32
  size = directory.size

  candidates << size if size > to_be_freed

  candidates += directory.directories.values.flat_map { |dir| deletion_candidates(dir, to_be_freed) }

  candidates
end

puts deletion_candidates(fs_root, to_be_freed).min
