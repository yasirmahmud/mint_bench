module fpu_dec(		dp_out,
			mfinish,
			reset_l,
			valid_opcode,
			two_cycle_in,
			fpuhold,
			fpkill,
               		fpu_state,
			opcode_look,
			nx_opcode_look,
			int_out,
			long_out,
			fpbusyn,
			cyc1_rdy,
			clk,
			so,
			sin,
			sm);

  input		 clk;
  input          dp_out;         //  Indicates that two output cycles are needed.
  input          mfinish;        //  Indicates completion of microcoded calculation stages.
  input          valid_opcode;   // Indicates Valid opcode input.
  input          two_cycle_in;   // Indicates that a two input cycle transaction is needed.
  input          fpuhold, fpkill, reset_l;
  input          int_out, long_out;  // Int and long signals.
  input         sm, sin;
  output	so;
  output  [7:0]  fpu_state;
  output         opcode_look, fpbusyn, cyc1_rdy;
  output         nx_opcode_look;

  reg     [7:0]  next_fpu_state;
  wire	  [7:0]  next_fpu_statep, fpu_state;

//*********************************************************************
// Access State Machine definition
//*********************************************************************

parameter [7:0]  // triquest enum FPU_STATE_ENUM
		S0 =    8'b0000_0001,       // idle
                S1 =    8'b0000_0010,       
                S2 =    8'b0000_0100,     
                S3 =    8'b0000_1000,    
                S4 =    8'b0001_0000,
                S5 =    8'b0010_0000,
                S6 =    8'b0100_0000,
                S7 =    8'b1000_0000;

`define s0 0
`define s1 1
`define s2 2
`define s3 3
`define s4 4
`define s5 5
`define s6 6
`define s7 7


mj_s_mux2_d_8 fpumux( .mx_out(next_fpu_statep),
                        .sel(fpkill),
                        .in0(next_fpu_state),
                        .in1(S0));

//triquest state_vector {fpu_state[7:0]} FPSTATE enum FPU_STATE_ENUM
mj_s_ff_snre_d_8 ff_fpstate (.out(fpu_state),
                        .din(next_fpu_statep),
                        .lenable(!fpuhold),
                        .reset_l(reset_l),
                        .clk(clk));

  always @(dp_out or mfinish or valid_opcode or two_cycle_in
           or fpu_state or int_out or long_out) 
    begin
     case(1'b1)  	// synopsys full_case parallel_case
         fpu_state[`s0]:  begin
                     if(!valid_opcode)              
			next_fpu_state = S0;
                     else if(two_cycle_in)              
			next_fpu_state = S1;
                     else                               
			next_fpu_state = S2;
         end

         fpu_state[`s1]:                      
		     next_fpu_state = S2;

         fpu_state[`s2]:  begin
                  if(mfinish && long_out)  
			next_fpu_state = S6;
                  else if(mfinish && int_out)   
			next_fpu_state = S7;
                  else if(mfinish && dp_out)    
			next_fpu_state = S4;
                  else if(mfinish)              
			next_fpu_state = S3;
                  else                          
			next_fpu_state = S2;
         end

         fpu_state[`s3]:  begin
//              if(valid_opcode && !two_cycle_in)             
//			next_fpu_state = S2;
//              else if(valid_opcode && two_cycle_in)              
//			next_fpu_state = S1;
//              else                               
			next_fpu_state = S0;
         end

         fpu_state[`s4]: next_fpu_state = S5; 

         fpu_state[`s5]:  begin
//                if(valid_opcode && !two_cycle_in)             
//			next_fpu_state = S2;
//                else if(valid_opcode && two_cycle_in)              
//			next_fpu_state = S1;
//                else                               
			next_fpu_state = S0;
         end

         fpu_state[`s6]: next_fpu_state = S7;

         fpu_state[`s7]:  begin
//               if(valid_opcode && !two_cycle_in)             
//			next_fpu_state = S2;
//                else if(valid_opcode && two_cycle_in)              
//			next_fpu_state = S1;
//                else                               
			next_fpu_state = S0;
         end

         default: next_fpu_state = S0;
     endcase
   end

//   assign opcode_look =    fpu_state[`s0] || fpu_state[`s3] ||
//                           fpu_state[`s5] || fpu_state[`s7];
//   assign nx_opcode_look =    next_fpu_state[`s0] || next_fpu_state[`s3] ||
//                           next_fpu_state[`s5] || next_fpu_state[`s7];

   assign opcode_look =    fpu_state[`s0];

   assign nx_opcode_look =    next_fpu_state[`s0];


//   assign fpbusyn     = !(next_fpu_state[`s1] || next_fpu_state[`s2] || 
//			fpu_state[`s1] || (!mfinish && fpu_state[`s2]));
//   assign fpbusyn     = !(fpu_state[`s1] || (!mfinish && fpu_state[`s2]));

   assign fpbusyn     = !(next_fpu_state[`s1] || next_fpu_state[`s2] || 
			fpu_state[`s1] || (fpu_state[`s2]));

   assign cyc1_rdy    = (fpu_state[`s1]);
             
endmodule
