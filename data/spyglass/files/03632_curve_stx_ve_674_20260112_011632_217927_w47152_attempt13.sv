module duplicate_port_stx_ve_674 (
  input clk,
  input rst_n,
  input [3:0] signal_a,
  input [3:0] signal_a, // STX_VE_674: Port name 'signal_a' previously declared
  input [3:0] signal_a, // STX_VE_674: Port name 'signal_a' previously declared
  input [3:0] signal_a, // STX_VE_674: Port name 'signal_a' previously declared
  input [3:0] signal_a, // STX_VE_674: Port name 'signal_a' previously declared
  input [3:0] signal_a, // STX_VE_674: Port name 'signal_a' previously declared
  output reg out_valid
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    out_valid <= 1'b0;
  end else begin
    out_valid <= signal_a[0]; // Minimal usage to avoid unused signal warnings
  end
end

endmodule
