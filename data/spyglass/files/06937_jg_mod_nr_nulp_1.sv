module my_module (
  input wire clk,
  input wire rst,
  output reg out,
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out <= 1'b0;
    end else begin
      out <= ~out;
    end
  end
endmodule
