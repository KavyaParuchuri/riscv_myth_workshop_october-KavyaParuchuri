\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   //**************************
   `include "sqrt32.v"; //comment this out for regular examples we only need m4_makerchip_module
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   //**************************


\TLV
   $reset = *reset; //comment this for validity examples

   //**************************************************************
   //2-cycle calculator with validity
   |calc
      @1
         $reset = *reset;
         $valid = *reset ? 0 : >>1$valid + 1'b1;
         $clearsigtomux = !$valid || *reset;
      //Memory for output = val1 for seq calculator
      ?$valid
         @1   
            $val1[31:0] = >>2$out[31:0];
            //inputs
            //$val1[31:0] = $rand1[3:0];
            $val2[31:0] = $rand2[3:0];
            //comb calc - operations
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            //Seq_Calculator
            //$valid = *reset ? 0 : >>1$valid + 1'b1;
            //$clearsigtomux = !$valid || *reset;
         @2
            //Infers Mux
            $out[31:0] = $clearsigtomux ? 32'h00000000 :
                   $op[1] ?
                  ($op[0] ? $quot[31:0] : $prod[31:0] ) :
                  ($op[0] ? $diff[31:0] : $sum[31:0] ) ;
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40; //uncomment this for regular code apart from validity examples
   *failed = 1'b0;
\SV
   endmodule
