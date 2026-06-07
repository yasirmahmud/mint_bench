module curve_synth_5064_20260111_225001_932987_w15680_attempt12 (
  input wire clk,
  input wire rst_n,
  input wire in_data,
  output reg out_data
);

  // Synthesizable logic: a simple D-flip-flop with asynchronous reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 1'b0;
    end else begin
      out_data <= in_data;
    end
  end

  // This SystemVerilog immediate 'cover' statement is not synthesizable.
  // It will be ignored by synthesis tools, triggering the SYNTH_5064 violation.
  always @(posedge clk) begin
    cover (in_data == 1'b1); // Triggers SYNTH_5064
  end

endmodule
