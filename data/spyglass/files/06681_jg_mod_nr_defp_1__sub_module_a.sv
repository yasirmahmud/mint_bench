module sub_module_a (
  input wire clk,
  output reg [WIDTH-1:0] data_out
);
  parameter WIDTH = 8;

  always @(posedge clk) begin
    data_out <= data_out + 1;
  end
endmodule
