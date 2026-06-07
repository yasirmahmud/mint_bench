module curve_synth_5188_20260112_000730_367188_w37744_attempt21 (
  input wire        i_clk,
  input wire        i_rst_n,
  input wire [3:0]  i_data_in,
  output reg [3:0]  o_data_out
);

  // This 'always' block is sensitive to both a positive clock edge and a negative reset edge,
  // making it an asynchronous sequential block.
  always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      // Asynchronous reset condition
      o_data_out <= 4'h0;
    end else begin
      // SYNTH_5188 violation:
      // An event control statement ('@(posedge i_clk)') is placed on the RHS of a non-blocking assignment
      // within an asynchronous always block (explicitly sensitive to 'posedge i_clk' and 'negedge i_rst_n').
      // This construct is not supported by synthesis tools and triggers SYNTH_5188.
      o_data_out <= @(posedge i_clk) i_data_in; // Target violation: SYNTH_5188
    end
  end

endmodule
