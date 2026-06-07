module casex_example_1 (
  input [2:0] in_data,
  output reg out_val
);

always @(*) begin
  casex (in_data)
    3'b00x: out_val = 1'b0;
    3'b01x: out_val = 1'b1;
    3'b1xx: out_val = 1'b0;
    default: out_val = 1'b1;
  endcasex
end

endmodule
