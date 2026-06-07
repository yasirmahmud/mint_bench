module my_module (
  input wire clk,
  output reg out
);
  // This is a redefinition of my_module
  always @(posedge clk) begin
    out <= 1'b0;
  end
endmodule
