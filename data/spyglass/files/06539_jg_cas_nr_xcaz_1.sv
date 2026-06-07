module cas_nr_xcaz_example_1 (
  input [1:0] sel,
  output reg out_val
);

  always_comb begin
    out_val = 1'b0;
    casez (sel)
      2'b01: out_val = 1'b0;
      2'b1x: out_val = 1'b1; // 'x' in casez item expression
      default: out_val = 1'b0;
    endcase
  end

endmodule
