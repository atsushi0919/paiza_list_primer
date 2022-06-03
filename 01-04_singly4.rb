# 片方向リスト実装編 step 4 (paizaランク B 相当)
# https://paiza.jp/works/mondai/list_primer/list_primer__singly_step4

INPUT2 = <<~"EOS"
  5 3
  6
  2
  8
  4
  2
EOS
OUTPUT2 = <<~"EOS"
  6
  2
  8
  4
  2
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

  n, k, *a = input_str.split.map(&:to_i)
  # 末尾に挿入
  a.each do |e|
    value[empty_min_idx] = e
    next_ptr[empty_min_idx] = next_ptr[back]
    next_ptr[back] = empty_min_idx
    back = empty_min_idx
    empty_min_idx += 1
  end

  # 末尾から k 個削除
  k.times do
    prev_idx = next_ptr.index(back)
    next_ptr[prev_idx] = next_ptr[back]
    back = prev_idx
  end

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
