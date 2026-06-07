module curve_synth_5188_20260110_173530_attempt9 (
  input clk,
  input rst_n,
  input enable,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // SYNTH_5188: Invalid placement of event control statement inside asynchronous implicit style always block.
  // This always block is an "asynchronous implicit style" block due to the inclusion of both
  // a clock edge (posedge clk) and an asynchronous reset edge (negedge rst_n) in its sensitivity list.
  // The assignment 'data_out <= @(posedge clk) data_in;' places an event control (@) directly
  // in the RHS of the assignment, which is specifically targeted by SYNTH_5188 in this asynchronous context.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'b0;
    end else if (enable) begin
      data_out <= @(posedge clk) data_in; // Target violation
    end else begin
      data_out <= 8'hFF;
    end
  end

endmodule
