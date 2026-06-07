module const_write_7;
  const logic flag = 1'b0;
  always @(posedge clk) begin
    flag <= 1'b1;
  end
  logic clk;
endmodule
