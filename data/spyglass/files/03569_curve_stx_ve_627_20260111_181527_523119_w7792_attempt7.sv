module top_module (
  input wire clk,
  input wire rst_n,
  output reg [7:0] out_data
);

  // Define a function that expects 2 arguments
  // The rule description specifically mentions 'my_func'
  function automatic [7:0] my_func;
    input [7:0] arg1;
    input [7:0] arg2;
    my_func = arg1 + arg2;
  endfunction

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 8'h00;
    end else begin
      // This call triggers STX_VE_627: 
      // 'my_func' is defined to expect 2 arguments (arg1, arg2)
      // It is called with only 1 argument (the literal '10'), resulting in too few arguments.
      out_data <= my_func(10);
    end
  end

endmodule
