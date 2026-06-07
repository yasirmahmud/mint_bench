module curve_synth_5306_20260110_130424_attempt1 (
  input wire clk,
  input wire rst,
  input wire in_data,
  output reg out_data
);

  // This block defines 'my_first_block'.
  always @(posedge clk) begin : my_first_block
    if (rst) begin
      out_data <= 1'b0;
    end else begin
      out_data <= in_data;
    end
  end

  // This block attempts to disable 'my_first_block',
  // which is a sibling block and therefore not in the scope
  // of 'my_second_block'. This triggers SYNTH_5306.
  always @(posedge clk) begin : my_second_block
    disable my_first_block;
  end

endmodule
