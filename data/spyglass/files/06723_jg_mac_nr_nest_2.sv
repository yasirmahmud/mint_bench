module nested_macro_example_2();
  `define MAC_CONSTANT 20
  `define MAC_OPERATION (`MAC_CONSTANT * 2)

  logic [7:0] data;

  assign data = `MAC_OPERATION;

  initial begin
    $display("Data: %0d", data);
  end
endmodule
