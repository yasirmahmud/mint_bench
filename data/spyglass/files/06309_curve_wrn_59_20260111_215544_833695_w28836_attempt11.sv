module curve_wrn_59_20260111_215544_833695_w28836_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire enable,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare an explicit wire to be driven
  wire [7:0] my_signal;

  // Drive 'my_signal' to avoid an unused signal warning for data_in and my_signal
  assign my_signal = data_in;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else if (enable) begin
      // WRN_59: The system function $countdrivers is used as a standalone statement
      // its return value is not assigned or used, making it act like a system task.
      $countdrivers(my_signal);
      data_out <= my_signal;
    end else begin
      data_out <= data_out;
    end
  end

endmodule
