INPUT1 = <<~"EOS"
  2 1
  1
  2
  1 1 1
EOS
OUTPUT1 = <<~"EOS"
  1
  1
  2
EOS

INPUT2 = <<~"EOS"
  3 1
  1
  1
  2
  2 1
EOS
OUTPUT2 = <<~"EOS"
  1
  2
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

  def insert(pos, val)
    @data[@empty_min_idx].value = val
    current_ptr = START_PTR
    0.upto(pos) do |i|
      break if current_ptr == END_PTR
      if i == pos
        @data[@empty_min_idx].next_ptr = @data[current_ptr].next_ptr
        @data[current_ptr].next_ptr = @empty_min_idx
        break
      end
      current_ptr = @data[current_ptr].next_ptr
    end
    @empty_min_idx += 1
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
  input_lines = input_str.split("\n")
  n, q = input_lines.shift.split.map(&:to_i)
  a = input_lines.shift(n).map(&:to_i)
  queries = input_lines.map { |e| e.split.map(&:to_i) }

  sll = SinglyLinkedList.new
  # 末尾に追加
  a.each { |v| sll.push_back(v) }

  # クエリ処理
  queries.each do |op, q, val|
    case op
    when 1
      # q 番目に挿入
      sll.insert(q - 1, val)
    when 2
      # q 番目のノードを削除
      sll.erase(q - 1)
    end
  end

  sll.list_values
end

puts solve(STDIN.read)

=begin
片方向リスト実装編 完成 (paizaランク B 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/list_primer/list_primer__singly_boss
問題文のURLをコピーする
 チャレンジする言語

得意な言語を選択してください
コードを書いて解いてみる
問題
 下記の問題をプログラミングしてみよう！
N 個の要素からなる数列 A と Q 個のクエリが与えられます。 A のすべての要素を順に片方向リストの末尾へ追加したのち、 Q 個のクエリを順に処理してください。各クエリは、以下の 2 つのどちらかです。

1. INSERT P X:
・クエリ処理開始時点での片方向リストに含まれるノード数を M とします。 P <= M の場合、片方向リストの先頭から P 番目のノードの前に要素 X を挿入してください。
・ P = M + 1 の場合、片方向リストの末尾に要素 X を挿入してください。

2. ERASE P:
・片方向リストの先頭から P 番目のノードを削除してください

すべてのクエリを処理したあと、片方向リストのデータを先頭から順にすべて出力してください。

入力される値
N Q
A_1
A_2
...
A_N
query_1
query_2
...
query_Q


1 行目に N, Q が与えられます。続く A 行に片方向リストの値を、その後に続く Q 行にクエリが与えられます。 各クエリは

1 P X

または
2 P


の形式で与えられ、最初の数値が 1 のとき INSERT 、 2 のとき ERASE を表します。 INSERT のときは続いて数値 P, X が与えられます。 ERASE のときは続いて数値 P が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
すべての操作後の片方向リスト B 内のノードの値を先頭から順に改行区切りで出力してください。末尾に改行を入れ、余計な文字、空行を含んではいけません。B に要素が存在しない場合は、なにも出力する必要がありません。


B_1
B_2
...
条件
すべてのテストケースにおいて、以下の条件をみたします。

・ N, Q は 1 以上 100 未満
・ A_i は 1 以上 100 未満
・クエリが INSERT のとき、クエリ処理開始時点での片方向リストに含まれるノード数を M とすると、 P は 1 以上 M + 1 以下
・クエリが INSERT のとき、 X は 1 以上 100 以下
・クエリが ERASE のとき、クエリ処理開始時点で片方向リストにノードが含まれる
・クエリが ERASE のとき、クエリ処理開始時点での片方向リストに含まれるノード数を M とすると、 P は 1 以上 M 以下

入力例1
2 1
1
2
1 1 1

出力例1
1
1
2

入力例2
3 1
1
1
2
2 1

出力例2
1
2
=end
