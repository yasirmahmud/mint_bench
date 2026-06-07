module comparator #(parameter DATA_WIDTH = 8) (
  input [DATA_WIDTH-1:0] a,
  input [DATA_WIDTH-1:0] b,
  output reg equal,
  output reg lower,
  output reg greater
);

always @(*) begin
  if (a == b) begin
    equal = 1'b1;
    lower = 1'b0;
    greater = 1'b0;
  end else if (a < b) begin
    equal = 1'b0;
    lower = 1'b1;
    greater = 1'b0;
  end else begin // a > b
    equal = 1'b0;
    lower = 1'b0;
    greater = 1'b1;
  end
end

endmodule
