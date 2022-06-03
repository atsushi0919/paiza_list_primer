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

def solve(input_str)
  # 初期設定
  value = Array.new(1024)
  next_ptr = Array.new(1024)
  value[0] = -1
  value[-1] = -1
  next_ptr[0] = 1023
  next_ptr[-1] = -1
  back = 0
  empty_min_idx = 1

  # 入力・出力
  _, *a = input_str.split.map(&:to_i)
  a
end

puts solve(STDIN.read)
