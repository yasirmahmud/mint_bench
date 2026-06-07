module curve_synth_5188_20260112_000730_367188_w37744_attempt18 (
  input wire        clk_a,
  input wire        rst_n,
  input wire        clk_b,
  input wire [1:0]  data_in,
  output reg [1:0]  data_out
);

  // SYNTH_5188 violation: Invalid placement of event control statement
  // inside an asynchronous implicit style always block. The 'always' block
  // is asynchronous due to its sensitivity to 'posedge clk_a' and 'negedge rst_n'.
  always @(posedge clk_a or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 2'b00; // Asynchronous reset
    end else begin
      // The event control @(posedge clk_b) on the RHS of this non-blocking assignment
      // within an asynchronous always block triggers the SYNTH_5188 violation.
      data_out <= @(posedge clk_b) data_in;
    end
  end

endmodule
