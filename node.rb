# frozen_string_literal: true

# A class for nodes on a BST
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end
