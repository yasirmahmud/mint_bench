module osc14;
  wire a, b;
  assign a = b;
  assign b = ~a;
  initial begin
    #10 $display("Finished");
  end
endmodule
