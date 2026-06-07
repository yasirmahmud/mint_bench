module sub_module_a #(
  parameter WIDTH = 8 // Moved parameter declaration to module header (Verilog-2001 style)
) (
  input wire clk,
  output reg [WIDTH-1:0] data_out
);
  // The original 'parameter WIDTH = 8;' declaration inside the module body
  // caused the STX_VE_606 syntax error because WIDTH was used in the port list
  // (output reg [WIDTH-1:0] data_out) before being declared.

  always @(posedge clk) begin
    data_out <= data_out + 1;
  end
endmodule
