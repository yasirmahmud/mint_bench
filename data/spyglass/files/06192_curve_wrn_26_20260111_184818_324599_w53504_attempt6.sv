`define MY_DEBUG_FLAG 0

module wrn_26_test (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Redefinition of the macro
  `define MY_DEBUG_FLAG 1

  // Use the flag in a dummy way to avoid unused signal warnings for data_in, clk, rst_n
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h0;
    end else if (`MY_DEBUG_FLAG == 1) begin // This will use the *redefined* value of MY_DEBUG_FLAG
      data_out <= data_in;
    end else begin
      data_out <= 8'hFF;
    end
  end

endmodule
