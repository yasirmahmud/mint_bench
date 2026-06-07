module test_func_no_avac_1;

  function automatic [7:0] my_func (input [7:0] a, input [7:0] b);
    if (a > b) begin
      my_func = a;
    end else begin
      // Fixed: my_func is now assigned if a <= b, assuming the intent is to return the larger value.
      my_func = b;
    end
  endfunction

  // Fixed: Replaced 'result' with 'result1' and 'result2' to resolve multiple simultaneous drivers.
  // This also resolves the 'result' set but not read warning as the original 'result' no longer exists.
  wire [7:0] result1;
  assign result1 = my_func(8'd10, 8'd5);

  wire [7:0] result2;
  assign result2 = my_func(8'd5, 8'd10); // This call now hits the defined else path in the function

endmodule
