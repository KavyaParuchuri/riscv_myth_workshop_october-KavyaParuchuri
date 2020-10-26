\m4_TLV_version 1d: tl-x.org
\SV


   m4_makerchip_module
\TLV
!  $reset = *reset;
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
                ($op[1:0] == 2'b00 ? $sum[31:0] : 
                ($op[1:0] == 2'b01 ? $diff[31:0] : 
                ($op[1:0] == 2'b10 ? $prod[31:0] :
                ( $quot[31:0])
                )));
   
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;

\SV
   endmodule
