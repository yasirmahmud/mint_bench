// This is the sub-module definition with a parameter.
module param_module #(
  parameter DATA_SIZE = 4 // Default value for DATA_SIZE
) (
  input clk,
  input rst_n,
  input [DATA_SIZE-1:0] din,
  output reg [DATA_SIZE-1:0] dout
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dout <= {DATA_SIZE{1'b0}};
    end else begin
      dout <= din; // Simple passthrough
    end
  end
endmodule
