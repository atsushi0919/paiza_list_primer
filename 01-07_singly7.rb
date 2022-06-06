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

=begin
片方向リスト実装編 step 7 (paizaランク B 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/list_primer/list_primer__singly_step7
問題文のURLをコピーする
 チャレンジする言語

得意な言語を選択してください
コードを書いて解いてみる
問題
 下記の問題をプログラミングしてみよう！
N 個の要素からなる数列 A と数値 P が与えられます。 A のすべての要素を順に片方向リストの末尾へ追加したのち、以下の操作をおこなってください。

・先頭から P 番目のノードを削除してください。

その後、片方向リストのデータを先頭から順にすべて出力してください。

入力される値
N P
A_1
A_2
...
A_N

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
操作後の片方向リスト B 内のノードの値を先頭から順に改行区切りで出力してください。末尾に改行を入れ、余計な文字、空行を含んではいけません。B に要素が存在しない場合は、なにも出力する必要はありません。


B_1
B_2
...
条件
すべてのテストケースにおいて、以下の条件をみたします。

・ N は 1 以上 100 未満
・ P は 1 以上 N 以下
・ A_i は 1 以上 100 未満

入力例1
4 3
8
10
7
2

出力例1
8
10
2

入力例2
5 4
2
10
4
10
5

出力例2
2
10
4
5
=end
