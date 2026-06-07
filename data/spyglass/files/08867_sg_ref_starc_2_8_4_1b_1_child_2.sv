module STARC_2_8_4_1b_ex1 (input [3:0] in, output reg [1:0] out);
 always @* begin
  casez(in[3]) // Using 'casez' to correctly handle 'x' and 'z' values from input 'in[3]' via default
    1'b0: out = 2'b0; // If in[3] is '0', out is '0'
    default: out = 2'b1; // For any other value of in[3] ('1', 'x', 'z'), out is '1'
  endcasez
 end
endmodule
