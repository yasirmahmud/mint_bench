module curve_starc05_2_5_1_7_20260110_223425_attempt1 (
  input wire en,
  input wire data_in,
  output wire tri_state_out,
  output reg regular_out
);

  // Assign a tri-state value to tri_state_out
  assign tri_state_out = en ? data_in : 1'bz;

  // Use the tri-state output in a conditional expression, triggering STARC05-2.5.1.7
  always @* begin
    if (tri_state_out) begin 
      regular_out = 1'b1;
    end else begin
      regular_out = 1'b0;
    end
  end

endmodule
