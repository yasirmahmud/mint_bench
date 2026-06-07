module curve_synth_5064_20260111_225001_932987_w15680_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire in_data,
  output reg out_data
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 1'b0;
    end else begin
      out_data <= in_data;
    end
  end

  // The 'cover property' statement is a SystemVerilog Assertion (SVA) construct.
  // It is not synthesizable and will be ignored by synthesis tools,
  // triggering the SYNTH_5064 violation.
  cover property (@(posedge clk) (in_data && out_data));

endmodule
