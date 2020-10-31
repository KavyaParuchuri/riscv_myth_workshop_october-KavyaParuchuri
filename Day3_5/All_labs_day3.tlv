\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   
   `include "sqrt32.v"; //comment this out for regular examples we only need m4_makerchip_module
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)

   


\TLV
   $reset = *reset; //comment this for validity examples
   //**********************************************************
   //Combinational logic labs (slides 	
   //Inverter	
   //$out = ! $in1;
   //$out = $in1 || $in2;
   //$out = $in1 && $in2;
   //$out = $in1 ^ $in2;
   //Vectors	
   //$out[4:0] = $in1[3:0] + $in2[3:0];	
   //Mux	
   //$out = $sel ? $in1 : $in2;	
   //$out[7:0] = $sel ? $in1[7:0] : $in2[7:0];
   
   //Inverter
   //$out = !
   //*********************************************************
   
   //*********************************************************
   //Combinational  calculator - Infers priority Enc (check)
   /*$out[31:0] =
      $op[1:0] == 2'b00
         ? $sum[31:0]
            : ($op[1:0] == 2'b01
               ? $diff[31:0]
                  : ($op[1:0] == 2'b10
                     ? $prod[31:0]
                     : $quot[31:0]
                     )
              ); */
   //Combinational calculator - Infer Mux 
   /*$out[31:0] = $op[1] ?
               ($op[0] ? $quot[31:0] : $prod[31:0] ) :
               ($op[0] ? $diff[31:0] : $sum[31:0] ) ;
   
   //comb calc - operations
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   
   //inputs
   $val1[31:0] = $rand1[3:0];
   $val2[31:0] = $rand2[3:0]; */
   //***********************************************************
   
   //***********************************************************
   //Seq Counter
   //$val[15:0] = $reset ? 0 : >>1$val + 1'b1;
   //***********************************************************
   
   //***********************************************************
   //Sequential calculator
   /*
   $val1[31:0] = >>1$out[31:0];  
   //inputs
   //$val1[31:0] = $rand1[3:0];
   $val2[31:0] = $rand2[3:0];
   
   //comb calc - operations
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   
   //Infers Priority Encoder - check
   $out[31:0] = $reset ? 32'h00000000 :
                ($op[1:0] == 2'b00 ? $sum[31:0] :
                ($op[1:0] == 2'b01 ? $diff[31:0] :
                ($op[1:0] == 2'b10 ? $prod[31:0] :
                ( $quot[31:0])
                )));
   //Infers Mux
   $out[31:0] = $reset ? 32'h00000000 :
                $op[1] ?
               ($op[0] ? $quot[31:0] : $prod[31:0] ) :
               ($op[0] ? $diff[31:0] : $sum[31:0] ) ;
   
   */
   //***************************************************************
   
   //***************************************************************
   //Error signals in computation pipeline
   /*|comp
      @1
         $err1 = $bad_input || $illegal_op ;
      @3
         $err2 = $overflow || $err1;
      @6
         $err3 = $div_by_zero || $err2; */
   //****************************************************************
   
   //****************************************************************
   /*|calc
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
         
         //Sequential calculator
         //Infers Priority Encoder - Check
         $out[31:0] = *reset ? 32'h00000000 :
               ($op[1:0] == 2'b00 ? $sum[31:0] :
               ($op[1:0] == 2'b01 ? $diff[31:0] :
               ($op[1:0] == 2'b10 ? $prod[31:0] :
               ( $quot[31:0])
               )));
         
         //Infers Mux
         $out[31:0] = $reset ? 32'h00000000 :
                $op[1] ?
               ($op[0] ? $quot[31:0] : $prod[31:0] ) :
               ($op[0] ? $diff[31:0] : $sum[31:0] ) ;
         
         $cnt = *reset ? 0 : >>1$cnt + 1'b1;*/
   //**************************************************************
   
   //****************************************************************
   //2-cycle calculator
   /*|calc
      //Memory for output = val1 for seq calculator
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
         $valid = *reset ? 0 : >>1$valid + 1'b1;
         $clearsigtomux = !$valid || *reset;
      @2
         
         //Infers Mux
         $out[31:0] = $clearsigtomux ? 32'h00000000 :
                $op[1] ?
               ($op[0] ? $quot[31:0] : $prod[31:0] ) :
               ($op[0] ? $diff[31:0] : $sum[31:0] ) ;*/
   
   
   //**************************************************************
   //**************************************************************
   //Validity - Examples
   /*|calc
      @1
         $reset = *reset;
      ?$valid
         @1
            $aa_sq[31:0] = $aa[3:0] * $aa;
            $bb_sq[31:0] = $bb[3:0] * $bb;
         @2
            $cc_sq[31:0] = $aa_sq + $bb_sq;
         @3
            $cc[31:0] = sqrt($cc_sq);
            
      @4
         $tot_dist[63:0] = 
              *reset ? '0 : 
              $valid ? >>1$tot_dist[63:0] + $cc[31:0] : 
                       >>1$tot_dist[63:0];

   *passed = *cyc_cnt > 16'd30; */
   
   //**************************************************************
   //2-cycle calculator with validity
   /*|calc
      @1
         $reset = *reset;
         $valid = *reset ? 0 : >>1$valid + 1'b1;
         $clearsigtomux = $valid || *reset;
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
                  ($op[0] ? $diff[31:0] : $sum[31:0] ) ; */
   
   //**************************************************************
   //2-cycle calculator with validity - with single value memory
   /*|calc
      @1
         $reset = *reset;
         $valid = *reset ? 0 : >>1$valid + 1'b1;
         $clearsigtomux = $valid || *reset;
      //Memory for output = val1 for seq calculator
      ?$valid
         @1   
            $val1[31:0] = >>2$out[31:0];
            $mem[31:0] = >>2$out[31:0];
            $recall[31:0] = >>2$mem[31:0];
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
            $out[31:0] = ($clearsigtomux) ? 32'h00000000 :
                         ($op[2:0] == 3'b101)? $mem[31:0] :
                         ($op[2:0] == 3'b100)? $recall[31:0] :
                         ($op[2:0] == 3'b011)? $quot[31:0] :
                         ($op[2:0] == 3'b010)? $prod[31:0] :
                         ($op[2:0] == 3'b001)? $diff[31:0] :
                         $sum[31:0] ; */
   //**************************************************************
            
            
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40; //uncomment this for regular code apart from validity examples
   *failed = 1'b0;
   //m4+cal_viz(@3)
\SV
   endmodule
