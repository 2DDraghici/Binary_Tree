require_relative './node'
# frozen_string_literal: true

class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = (array.size - 1) / 2
    root_node = Node.new(array[middle])

    root_node.left_child = build_tree(array[0...middle])
    root_node.right_child = build_tree(array[(middle + 1)..-1])

    root_node
  end

  def insert(value, node = @root)
    return nil if value == node.data

    if value < node.data
      if node.left_child.nil?
        node.left_child = Node.new(value)
      else
        insert(value, node.left_child)
      end
    end
    if value > node.data
      if node.right_child.nil?
        node.right_child = Node.new(value)
      else
        insert(value, node.right_child)
      end
    end
  end

  def delete(value, node = @root)
    return node if node.data.nil?

    if value < node.data
      node.left_child = delete(value, node.left_child)

    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    else
      return node.right_child if node.left_child.nil?
      return node.left_child if node.right_child.nil?

      leftmost_node = leftmost(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
  end

  def leftmost(node)
    node = node.left_child until node.left_child.nil?
    node
  end

  def find(value, node = root)
    return node if node.data == value
    return puts "Can't find value" if node.nil?

    if value < node.data
      find(value, node.left_child)
    else
      find(value, node.right_child)

    end
  end

  def level_order(node = @root, queue = [])
    print "#{node.data} "
    queue << node.left_child unless node.left_child.nil?
    queue << node.right_child unless node.right_child.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

  def inorder(node = @root)
    return if node.nil?

    inorder(node.left_child)
    print "#{node.data} "
    inorder(node.right_child)
  end

  def preorder(node = @root)
    return if node.nil?

    print "#{node.data} "
    preorder(node.left_child)
    preorder(node.right_child)
  end

  def postorder(node = @root)
    return if node.nil?

    postorder(node.left_child)
    postorder(node.right_child)
    print "#{node.data} "
  end

  def height(node = @root)
    return -1 if node.nil?

    left_height =  height(node.left_child)
    right_height = height(node.right_child)
    [left_height, right_height].max
  end

  def depth(node = @root)
    height(@root) - height(node)
  end
S

  def reorder(node = @root, array = [])
    unless node.nil?

      reorder(node.left_child, array)
      array << node.data
      reorder(node.right_child)
    end
    array
  end

  def rebalance
    self.data = reorder
    self.root = build_tree(data)
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

array = Array.new(15) { rand(1..100) }
bst = Tree.new(array)

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.level_order

puts 'Preorder traversal: '
puts bst.preorder

puts 'Inorder traversal: '
puts bst.inorder

puts 'Postorder traversal: '
puts bst.postorder

10.times do
  a = rand(100..150)
  bst.insert(a)
  puts "Inserted #{a} to tree."
end

bst.pretty_print

if bst.balanced? == true
  puts "Tree is balanced"
else
  puts "Tree is NOT balanced"
end

puts 'Rebalancig tree...'
bst.rebalance

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.level_order

puts 'Preorder traversal: '
puts bst.preorder

puts 'Inorder traversal: '
puts bst.inorder

puts 'Postorder traversal: '
puts bst.postorder
