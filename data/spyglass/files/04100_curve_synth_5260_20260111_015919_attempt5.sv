module curve_synth_5260_20260111_015919_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire in_data,
  output reg out_data
);

  // Minimal synthesizable logic to avoid 'ErrorAnalyzeBBox' from flagging the entire module as unsynthesizable.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 1'b0;
    end else begin
      out_data <= in_data;
    end
  end

  // SYNTH_5260 violation: Declaring a 'string' variable.
  // The 'string' data type is a SystemVerilog feature and is not supported for synthesis in Verilog-2001.
  // This declaration will trigger SYNTH_5260 exactly once.
  string my_string_variable = "This string variable is not synthesizable in Verilog-2001.";

endmodule
