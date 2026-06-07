module my_module_2 (
  input wire clk,
  input wire rst,
  input wire [7:0] a,
  input wire [7:0] b,
  output reg [7:0] sum_out
);

  function automatic [7:0] my_function_2 (input [7:0] in1, input [7:0] in2);
    begin
      my_function_2 <= in1 + in2; // Non-blocking assignment to the function's return value
    end
  endfunction

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      sum_out <= 8'h00;
    end else begin
      sum_out <= my_function_2(a, b);
    end
  end

endmodule
