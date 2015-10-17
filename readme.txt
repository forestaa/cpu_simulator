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
