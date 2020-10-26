\m4_TLV_version 1d: tl-x.org
\SV
   // A Fibonacci Sequence example.
   // Each cycle we generate a new number in the sequence,
   // where each new value is the sum of the previous two.
   // (1, 1, 2, 3, 5, 8, ...)

   m4_makerchip_module
\TLV
!  $reset = *reset;
   //Sequential Counter
   $val[15:0] = $reset ? 0 : >>1$val + 1'b1;
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;

\SV
   endmodule
