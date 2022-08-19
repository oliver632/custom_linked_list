# class to hold linked lists
class LinkedList

  attr_accessor :name
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  # appends to end of the linked list
  def append(value)
    node = Node.new(value)
    # checks if empty
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end

  # prepends to the start of the linked list
  def prepend(value)
    node = Node.new(value)
    # checks if empty
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end

  def size
    size = 0
    current_node = @head

    # counts by iterating for each next_node is done.
    until current_node == @tail
      current_node = current_node.next_node
      size += 1
    end
    # adds an extra size for the @tail unless it's empt
    size += 1 unless @tail.nil?
    size
  end

  # returns the node @ index
  def at(index)
    return 'Head empty' if @head.nil?
    # returns @head here because it's index 0
    return @head if index == 0

    # uses iteration to get right node
    current_node = @head
    index.times do
      current_node = current_node.next_node
    end
    current_node
  end

  # removes last node
  def pop
    return 'error' if @head.nil?

    current_node = @head
    index = 0
    # Takes us to the node before @tail
    until current_node.next_node == @tail do
      current_node = current_node.next_node
      index += 1
    end
    # makes @tail the node before previous @tail
    @tail = current_node
    # makes next node nil, because it is in @tail
    current_node.next_node = nil
  end

  # check if linked list contains value - boolean
  def contains?(value)
    return false if @head.nil?

    current_node = @head
    # iterates over linked list to find value, returns true if it finds it.
    until current_node == @tail
      return true if current_node.value == value

      current_node = current_node.next_node
    end
    # returns false if not found in iteration of the tail is the value
    @tail.value == value
  end

  # finds first node with value
  def find(value)
    return nil if @head.nil?

    # iterates through and returns index, if it finds it. 
    current_node = @head
    index = 0
    until current_node == @tail do
      return index if current_node.value == value

      current_node = current_node.next_node
      index += 1
    end
    # returns nil if not found
    @tail.value == value ? index : nil
  end

  # puts in a single string 
  def to_s
    return 'Linked List is empty' if @head.nil?

    string = ''
    current_node = @head
    size.times do
      string += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    "#{string} nil"
  end


  # inserts value as new node at index
  def insert_at(value, index)
    # creates node to be inserted
    new_node = Node.new(value)

    # checks if it's just a prepend
    if index == 0
      self.prepend(value)
      return true
    end

    # checks if it's just an append
    size = self.size
    if index == size-1
      self.append(value)
      return true
    end

    # make variables for loop
    current_index = 0
    current_node = @head

    # loops through entire linked list
    (size - 1).times do
      # checks if the insert index has been reached. If it has, it inserts
      if index == current_index
        new_node.next_node = current_node
        # makes new node the next node of the previous node.
        self.at(index - 1).next_node = new_node
        return true
      end
      # changes variables
      current_index += 1
      current_node = current_node.next_node
    end
    # returns false if index was never reached (out of index)
    false
  end

  # removes the node at index
  def remove_at(index)
    return false if @head.nil?

    # iterates until index is reached
    current_node = @head
    index.times do
      return false if current_node.next_node.nil?

      current_node = current_node.next_node
    end

    # defining previous node - checks if at start first
    if current_node == @head
      @head = current_node.next_node
      return true
    else
      previous_node = at(index - 1)
    end
    # defining next node - checks if end first
    if current_node == @tail
      pop
      return true
    else
      new_next_node = current_node.next_node
    end

    # deletes normally - no edge case
    previous_node.next_node = new_next_node
    true
  end

  # prints all nodes and indexes of them for debugging or just simple use
  def print_all
    current_node = @head
    index = 0
    until current_node == @tail
      puts "Index: #{index}, value: #{current_node.value}"
      current_node = current_node.next_node
      index += 1
    end
    puts "Index: #{index}, value: #{current_node.value}" unless @tail.nil?
  end
end

# a node object used in LinkedList objects
class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

