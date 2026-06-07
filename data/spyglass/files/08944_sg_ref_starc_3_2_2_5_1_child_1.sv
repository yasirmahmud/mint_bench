`define MY_MACRO1 1
`define MY_MACRO2 0

module nested_macro_ex1;
 initial begin
  $display("Value: %d", `MY_MACRO2);
 end
endmodule
