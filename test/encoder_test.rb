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

    expected = "Tree made with 31 total nodes and 16 leaf nodes"

    assert_equal expected, encoder.build_tree
  end

  def test_it_can_translate_a_char_to_compressed_bytecode
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)
    encoder.build_tree

    assert_equal "01100", encoder.char_to_code("T")
    # assert_equal "110", encoder.char_to_code(" ")
    # assert_equal "1111", encoder.char_to_code("a")
    # assert_equal "1110", encoder.char_to_code("n")
  end

  def test_it_can_return_the_original_bitstring_of_message
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)

    bitstring = "01010100011010000110000101110100001001110111001100100000011011100110111100100000011011010110111101101111011011100010110000100000011010010111010000100111011100110010000001100001001000000111001101110000011000010110001101100101001000000111001101110100011000010111010001101001011011110110111000100001"

    assert_equal bitstring, encoder.original_bitstring
  end

  def test_it_can_return_the_original_bitlength_of_a_message
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)

    assert_equal 296, encoder.original_bitlength
  end

  def test_it_can_return_the_coded_bitstring_of_a_message
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)
    encoder.build_tree

    bitstring = "011000110111111000111000110111000111001010001001111010110110010010001110001101111110000101111111101001010111000010011111000100001111001011"

    assert_equal bitstring, encoder.coded_bitstring
  end

  def test_it_can_return_the_coded_bitlength_of_a_message
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)
    encoder.build_tree

    assert_equal 138, encoder.coded_bitlength
  end

  def test_it_can_return_the_efficiency_of_an_encoded_message
    message = "That's no moon, it's a space station!"
    encoder = Encoder.new(message)
    encoder.build_tree

    assert_equal "46.6%", encoder.coding_efficiency
  end
end
