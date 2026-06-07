module const_write_13;
  const logic [0:0] my_bit = 1'b0;
  always_ff @(posedge clk) begin
    my_bit <= 1'b1;
  end
  logic clk;
endmodule
