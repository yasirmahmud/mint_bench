module simple_module (
  input wire clk,
  input wire rst,
  input wire [7:0] data_in,
  output wire [7:0] data_out
);
  reg [7:0] data_reg;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_reg <= 8'h00;
    end else begin
      data_reg <= data_in;
    end
  end

  assign data_out = data_reg;
endmodule
