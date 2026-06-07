module const_write_11;
  const logic [1:0] status = 2'b00;
  always_comb begin
    status = 2'b11;
  end
endmodule
