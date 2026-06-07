module vc_Mux4
#(
  parameter p_nbits = 32
)
(
  input  wire [p_nbits-1:0] in0,
  input  wire [p_nbits-1:0] in1,
  input  wire [p_nbits-1:0] in2,
  input  wire [p_nbits-1:0] in3,
  input  wire [1:0]         sel,
  output wire [p_nbits-1:0] out
);

  assign out = (sel == 2'b00) ? in0 :
               (sel == 2'b01) ? in1 :
               (sel == 2'b10) ? in2 :
               (sel == 2'b11) ? in3 :
               '0;

endmodule
