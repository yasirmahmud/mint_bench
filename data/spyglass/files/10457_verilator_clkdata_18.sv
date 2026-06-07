module clkdata18 (input clk, output reg out);
  wire [0:0] data_wire = clk;
  always @(posedge clk) begin
    out <= data_wire;
  end
endmodule
