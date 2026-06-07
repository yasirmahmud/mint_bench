`timescale 1ns/1ps

module NonConstantDelay1 (
  output reg [7:0] data_out // Declared as an output port to resolve W528
);
  reg [7:0] data_in;
  // data_out is now declared in the port list
  reg [3:0] delay_val; // This will be the non-constant delay

  initial begin
    data_in = 8'hAA;
    delay_val = 5;
    #10;
    delay_val = 2;
    #10;
    data_in = 8'h55;
  end

  // Original: assign #(delay_val) data_out = data_in; // Violation: delay_val is not a constant expression
  // Fix for CST_NO_DELY: Use an always block with non-blocking assignment
  // This preserves the variable delay behavior for simulation.
  always @(data_in or delay_val) begin
    data_out <= #(delay_val) data_in;
  end

endmodule
