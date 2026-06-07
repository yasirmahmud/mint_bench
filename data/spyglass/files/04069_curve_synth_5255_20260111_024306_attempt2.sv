module curve_synth_5255_20260111_024306_attempt2 (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output reg out_bit_error,
  output reg [7:0] out_data_valid
);

  // Declare an 8-bit register. The rule indicates the target signal 'Ct' is 8-bit wide.
  reg [7:0] my_signal_8bit;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_signal_8bit <= 8'd0;
      out_bit_error  <= 1'b0;
      out_data_valid <= 8'd0;
    end else begin
      // Assign input to my_signal_8bit to ensure data_in is used.
      // This also ensures the valid bits of my_signal_8bit are driven and not unused.
      my_signal_8bit <= data_in;

      // Use the valid range of my_signal_8bit to avoid W528 (variable set but not read) for my_signal_8bit.
      out_data_valid <= my_signal_8bit;

      // This is the specific violation for SYNTH_5255: accessing bit 31 of an 8-bit register.
      // The index 31 is out of the declared range [7:0].
      out_bit_error <= my_signal_8bit[31];
    end
  end

endmodule
