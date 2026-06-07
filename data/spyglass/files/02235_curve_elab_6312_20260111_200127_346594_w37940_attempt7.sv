module curve_elab_6312_20260111_200127_346594_w37940_attempt7 (
  input clk,
  input en,
  input [7:0] in_data,
  output reg [7:0] out_data
);

  // The 'iff' construct in the always sensitivity list is a SystemVerilog feature
  // and is not supported in Verilog-2001. This triggers ELAB_6312.
  always @(posedge clk iff en) begin
    out_data <= in_data;
  end

endmodule
