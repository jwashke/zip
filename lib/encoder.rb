require_relative 'node'

class Encoder

  PREDETERMINED_ORDER = [
  "\n","\t"," ","a","b","c","d","e","f","g","h","i","j","k",
  "l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
  "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O",
  "P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3",
  "4","5","6","7","8","9","~","!","@","#","$","%","^","&","*",
  "(",")","_","+","-","=","[","]","\\",";","'",",",".","/","<",
  ">","?",":","\"","{","}","|"
  ]

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def character_counts
    count = Hash.new(0)
    @message.chars.each do |char|
      count[char] += 1
    end
    count
  end

  def build_tree
    queue = priority_queue
    until queue.size == 1
      queue = sort_queue(queue)
      # remove the two nodes with the highest priority
      node1 = queue.shift
      node2 = queue.shift
      # create a new internal node with these two nodes as children and with
      # probability equal to the sum of the two nodes probablities
      node3 = Node.new(node1.string + node2.string,
                       node1.number + node2.number)
      node3.left  = node1
      node3.right = node2
      # add this new node to the queue,
      queue.push(node3)
    end
    @root_node = queue.first
    # the last node is the root node and the tree is complete
    # now count the number of nodes and leaf nodes
    "Tree made with #{count_nodes(@root_node)} total nodes and #{count_leaves(@root_node)} leaf nodes"
  end

  def priority_queue
    queue = character_counts.map { |key, value| Node.new(key, value) }
  end

  def sort_queue(queue)
    queue.sort_by { |node| node.number }
  end

  def count_nodes(node = @root_node)
    nodes  = 0
    nodes += count_nodes(node.left)  if node.left != nil
    nodes += 1
    nodes += count_nodes(node.right) if node.right != nil
    nodes
  end

  def count_leaves(node = @root_node)
    leaves = 0
    leaves += count_leaves(node.left)  if node.left != nil
    leaves += 1 if node.left == nil and node.right == nil
    leaves += count_leaves(node.right) if node.right != nil
    leaves
  end

  def char_to_code(char, node = @root_node)
    bytes = ""
    if node.left != nil and node.left.string.include?(char)
        bytes = "0" + char_to_code(char, node.left)
    elsif node.right != nil and node.right.string.include?(char)
        bytes = "1" + char_to_code(char, node.right)
    end
    bytes
  end

  def encode_message

  end

  def original_bitstring
      @message.unpack("B*").first
  end

  def original_bitlength
    original_bitstring.length
  end

  def coded_array
    @message.chars.map { |char| char_to_code(char) }
  end

  def coded_bitstring
    coded_array.join("")
  end

  def coded_bitlength
    coded_bitstring.length
  end

  def coding_efficiency
    "#{(coded_bitlength / original_bitlength.to_f * 100).round(1)}%"
  end

  def tree_structure
    break_down_tree.unshift(break_down_tree.length).unshift(coded_array.size)
  end

  def write_to_file(filename)
    # io = File.open(...)
    # len = io.read(2).unpack("v")
    # name = io.read(len)
    # width, height = io.read(8).unpack("VV")
    # puts "Rectangle #{name} is #{width} x #{height}"
    io = File.open(filename, 'w')
    io.write(tree_structure.pack("#{"C*" * tree_structure.size}" ))
    # require 'pry'
    # binding.pry
    io.write(coded_array.pack("#{"B*" * coded_array.size}"))
    io.close
    puts PREDETERMINED_ORDER.size
    puts coded_array.size
  end

  def break_down_tree
    PREDETERMINED_ORDER.map do |symbol|
      character_counts[symbol].nil? ? 0 : character_counts[symbol]
    end << (coded_bitlength % 8)
  end


end
