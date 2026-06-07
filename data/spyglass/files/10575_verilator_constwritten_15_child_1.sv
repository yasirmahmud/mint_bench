module const_write_15;
  int data_bus = 16'hFFFF; // Removed 'const' keyword to allow reassignment
  initial begin
    for (int i=0; i<1; i++) begin
      data_bus = 16'h0000;
    end
  end
endmodule
