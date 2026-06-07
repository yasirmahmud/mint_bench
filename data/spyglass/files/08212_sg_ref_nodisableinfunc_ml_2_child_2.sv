module my_module_ex2 (input a, output reg b);
  function automatic [7:0] my_func (input [7:0] data);
    begin
      if (data == 8'd0) begin
        my_func = 8'hx;
      end else begin
        my_func = data + 1;
      end
    end
  endfunction

  always @(*) begin
    reg [7:0] func_result;
    func_result = my_func(a);
    b = func_result[0];
  end
endmodule
