module curve_synth_5188_20260112_000730_367188_w37744_attempt20 (
  input wire        clk,
  input wire        rst_n,
  input wire        enable_in,
  input wire [7:0]  data_in,
  output reg [7:0]  data_out
);

  // This 'always' block is sensitive to both a positive clock edge and a negative reset edge,
  // making it an asynchronous sequential block.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Asynchronous reset condition
      data_out <= 8'h00;
    end else if (enable_in) begin
      // SYNTH_5188 violation:
      // An event control statement ('@(posedge clk)') is placed on the RHS of a non-blocking assignment
      // within an asynchronous always block (explicitly sensitive to 'posedge clk' and 'negedge rst_n').
      // This construct is not supported by synthesis tools, as it implies a secondary event control
      // within an already event-controlled block.
      data_out <= @(posedge clk) data_in; // Target violation: SYNTH_5188
    end else begin
      // A different path for data_out without the embedded event control,
      // which helps to distinguish SYNTH_5188 from the more general SYNTH_5317 rule
      // that might trigger if all paths had embedded event controls.
      data_out <= 8'hFF;
    end
  end

endmodule
