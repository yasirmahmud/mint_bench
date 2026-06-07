module osc20;
  wire a, b;
  assign a = b;
  assign b = a;
  initial begin
    #1 $display("Tick");
    #1 $finish;
  end
endmodule
