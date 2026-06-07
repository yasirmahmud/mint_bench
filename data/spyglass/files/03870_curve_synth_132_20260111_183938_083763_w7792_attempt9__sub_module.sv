module sub_module (
  input wire clk_i,
  output reg data_o
);
  parameter WIDTH_PARAM = 8;
  reg [WIDTH_PARAM-1:0] internal_counter;

  always @(posedge clk_i) begin
    internal_counter <= internal_counter + 1;
    data_o <= internal_counter[0]; // Simple logic to use inputs/outputs
  end
endmodule
