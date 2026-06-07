module sub_module (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg data_out
);
  parameter DATA_WIDTH = 8;

  reg [DATA_WIDTH-1:0] internal_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_reg <= {DATA_WIDTH{1'b0}};
    end else begin
      internal_reg <= {internal_reg[DATA_WIDTH-2:0], data_in};
    end
  end

  always @(*) begin
    data_out = internal_reg[DATA_WIDTH-1];
  end

endmodule
