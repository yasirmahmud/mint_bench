module top16;
  `define STATUS_CODE 0
  logic [3:0] status_reg;
  assign status_reg = `STATUS_CODE;

  // Fix for SpyGlass W528: Variable 'status_reg' set but not read.
  // Adding a read operation to satisfy the linting rule without changing functional assignment.
  initial begin
    $display("Status_reg value: %0d", status_reg);
  end
endmodule
