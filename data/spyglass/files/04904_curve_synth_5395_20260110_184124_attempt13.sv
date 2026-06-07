module curve_synth_5395_20260110_184124_attempt13 (
  input clk,
  input rst_n, // Asynchronous active-low reset
  input data_in,
  output reg output_reg
);

  // This internal register's value will be used in an improper event list.
  // It's clearly a data signal, driven synchronously and reset by rst_n.
  reg internal_data_event;

  // Standard synchronous logic for internal_data_event with asynchronous reset.
  // This ensures internal_data_event is perceived as a data signal, not a clock or primary reset.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_data_event <= 1'b0;
    end else begin
      internal_data_event <= data_in;
    end
  end

  // SYNTH_5395: Improper asynchronous style of modeling. Not synthesizable.
  // This 'always' block is sensitive to the positive edge of the clock 'clk'
  // AND the positive edge of 'internal_data_event'.
  // 'internal_data_event' is an internal data signal, not a clock or an asynchronous reset.
  // Including the edge of a data signal alongside a clock in a sequential 'always' block
  // violates synchronous design principles and is typically not synthesizable to
  // standard flip-flops, as it represents an improper asynchronous style of modeling.
  // The intent is for 'internal_data_event' to be treated as a data signal, avoiding
  // misinterpretation as a clock (STARC05-2.3.3.1, W422) or an asynchronous reset
  // without a top-level 'if' statement (W442a).
  always @(posedge clk or posedge internal_data_event) begin
    output_reg <= internal_data_event;
  end

endmodule
