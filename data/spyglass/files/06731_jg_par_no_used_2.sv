module unused_param_example_2 (
  input clk,
  input rst,
  input [DATA_WIDTH-1:0] in_data,
  output [DATA_WIDTH-1:0] out_data
);

  parameter UNUSED_DEPTH = 4; // This parameter is declared but not used
  parameter DATA_WIDTH = 16;  // This parameter is used for port width

  reg [DATA_WIDTH-1:0] internal_reg;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      internal_reg <= '0;
    end else begin
      internal_reg <= in_data;
    end
  end

  assign out_data = internal_reg;

endmodule
