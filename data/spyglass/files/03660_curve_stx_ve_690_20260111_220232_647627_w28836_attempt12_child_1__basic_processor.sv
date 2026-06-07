// Verilog-2001

// Child module with basic ports
module basic_processor (
  input wire clk,
  input wire reset,
  input wire [7:0] data_in,
  output wire [7:0] data_out
);
  // Simple combinational logic for illustration
  assign data_out = data_in;
endmodule
