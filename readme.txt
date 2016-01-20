Super-Cool simulator for our 1st CPU!

Usage

$make
This command build "sim".

"sim" is a simulator for machine code.
$./sim ./test/output
If you use this command, "sim" execute ./test/output.
If all instrucions are executed, print "complete instructions" and contents of registers.

$make debug
If you use this command, "sim_debug" will be built.
"sim_debug" has many debug functions. See below if you want to know details.

$make clean
This command remove built files.

英語無理()

オプションについて！！(sim_debug)
今あるオプションは以下の通りです

-h: help ヘルプらしい何かが出てきてプログラムが終了する
-s: step 最初からプログラムをステップ実行する。止まってる時に使えるコマンドは後述
-p: printflag プリントフラグを立てる。実行した命令を逐一出力する。デバッグ以外では切っておくのが吉。切らないと fib 30 すらプログラムの出力が終わらない。
-b n: breakpoint nをbreakpointに設定してプログラムを開始する。breakpointで使えるコマンドは後述
-v: ロードした命令をpc付きでstderrに出力、どの命令が何番のpcになっているか確認できるよ
-i path: プログラムに与える入力。レイトレにsldファイル与えるときこれ使って。-i付けないと標準入力になるからsyscallのデバッグには付けなくてよいかな。
-o path: プログラムの出力をpathに吐くよ。レイトレの出力はこれで指定して。

使い方はこう
./sim_debug -pb 10 (machinecodepath)
真ん中でオプションをつける。-p -b 10みたいに分けてもいい。最後だけは機械語のバイナリコードにしないとfopenできない。

謎のオプションを入れると文句言ってプログラムが終わる。-bに引数がないとbreakpointを0にして始める。

breakpointで使えるコマンドは以下の通り

step: 命令を一個実行する。次で止まる。入力なしでenterでもstep実行する。step nでn回ステップするよ
pflagon: プリントフラグを立てる。breakpoint設定したあと、命令を出力せずに特定のとこまで進めて、そこから命令を出力しながらデバッグするのに使える(と思われる)。
pflagoff: プリントフラグを切る。デバッグ終わったら切ろう。
print: 現在のpcやレジスタ、メモリの中身を出力する。使い方はこう
print r3,  print f3,  print memory[3](最後に -fつけると、浮動小数表示する), print pc, print all(全てのレジスタの中身をint, floatと16進数で表示), print instr(これから行う命令を出力)
break: breakpointを再設定します。使い方はこう
break 100
run: breakflagを切ります。デバッグ終わったらpflagoffしてからrunしよう


その他について
総命令数と各命令の実行数を出力するようにしたから頑張って高速化しような


レイトレはrateraycerフォルダにMakefile作ってあるからそっち使おうな

三角関数のてすとについて

make test
でlib_testなるものが作られ、こいつにcosだけをアセンブルしたものを食わせると、-13から13までを0.01刻みで実行した結果を出力してくれます。使い方としては
./lib_test ../compiler/suiteki/output > cos_result.txt
のようにアウトリダイレクトしてあげて、出てきたものをgnuplotなどに食わせてあげるとグラフが出てきます。
テストしたいlibの書き方は、testディレクトリにあるcos_test.sみたいな感じでよいと思われます。
中でやっていることは、基本的にはsim_mashineと同じで、ただ命令をforloopで回して、1ループごとに$f12に0.01刻みで値を代入してあげて、1ループ終わったらprintfしてあげてます。オプションもデバッグ機能も普通に使えます。
