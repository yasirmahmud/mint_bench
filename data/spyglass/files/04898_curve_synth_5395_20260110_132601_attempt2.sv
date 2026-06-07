module curve_synth_5395_20260110_132601_attempt2 (
  input clk,
  input rst,
  output reg out_reg
);

  reg [1:0] internal_counter;
  
  // Synchronous counter with asynchronous reset
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      internal_counter <= 2'b0;
    end else begin
      internal_counter <= internal_counter + 2'b1;
    end
  end

  // This always block uses the edge of an internal, derived signal
  // (`internal_counter[0]`) in its sensitivity list, in addition to
  // the clock and reset. This is considered an improper asynchronous
  // modeling style and is typically not synthesizable.
  always @(posedge clk or posedge rst or posedge internal_counter[0]) begin
    if (rst) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= internal_counter[1];
    end
  end

endmodule
