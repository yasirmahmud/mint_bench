// This is the sub-module definition.
module data_processor (
  input clk,
  input rst_n,
  input [CHANNEL_WIDTH-1:0] din,
  output reg [CHANNEL_WIDTH-1:0] dout
);
  parameter CHANNEL_WIDTH = 16; // Default width for the channel

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dout <= {CHANNEL_WIDTH{1'b0}};
    end else begin
      dout <= din; // Simple data passthrough
    end
  end
endmodule
