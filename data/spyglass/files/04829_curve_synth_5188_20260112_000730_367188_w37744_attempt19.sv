module curve_synth_5188_20260112_000730_367188_w37744_attempt19 (
  input wire        clk,
  input wire        rst_n,
  input wire [7:0]  data_in,
  output reg [7:0]  data_out
);

  // SYNTH_5188 violation: Invalid placement of event control statement
  // inside an asynchronous implicit style always block.
  // This 'always' block is asynchronous due to its sensitivity to 'posedge clk' and 'negedge rst_n'.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Asynchronous reset condition
      data_out <= 8'h00;
    end else begin
      // The event control statement '@(posedge clk)' on the RHS of this non-blocking assignment
      // within an asynchronous always block triggers the SYNTH_5188 violation.
      data_out <= @(posedge clk) data_in;
    end
  end

endmodule
