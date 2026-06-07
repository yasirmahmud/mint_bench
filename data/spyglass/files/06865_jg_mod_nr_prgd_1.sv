module full_case_pragma_example (input [1:0] sel, output reg out);
  always @* begin
    // synthesis full_case
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      // Missing 2'b10 and 2'b11, but full_case pragma is used.
    endcase
  end
endmodule
