# 片方向リスト実装編 step 6 (paizaランク B 相当)
# https://paiza.jp/works/mondai/list_primer/list_primer__singly_step6

INPUT1 = <<~"EOS"
  5 3 6
  1
  4
  5
  2
  3
EOS
OUTPUT1 = <<~"EOS"
  1
  4
  6
  5
  2
  3
EOS

def solve(input_str)
  size = 1024
  value = Array.new(size)
  next_ptr = Array.new(size)
  value[0] = -1
  value[-1] = -1
  next_ptr[0] = size - 1
  next_ptr[-1] = -1
  back = 0
  empty_min_idx = 1

  n, pt, x, *a = input_str.split.map(&:to_i)
  # a を挿入
  a.each do |e|
    value[empty_min_idx] = e
    next_ptr[empty_min_idx] = next_ptr[back]
    next_ptr[back] = empty_min_idx
    back = empty_min_idx
    empty_min_idx += 1
  end

  # pt の直前に挿入
  prev_ptr = next_ptr.index(pt) || back
  value[empty_min_idx] = x
  next_ptr[empty_min_idx] = next_ptr[prev_ptr]
  next_ptr[prev_ptr] = empty_min_idx
  empty_min_idx += 1

  # 先頭から出力
  result = []
  idx = next_ptr[0]
  while value[idx] != -1
    result << value[idx]
    idx = next_ptr[idx]
  end
  result
end

puts solve(STDIN.read)
