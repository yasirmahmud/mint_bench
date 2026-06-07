module test_func_no_avac_1;

  function automatic [7:0] my_func (input [7:0] a, input [7:0] b);
    if (a > b) begin
      my_func = a;
    end
    // Violation: my_func is not assigned if a <= b
  endfunction

  wire [7:0] result;
  assign result = my_func(8'd10, 8'd5);
  assign result = my_func(8'd5, 8'd10); // This call will hit the unassigned path

endmodule
