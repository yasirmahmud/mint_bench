module wait_example_2 (
  input clk,
  output reg done
);

initial begin
  done = 1'b0;
  #10;
  wait (clk == 1'b1); // PRO_NR_WAIT: Sensitivity lists should be used instead of wait statement
  done = 1'b1;
end

endmodule
