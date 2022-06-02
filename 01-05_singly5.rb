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
  size = 10
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

  # 先頭から k 個削除
  k.times do
    delete_idx = next_ptr[0]
    next_ptr[0] = next_ptr[delete_idx]
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

puts solve(INPUT2)

=begin
片方向リスト実装編 step 5 (paizaランク B 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/list_primer/list_primer__singly_step5
問題文のURLをコピーする
 チャレンジする言語

得意な言語を選択してください
コードを書いて解いてみる
問題
 下記の問題をプログラミングしてみよう！
N 個の要素からなる数列 A が与えられます。
A のすべての要素を順に片方向リストの末尾へ追加したのち、先頭から 連続する K 個すべての要素を削除してください。
その後、片方向リストのデータを先頭から順にすべて出力してください。

片方向リストから先頭の要素を削除するには以下の画像のように

1. 「開始ノードの次のノード」を「開始ノードの 2 つ先のノード」に置き換える

をする必要があります。



入力される値
N K
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
・ K は 0 以上 N 以下
・ A_i は 1 以上 100 未満

入力例2
2 1
1
4

出力例2
4
=end
