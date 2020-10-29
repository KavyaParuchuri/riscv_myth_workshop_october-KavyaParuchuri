  \m4_TLV_version 1d: tl-x.org
\SV
   // A Fibonacci Sequence example.
   // Each cycle we generate a new number in the sequence,
   // where each new value is the sum of the previous two.
   // (1, 1, 2, 3, 5, 8, ...)

   m4_makerchip_module
\TLV
!  $reset = *reset;
   
  |calc
      @1
         //Seq_Calculator
         //Memory for output = val1 for seq calculator
         $val1[31:0] = >>1$out[31:0];
         //inputs
         //$val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];
         
         //comb calc - operations
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
         
         $out[31:0] = $reset ? 32'h00000000 :
                $op[1] ?
               ($op[0] ? $quot[31:0] : $prod[31:0] ) :
               ($op[0] ? $diff[31:0] : $sum[31:0] ) ;
         
         $cnt = *reset ? 0 : >>1$cnt + 1'b1;
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
