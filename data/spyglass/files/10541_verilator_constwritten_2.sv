module const_write_2;
  const logic [7:0] data = 8'hFF;
  always @* begin
    data = 8'h00;
  end
endmodule
