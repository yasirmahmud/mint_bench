module duplicate_port_name_module (
  input clk,
  input rst_n,
  input [7:0] data_in,
  input clk, // Re-declaration 1 triggers STX_VE_674
  input clk, // Re-declaration 2 triggers STX_VE_674
  input clk, // Re-declaration 3 triggers STX_VE_674
  input clk, // Re-declaration 4 triggers STX_VE_674
  input clk, // Re-declaration 5 triggers STX_VE_674
  output data_out
);

reg data_out; // Declare data_out as a reg for assignment in always block

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    data_out <= 1'b0;
  end else begin
    data_out <= data_in[0]; // Use a bit of data_in to avoid width mismatch with 1-bit data_out
  end
end

endmodule
