module STARC_2_8_4_1b_ex1 (input [3:0] in, output reg [1:0] out);
 always @* begin
  out = 2'b0; // Default assignment for 'out'
  case(in[3]) // Using 'case' to avoid casex ambiguities
    1'b1: out = 2'b1;
    // The 1'b0 case is implicitly handled by the initial 'out = 2'b0' assignment.
    1'bx: out = 2'b1; // Preserve casex behavior: 'X' in input matched 4'b1?? first
    1'bz: out = 2'b1; // Preserve casex behavior: 'Z' in input matched 4'b1?? first
  endcase
 end
endmodule
