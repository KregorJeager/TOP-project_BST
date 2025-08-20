# frozen_string_literal: true

require_relative 'node'
# Class for a BST
class Tree
  attr_accessor :root

  def initialize(arr)
    sorted_arr = arr.sort.uniq
    @root = build_tree(sorted_arr)
  end

  def build_tree(arr)
    create_bst(arr, 0, arr.length - 1)
  end

  def create_bst(arr, arr_start, arr_end)
    return if arr_start > arr_end

    arr_mid = (arr_start + arr_end) / 2
    root = Node.new(arr[arr_mid])
    root.left = create_bst(arr, arr_start, arr_mid - 1)
    root.right = create_bst(arr, arr_mid + 1, arr_end)

    root
  end

  def insert(root, key)
    return Node.new(key) if root.nil?

    return root if @root.data == key

    if root.data > key
      root.left = insert(root.left, key)
    elsif root.data < key
      root.right = insert(root.right, key)
    else
      puts 'ERROR'
    end

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = Tree.new([3, 1, 2, 3, 4, 5, 6, 2, 3])

test.pretty_print
