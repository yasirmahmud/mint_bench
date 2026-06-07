module curve_stx_ve_485_20260111_194408_758986_w7792_attempt9 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end
    end else begin
      data_out <= data_in;
    end
  end

endmodule
