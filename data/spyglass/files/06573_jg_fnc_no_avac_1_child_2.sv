module test_func_no_avac_1;

  function automatic [7:0] my_func (input [7:0] a, input [7:0] b);
    if (a > b) begin
      my_func = a;
    end else begin
      my_func = b;
    end
  endfunction

  wire [7:0] result1;
  assign result1 = my_func(8'd10, 8'd5);

  wire [7:0] result2;
  assign result2 = my_func(8'd5, 8'd10);

  // To resolve 'set but not read' warnings, the results are displayed.
  initial begin
    $display("result1 = %0d", result1);
    $display("result2 = %0d", result2);
  end

endmodule
