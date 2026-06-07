module example_07(input g);
  always_ff @(posedge clk) begin
    g <= 1'b1;
  end
endmodule
