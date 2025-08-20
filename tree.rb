# frozen_string_literal: true

# Class for a BST
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end
end
