module multiple_iff_violation_2 (
  input sys_clk,
  input async_rst,
  input clk_gate_en,
  input rst_gate_en,
  input d_in,
  output logic q_out
);

  always_ff @(posedge sys_clk iff clk_gate_en or posedge async_rst iff rst_gate_en) begin
    if (async_rst) begin
      q_out <= 1'b0;
    end else begin
      q_out <= d_in;
    end
  end

endmodule
