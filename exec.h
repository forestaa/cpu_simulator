#ifndef __EXEC_H__
#define __EXEC_H__

#include "isa.h"

static inline int exec(Program p)
{
  if(p.inum == 0) {
    lui(p.op1, p.op2);
    icount[0]++;
  } else if(p.inum == 1) {
    ori(p.op2, p.op1, p.op3);
    icount[1]++;
  } else if(p.inum < 10) {
    if(p.inum < 6) {
      if(p.inum < 4) {
        if(p.inum == 2) {
          lw(p.op2, p.op3, p.op1);
          icount[2]++;
        } else {
          add(p.op3, p.op1, p.op2);
          icount[3]++;
        }
      } else {
        if(p.inum == 4) {
          lwc1(p.op2, p.op3, p.op1);
          icount[4]++;
        } else {
          or(p.op3, p.op1, p.op2);
          icount[5]++;
        }
      }
    } else {
      if(p.inum < 8) {
        if(p.inum == 6) {
          sw(p.op2, p.op3, p.op1);
          icount[6]++;
        } else {
          addi(p.op2, p.op1, p.op3);
          icount[7]++;
        }
      } else {
        if(p.inum == 8) {
          mov_s(p.op2, p.op1);
          icount[8]++;
        } else {
          bne(p.op1, p.op2, p.op3);
          icount[9]++;
        }
      }
    }
  } else if(p.inum < 18) {
    if(p.inum < 14) {
      if(p.inum < 12) {
        if(p.inum == 10) {
          swc1(p.op2, p.op3, p.op1);
          icount[10]++;
        } else {
          jr(p.op1);
          icount[11]++;
        }
      } else {
        if(p.inum == 12) {
          jal(p.op1);
          icount[12]++;
        } else {
          mul_s(p.op3, p.op2, p.op1);
          icount[13]++;
        }
      }
    } else {
      if(p.inum < 16) {
        if(p.inum == 14) {
          j(p.op1);
          icount[14]++;
        } else {
          bc1t(p.op1);
          icount[15]++;
        }
      } else {
        if(p.inum == 16) {
          c_olt_s(p.op2, p.op1);
          icount[16]++;
        } else {
          add_s(p.op3, p.op2, p.op1);
          icount[17]++;
        }
      }
    }
  } else if(p.inum < 26) {
    if(p.inum < 22) {
      if(p.inum < 20) {
        if(p.inum == 18) {
          sub_s(p.op3, p.op2, p.op1);
          icount[18]++;
        } else {
          mtc1(p.op1, p.op2);
          icount[19]++;
        }
      } else {
        if(p.inum == 20) {
          cvt_s_w(p.op2, p.op1);
          icount[20]++;
        } else {
          neg_s(p.op2, p.op1);
          icount[21]++;
        }
      }
    } else {
      if(p.inum < 24) {
        if(p.inum == 22) {
          c_eq_s(p.op2, p.op1);
          icount[22]++;
        } else {
          sub(p.op3, p.op1, p.op2);
          icount[23]++;
        }
      } else {
        if(p.inum == 24) {
          jalr(p.op2, p.op1);
          icount[24]++;
        } else {
          bgtz(p.op1, p.op2);
          icount[25]++;
        }
      }
    }
  } else if(p.inum < 34) {
    if(p.inum < 30) {
      if(p.inum < 28) {
        if(p.inum == 26) {
          sqrt_s(p.op2, p.op1);
          icount[26]++;
        } else {
          inv_s(p.op2, p.op1);
          icount[27]++;
        }
      } else {
        if(p.inum == 28) {
          sll(p.op2, p.op1, p.op3);
          icount[28]++;
        } else {
          srl(p.op2, p.op1, p.op3);
          icount[29]++;
        }
      }
    } else {
      if(p.inum < 32) {
        if(p.inum == 30) {
          bltz(p.op1, p.op2);
          icount[30]++;
        } else {
          beq(p.op1, p.op2, p.op3);
          icount[31]++;
        }
      } else {
        if(p.inum == 32) {
          trunc_w_s(p.op2, p.op1);
          icount[32]++;
        } else {
          blez(p.op1, p.op2);
          icount[33]++;
        }
      }
    }
  } else if(p.inum < 42) {
    if(p.inum < 38) {
      if(p.inum < 36) {
        if(p.inum == 34) {
          and(p.op3, p.op1, p.op2);
          icount[34]++;
        } else {
          bgez(p.op1, p.op2);
          icount[35]++;
        }
      } else {
        if(p.inum == 36) {
          syscall();
          icount[36]++;
        } else {
          mfc1(p.op1, p.op2);
          icount[37]++;
        }
      }
    } else {
      if(p.inum < 40) {
        if(p.inum == 38) {
          slt(p.op3, p.op1, p.op2);
          icount[38]++;
        } else {
          xor(p.op3, p.op1, p.op2);
          icount[39]++;
        }
      } else {
        if(p.inum == 40) {
          sllv(p.op3, p.op2, p.op1);
          icount[40]++;
        } else {
          addiu(p.op2, p.op1, p.op3);
          icount[41]++;
        }
      }
    }
  } else {
    if(p.inum == 42) {
      c_ole_s(p.op2, p.op1);
      icount[42]++;
    } else if(p.inum == 43) {
      bc1f(p.op1);
      icount[43]++;
    } else if(p.inum == 44)
      return 1;
    else {
      fprintf(stderr, "this instruction is not defined pc = [%d] instrnumber %d\n", pc, p.inum);
      pc++;
    }
  }

  instructions++;

  return 0;
}

#endif
