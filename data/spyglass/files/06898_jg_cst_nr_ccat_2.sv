module unsized_concat_example_2 (
  input wire [1:0] data_in,
  output reg [34:0] result
);

  always @(*) begin
    result = {data_in, 0, 1};
  end

endmodule
