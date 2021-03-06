# frozen_string_literal: true
require 'pry-byebug'
require_relative 'game_history_node'
class GameHistory
  attr_accessor :head, :tail

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  def insert(data)
    if @head.nil?
      @head = Node.new(data)
    else
      node = @head
      until node.next_node.nil?
        node = node.next_node 
      end 
      node.next_node = Node.new(data)
      node.next_node.previous_node = node
      @tail = node.next_node
    end
  end

  def rewind
    if @head.next_node.nil?
      puts 'No move to return to'
    else
      node = @head
      until node.next_node.nil?
        if(node.next_node.next_node.nil?)
          node.delete_next_node
          return node
        else
          node = node.next_node
        end
      end
    end
  end

  def return_history(requested_history = 1)
    node = @tail
    found_history = []
    counter = 0
    until counter == requested_history || node.nil?
      found_history.push(node.data)
      counter += 1
      node = node.previous_node
    end
    found_history
  end
end
