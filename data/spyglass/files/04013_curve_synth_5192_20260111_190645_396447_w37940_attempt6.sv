module curve_synth_5192_20260111_190645_396447_w37940_attempt6 (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg data_out
);

  // SYNTH_5192 violation: Signal edge of "rst" used in condition of if statement
  // does not match that specified in the sensitivity list of always block.
  // The sensitivity list expects negedge rst, but the if condition checks for rst being high.
  always @(posedge clk or negedge rst) begin
    if (rst) begin // This condition checks for rst high
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
