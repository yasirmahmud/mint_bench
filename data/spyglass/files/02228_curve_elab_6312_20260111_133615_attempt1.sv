module curve_elab_6312_20260111_133615_attempt1 (
  input wire clk,
  input wire rst,
  input wire enable_clk,
  input wire d_in,
  output reg q_out
);

  // The 'iff' construct is a SystemVerilog feature and is not supported in Verilog-2001,
  // triggering an ELAB_6312 violation during elaboration.
  always @(posedge clk iff enable_clk or posedge rst) begin
    if (rst) begin
      q_out <= 1'b0;
    end else begin
      q_out <= d_in;
    end
  end

endmodule
