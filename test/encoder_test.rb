require_relative '../lib/encoder'
require 'minitest/autorun'

class EncoderTest < Minitest::Test
  def test_it_can_take_in_a_message
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)

    assert_equal message, encoder.message
  end

  def test_it_can_make_a_hash_with_a_character_count_for_message
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)

    expected = {"T"=>1, "h"=>1, "a"=>4, "t"=>4, "'"=>2, "s"=>4,
                " "=>6, "n"=>3, "o"=>4, "m"=>1, ","=>1, "i"=>2,
                "p"=>1, "c"=>1, "e"=>1, "!"=>1}

    assert_equal expected, encoder.character_counts
  end

  def test_it_can_create_a_priority_queue
    message = "GOOO!!"
    encoder = Encoder.new(message)

    queue = encoder.priority_queue

    assert_equal "G", queue[0].string
    assert_equal 1,   queue[0].number
    assert_equal "O", queue[1].string
    assert_equal 3,   queue[1].number
    assert_equal "!", queue[2].string
    assert_equal 2,   queue[2].number
  end

  def test_it_can_sort_a_queue
    message = "GOOO!!"
    encoder = Encoder.new(message)

    queue = encoder.priority_queue
    sorted_queue = encoder.sort_queue(queue)

    assert_equal "G", sorted_queue[0].string
    assert_equal 1,   sorted_queue[0].number
    assert_equal "!", sorted_queue[1].string
    assert_equal 2,   sorted_queue[1].number
    assert_equal "O", sorted_queue[2].string
    assert_equal 3,   sorted_queue[2].number
  end

  def test_it_can_make_a_tree
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)

    output = "Tree made with 31 total nodes and 16 leaf nodes"

    assert_equal output, encoder.build_tree
  end

end
