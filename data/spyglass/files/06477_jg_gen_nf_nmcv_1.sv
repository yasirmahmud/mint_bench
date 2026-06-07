module top_level_design;
  parameter ENABLE_DEBUG = 1;

  if (ENABLE_DEBUG) begin : debug_logic_block_A
    // This generate block name 'debug_logic_block_A' does not follow a convention like ending in '_gen'.
    wire debug_signal;
    assign debug_signal = 1'b0;
  end
endmodule
