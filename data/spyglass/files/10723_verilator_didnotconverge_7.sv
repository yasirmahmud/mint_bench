module osc7;
  wire a, b;
  assign a = b;
  assign b = a;
  initial begin
    #10 $finish;
  end
endmodule
