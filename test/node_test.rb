require_relative '../lib/node'
require 'minitest/autorun'

class NodeTest < Minitest::Test
  def test_it_has_a_string
    node = Node.new("T", 1)

    assert_equal "T", node.string
  end

  def test_it_has_a_number
    node = Node.new("T", 1)

    assert_equal 1, node.number
  end

  def test_it_has_a_left_node
    node = Node.new("T", 1)
    left = Node.new("H", 2)

    node.left = left

    assert_equal "H", node.left.string
    assert_equal 2,   node.left.number
  end

  def test_it_has_a_right_node
    node  = Node.new("T", 1)
    right = Node.new("H", 2)

    node.right = right

    assert_equal "H", node.right.string
    assert_equal 2,   node.right.number
  end

  def test_it_has_a_parent_node
    node   = Node.new("T", 1)
    parent = Node.new("H", 2)

    node.parent = parent

    assert_equal "H", node.parent.string
    assert_equal 2,   node.parent.number
  end
end
