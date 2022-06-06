# 片方向リスト実装編 step 7 (paizaランク B 相当)
# https://paiza.jp/works/mondai/list_primer/list_primer__singly_step7

INPUT1 = <<~"EOS"
  4 3
  8
  10
  7
  2
EOS
OUTPUT1 = <<~"EOS"
  8
  10
  2
EOS

INPUT2 = <<~"EOS"
  5 4
  2
  10
  4
  10
  5
EOS
OUTPUT2 = <<~"EOS"
  2
  10
  4
  5
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

  def push_back(v)
    @data[@empty_min_idx].value = v
    @data[@back].next_ptr = @empty_min_idx
    @data[@empty_min_idx].next_ptr = END_PTR
    @back = @empty_min_idx
    @empty_min_idx += 1
  end

  def erase(pos)
    current_ptr = START_PTR
    0.upto(pos) do |i|
      break if current_ptr == END_PTR
      if i == pos
        @data[current_ptr].next_ptr = @data[@data[current_ptr].next_ptr].next_ptr
        break
      end
      current_ptr = @data[current_ptr].next_ptr
    end
  end

  def list_values
    result = []
    current_ptr = START_PTR
    while current_ptr != END_PTR
      if current_ptr != START_PTR
        result << @data[current_ptr].value
      end
      current_ptr = @data[current_ptr].next_ptr
    end
    result
  end
end

def solve(input_str)
  _, q, *a = input_str.split.map(&:to_i)

  sll = SinglyLinkedList.new
  # 末尾に追加
  a.each { |v| sll.push_back(v) }
  # q 番目を削除
  sll.erase(q - 1)

  sll.list_values
end

puts solve(STDIN.read)
