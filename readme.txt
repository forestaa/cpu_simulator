Super-Cool simulator for our 1st CPU!

Usage

$make
This command build "sim_asm" and "sim_machine".

If you want to build "sim_asm" xor "sim_machine", use command
$make sim_asm  xor $make sim_machine.


"sim_asm" is simulator for assembla code.
$./sim_asm ./test/test.s
If you use this command, "sim_asm" execute ./test/test.s, print instructions and "END".
If all instructions are normally executed, print "complete instructions" and contents of registers.

"sim_machine" is also simulator for machine code.
$./sim_machine ./test/output
If you use this command, "sim_machine" execute ./test/output, print binarydata.
If a instruction is executed, print that instruction, and if all instrucions are executed, print "complete instructions" and contents of registers.


$make clean
This command remove built files.

英語無理()

オプションについて！！
今あるオプションは以下の通りです

-h: help ヘルプらしい何かが出てきてプログラムが終了する
-s: step 最初からプログラムをステップ実行する。止まってる時に使えるコマンドは後述
-p: printflag プリントフラグを立てる。実行した命令を逐一出力する。デバッグ以外では切っておくのが吉。切らないと fib 30 すらプログラムの出力が終わらない。
-b n: breakpoint nをbreakpointに設定してプログラムを開始する。breakpointで使えるコマンドは後述

使い方はこう
./sim_machine -pb 10 (machinecodepath)
真ん中でオプションをつける。-p -b 10みたいに分けてもいい。最後だけは機械語のバイナリコードにしないとfopenできない。

謎のオプションを入れると文句言ってプログラムが終わる。-bに引数がないとbreakpointを0にして始める。

breakpointで使えるコマンドは以下の通り

step: 命令を一個実行する。次で止まる。入力なしでenterでもstep実行する。
pflagon: プリントフラグを立てる。breakpoint設定したあと、命令を出力せずに特定のとこまで進めて、そこから命令を出力しながらデバッグするのに使える(と思われる)。
pflagoff: プリントフラグを切る。デバッグ終わったら切ろう。
print: レジスタやメモリの中身を出力する。使い方はこう
print r3,  print f3,  print memory[3]
レジスタをソフトウェア名で指定したかったら言ってください。次に実行する命令や現在のpcが見たくなっても言ってください。なにか見たくなったら言ってください即時実装します。
break: breakpointを再設定します。使い方はこう
break 100
run: breakflagを切ります。デバッグ終わったらpflagoffしてからrunしよう


その他について
総命令数と各命令の実行数を出力するようにしたから頑張って高速化しような

レイトレでの入出力は標準入力と標準出力を使います。(どっかに書いてあった)
ですので、syscallでの入出力もstdin,stdoutを用いてます。

./sim_machine -p -b 10 ../compiler/suiteki/output < input.txt > result.txt

こんなふうにリダイレクトを使ってあげるとsyscallでの入出力が可能です。

sim_asmはそのうち使えるようにしますので少々お待ちください()
