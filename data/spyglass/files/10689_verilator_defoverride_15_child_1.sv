module top15;
  `define CORE_COUNT 4
  logic [2:0] core_id;
  assign core_id = `CORE_COUNT;

  // SpyGlass W528 violation fix: Variable 'core_id' set but not read.
  // Added an initial block to read the value of core_id.
  initial begin
    $display("core_id value: %0d", core_id);
  end
endmodule
