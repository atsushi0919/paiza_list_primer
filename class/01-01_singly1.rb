# 片方向リスト実装編 step 1 (paizaランク C 相当)
# https://paiza.jp/works/mondai/list_primer/list_primer__singly_step1

INPUT1 = <<~"EOS"
  2
  4
  1
EOS
OUTPUT1 = <<~"EOS"
  4
  1
EOS

INPUT2 = <<~"EOS"
  2
  9
  1
EOS
OUTPUT2 = <<~"EOS"
  9
  1
EOS

class SinglyLinkedList
  SIZE = 1024
  START_PTR = 0
  END_PTR = SIZE - 1
  attr_accessor :data

  class Node
    attr_accessor :value, :next_ptr

    def initialize(value = nil, next_ptr = nil)
      @value = value
      @next_ptr = next_ptr
    end
  end

  def initialize
    @data = Array.new(SIZE) { Node.new }
    @empty_min_idx = 1
    @back = 0

    @data[START_PTR].value = -1
    @data[END_PTR].value = -1
    @data[START_PTR].next_ptr = END_PTR
    @data[END_PTR].next_ptr = -1
  end
end

def solve(input_str)
  _, *a = input_str.split.map(&:to_i)

  sll = SinglyLinkedList.new
  a
end

puts solve(STDIN.read)
