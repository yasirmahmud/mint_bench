module const_write_16;
  const logic [3:0] reg_val = 4'b0000;
  initial begin
    repeat(1) reg_val = 4'b1111;
  end
endmodule
