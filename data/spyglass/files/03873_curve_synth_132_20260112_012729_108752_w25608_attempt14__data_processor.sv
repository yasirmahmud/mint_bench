// This is the sub-module definition with a parameter.
module data_processor #(
  parameter DATA_WIDTH = 8 // Default data width
) (
  input clk,
  input rst_n,
  input [DATA_WIDTH-1:0] din,
  output reg [DATA_WIDTH-1:0] dout
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dout <= {DATA_WIDTH{1'b0}};
    end else begin
      dout <= din; // Simple data passthrough
    end
  end
endmodule
