class Node
  attr_reader :children, :name, :parent, :type

  def initialize(type:, name:, size:, parent: nil)
    @children = []
    @type = type
    @name = name
    @parent = parent
    @size = size
  end

  def add_child(child)
    @children << child
  end

  def size
    return @size if type == :file

    @size = @children.map(&:size).sum
    @size
  end

  def to_s
    if @type == :directory
      "#{@name} (dir, size=#{size})"
    else
      "#{@name} (file, size=#{size})"
    end
  end

  def directory?
    type == :directory
  end

  def is_part1?
    directory? && less_than_or_eq_100_000?
  end

  private

  def less_than_or_eq_100_000?
    size <= 100_000
  end
end

def print_tree(node, level = 0)
  return if node.nil? || !node.directory?

  puts "\t" * level + ' - ' + node.to_s
  node.children.each { |c| print_tree(c, level + 1) }
end

def get_directories_part1(node, holder = [])
  return holder if node.nil?

  holder << node if node.is_part1?

  node.children.each do |child|
    get_directories_part1(child, holder)
  end

  holder
end

def get_directories_part2(node, holder = [])
  return holder if node.nil? || !node.directory?

  holder << node if node.size >= 268_565

  node.children.each do |child|
    get_directories_part2(child, holder)
  end

  holder
end

def main
  input = File.open(File.join(File.dirname(__FILE__), 'input.txt'))
  head = Node.new(type: :directory, name: 'root', size: 0)
  current_directory = head
  input.readlines[1..].each_with_index do |line, _index|
    line.strip!
    if line.start_with? '$' # it's a command
      next if line.include? 'ls'

      _, _cmd, directory = line.split(' ')
      directory.strip!
      current_directory = if directory == '..'
                            current_directory.parent
                          else
                            current_directory.children.select { |child| child.name == directory }.first
                          end
    else
      type, name = line.split(' ')

      child = if type == 'dir'
                Node.new(type: :directory, name: name, size: 0, parent: current_directory)
              else
                Node.new(type: :file, name: name, size: type.to_i, parent: current_directory)
              end
      current_directory.add_child(child)
    end
  end

  total_space = 70_000_000
  needed_space = 30_000_000
  unused_space = total_space - head.size
  total = 0

  directories = get_directories_part2(head).sort_by { |d| d.size }
  puts directories[0].size
end

main
