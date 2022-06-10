# frozen_string_literal: true

class Node
  attr_accessor :next_node, :previous_node, :data

  def initialize(data = nil, next_node = nil, previous_node = nil)
    @data = data
    @next_node = next_node
    @previous_node = previous_node
  end

  def delete_next_node
    @next_node = nil
  end
end
