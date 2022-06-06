# 片方向リスト実装編 step 3 (paizaランク B 相当)
# https://paiza.jp/works/mondai/list_primer/list_primer__singly_step3

INPUT1 = <<~"EOS"
  5
  3
  2
  5
  5
  2
EOS
OUTPUT1 = <<~"EOS"
  3
  2
  5
  5
  2
EOS

INPUT2 = <<~"EOS"
  2
  4
  9
EOS
OUTPUT2 = <<~"EOS"
  4
  9
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

  def push_front(v)
    @data[@empty_min_idx].value = v
    @data[@empty_min_idx].next_ptr = @data[START_PTR].next_ptr
    @data[START_PTR].next_ptr = @empty_min_idx
    @back = @empty_min_idx if @data[@empty_min_idx].next_ptr == END_PTR
    @empty_min_idx += 1
  end

  def delete_back
    current_ptr = START_PTR
    while current_ptr != END_PTR
      if @data[current_ptr].next_ptr == @back
        @back = current_ptr
        @data[current_ptr].next_ptr = END_PTR
        return
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
  _, *a = input_str.split.map(&:to_i)

  sll = SinglyLinkedList.new
  a.each { |v| sll.push_front(v) }
  sll.list_values
end

puts solve(STDIN.read)

=begin

問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:

問題文のURLをコピーする
 チャレンジする言語

得意な言語を選択してください
コードを書いて解いてみる
問題
下記の問題をプログラミングしてみよう！
N 個の要素からなる数列 A が与えられます。
A のすべての要素を順に片方向リストの先頭へ追加したのち、片方向リストのデータをすべて出力してください。

片方向リストの先頭に要素 Y を追加するには以下の画像のように

1. 配列 value 変数の empty_min_idx 番目に要素を代入
2. 配列 next_ptr を変更
3. 変数 empty_min_idx を変更

をする必要があります。



入力される値
N
A_1
A_2
...
A_N

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
操作後の片方向リスト B 内のノードの値を先頭から順に改行区切りで出力してください。末尾に改行を入れ、余計な文字、空行を含んではいけません。


B_1
B_2
...
条件
すべてのテストケースにおいて、以下の条件をみたします。

・ N は 1 以上 100 未満
・ A_i は 1 以上 100 未満

入力例1
5
3
2
5
5
2

出力例1
3
2
5
5
2

入力例2
2
4
9

出力例2
4
9
=end
