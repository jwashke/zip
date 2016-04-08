class Node

  attr_reader :number, :string

  attr_accessor :left, :right, :parent

  def initialize(string, number)
    @string = string
    @number = number
    @left = nil
    @right = nil
    @parent = nil
  end
end
