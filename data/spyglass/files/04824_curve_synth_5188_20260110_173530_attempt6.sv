module curve_synth_5188_20260110_173530_attempt6 (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      // SYNTH_5188: Invalid placement of event control statement in RHS of assignment
      data_out <= @(posedge clk) data_in;
    end
  end

endmodule
