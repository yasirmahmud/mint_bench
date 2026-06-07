module divider_restoring #(
  parameter WN = 8,       // width of N [1]
  parameter WD = 6)       // width of D [1]
(
  input            clk,   // system synchronous clock
  input  [WN-1:0]  n_in,  // input value n [1]
  input  [WD-1:0]  d_in,  // input value d [1]
  output [WD-1:0]  r_out, // output value r [1]
  output [WN-1:0]  q_out);// output value q [1]

  parameter PO2WND = 2**(WN+WD);
  parameter PO2WN1 = 2**(WN-1);
  parameter PO2WN  = 2**(WN) - 1;

  wire [WN+WD-1:0] r,d; // range -1 to PO2WND-1 (!)
  wire [WN-1:0] q;
endmodule
