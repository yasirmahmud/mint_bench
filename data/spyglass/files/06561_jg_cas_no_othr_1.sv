module missing_default_case1 (
  input [1:0] sel,
  output reg out_reg
);

  always_comb begin
    case (sel)
      2'b00: out_reg = 1'b0;
      2'b01: out_reg = 1'b1;
      // Missing default clause and not all values (2'b10, 2'b11) are covered
    endcase
  end

endmodule
