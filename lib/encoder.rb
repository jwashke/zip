require_relative 'node'

class Encoder

  attr_reader :message
  # TAKE IN MESSAGE AT INIATLIZE
  def initialize(message)
    @message = message
  end
  # MAKE CHARACTER COUNT HASH AND SORT BY NUMBER OF CHARACTERS
  def character_counts
    count = Hash.new(0)
    @message.chars.each do |char|
      count[char] += 1
    end
    count
  end

  # BUILD THE FUCKING TREE DAWG
  def build_tree
    queue = priority_queue
    until queue.size == 1
      queue = sort_queue(queue)
      # remove the two nodes with hte highest priority
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

  # INTERMEDIARY STEP FOR TREE CREATE PRIORITY ARRAY OF NODESS WHAT????
  def priority_queue
    queue = character_counts.map { |key, value| Node.new(key, value) }
  end

  def sort_queue(queue)
    queue.sort_by { |node| node.number }
  end

  def count_nodes(node)
    nodes  = 0
    nodes += count_nodes(node.left)  if node.left != nil
    nodes += 1
    nodes += count_nodes(node.right) if node.right != nil
    nodes
  end

  def count_leaves(node)
    leaves = 0
    leaves += count_leaves(node.left)  if node.left != nil
    leaves += 1 if node.left == nil and node.right == nil
    leaves += count_leaves(node.right) if node.right != nil
    leaves
  end


  # ENCODE SINGLE CHARACTER USING TREE
  def char_to_code(char)

  end

  # ORIGINAL BITSTRING
  # RETURN BITSTRING OF ORIGINAL MESSAGE AS STRING

  # CODED BITSTRING
  # PRINT THAT ENCODED STRING THAT SHITS SHORTERRRRR WHAAAA?

  # ORIGINAL BITLENGTH
  # SIZE OF ORIGINAL BITSTRING

  # CODED BITLENGTH
  # PROVE THAT SHITS SHORTER WITH MATH

  # CODING EFFICIENCY
  # HOW MUCH SHORTER PERRCEEENNNTAAAGGGEEESSSS LEEEETTTSSS GOOOOOOOOOOO

  # FILE SHIT?!
  # I DUNNO DEAL WITH THAT LATER


end
