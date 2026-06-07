module casex_example_2 (
  input [3:0] control,
  output reg [1:0] status
);

always @(*) begin
  casex (control)
    4'b000x: status = 2'b00;
    4'b001x: status = 2'b01;
    4'b01xx: status = 2'b10;
    default: status = 2'b11;
  endcasex
end

endmodule
