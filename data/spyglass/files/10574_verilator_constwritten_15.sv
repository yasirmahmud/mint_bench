module const_write_15;
  const int data_bus = 16'hFFFF;
  initial begin
    for (int i=0; i<1; i++) begin
      data_bus = 16'h0000;
    end
  end
endmodule
