module my_module_1 (
  input wire clk,
  input wire rst,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  function automatic [7:0] my_function_1 (input [7:0] val);
    reg [7:0] temp_reg;
    begin
      temp_reg <= val + 1; // Non-blocking assignment to a local variable in a function
      my_function_1 = temp_reg;
    end
  endfunction

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out <= 8'h00;
    end else begin
      data_out <= my_function_1(data_in);
    end
  end

endmodule
