module two_dff_inv_rst  (
  clk_i,
  rst_i,
  d_i,
  d0_o, d1_o);

input wire clk_i;
input wire rst_i;
input wire d_i;
output reg d0_o;
output reg d1_o;

wire rst_n_i; // Declare an inverted reset signal
assign rst_n_i = !rst_i; // Invert the reset signal

always @(posedge clk_i or posedge rst_i) begin
  if (rst_i) begin
    d0_o <= 0;
  end else begin
    d0_o <= d_i;
  end
end

always @(posedge clk_i or posedge rst_n_i) begin // Use the inverted reset signal with posedge
  if (rst_n_i) begin // Check the inverted reset signal for reset condition
    d1_o <= 0;
  end else begin
    d1_o <= d_i;
  end
end


endmodule
