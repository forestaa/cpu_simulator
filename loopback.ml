let rec loopback n = 
  if n > 0 then let a = read_int () in print_int a; print_char 10; loopback (n-1)
           else ()
in loopback 325
