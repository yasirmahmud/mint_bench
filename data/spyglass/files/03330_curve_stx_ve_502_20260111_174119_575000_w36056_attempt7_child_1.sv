module curve_stx_ve_502_20260111_174119_575000_w36056_attempt7 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h0;
    elsius begin
      data_out <= data_in;
    end
  end

endmodule
