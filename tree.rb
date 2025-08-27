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

  def insert(key)
    @root = insert_recur(@root, key)
  end

  def insert_recur(root, key)
    return Node.new(key) if root.nil?

    return root if @root.data == key

    if root.data > key
      root.left = insert_recur(root.left, key)
    elsif root.data < key
      root.right = insert_recur(root.right, key)
    else
      puts 'ERROR'
    end

    root
  end

  def delete(key)
    @root = delete_recur(@root, key)
  end

  def delete_recur(node, key)
    return node if node.nil?

    if node.data > key
      node.left = delete_recur(node.left, key)
    elsif node.data < key
      node.right = delete_recur(node.right, key)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      succ = get_succ(node)
      node.data = succ.data
      node.right = delete_recur(node.right, succ.data)
    end
    node
  end

  def get_succ(node)
    node = node.right
    node = node.left while !node.nil? && !node.left.nil?
    node
  end

  def find(key)
    find_recur(@root, key)
  end

  def find_recur(node, key)
    return node if node.data == key
    return find_recur(node.left, key) if key < node.data

    find_recur(node.right, key) if key > node.data
  end

  def level_order
    q = [] << @root
    arr = []
    puts "q.empty? #{q.empty?}"
    until q.empty?
      # puts 'in q'
      q.insert(0, q[q.length - 1].left) unless q[q.length - 1].left.nil?
      q.insert(0, q[q.length - 1].right) unless q[q.length - 1].right.nil?
      arr << yield(q.pop)
      # puts "in 91 #{arr}"
    end
    return arr unless block_given?

    arr
  end

  def preorder
    nodes = preorder_recur(@root, [])
    arr = []
    if block_given?
      nodes.each { |node| arr << yield(node) }
      return arr
    end
    nodes
  end

  def preorder_recur(node, arr)
    arr << node
    arr = preorder_recur(node.left, arr) unless node.left.nil?
    arr = preorder_recur(node.right, arr) unless node.right.nil?
    arr
  end

  def inorder
    # Returns an array of nodes that are arrange inorder
    nodes = inorder_recur(@root, [])
    arr = []
    if block_given?
      nodes.each { |node| arr << yield(node) }
      return arr
    end
    nodes
  end

  def inorder_recur(node, arr)
    arr = inorder_recur(node.left, arr) unless node.left.nil?
    arr << node
    arr = inorder_recur(node.right, arr) unless node.right.nil?
    arr
  end

  def postorder
    # Returns an array of nodes that are arrange inorder
    nodes = postorder_recur(@root, [])
    arr = []
    if block_given?
      nodes.each { |node| arr << yield(node) }
      return arr
    end
    nodes
  end

  def postorder_recur(node, arr)
    arr = postorder_recur(node.left, arr) unless node.left.nil?
    arr = postorder_recur(node.right, arr) unless node.right.nil?
    arr << node
  end

  def depth(key, node = @root)
    return 'not in tree' if node.data.nil?
    return 0 if key == node.data

    return 1 + depth(key, node.left) if key < node.data

    1 + depth(key, node.right) if key > node.data
  end

  def height(key)
    return 0 if key.nil?

    if key.instance_of?(Node)
      height_recur(key)
    else
      height_recur(find(key))
    end
  end

  def height_recur(node = @root)
    return -1 if node.nil?

    left = height_recur(node.left)
    right = height_recur(node.right)
    if left > right
      1 + left
    elsif right > left
      1 + right
    else
      1 + left
    end
  end

  def bal_recur(node)
    return true if node.nil?

    right_h = height(node.right)
    left_h = height(node.left)

    return false if right_h - left_h > 1

    return false unless bal_recur(node.left) && bal_recur(node.right)

    true
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = Tree.new([0, 3, 1, 2, 3, 4, 5, 6, 2, 3, 7, 8, 9, 10, 11, 12, 13, 14])

test.pretty_print
var = test.height_recur
p var

test.pretty_print
p test.height(7)

p test.bal_recur(test.root)
