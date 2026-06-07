module test17;
  logic [7:0] status_reg;
  logic [3:0] flags;

  // Fix: Initialize status_reg to resolve "read but never set" violation.
  initial begin
    status_reg = 8'hA5; // Assign an example value to status_reg
  end

  assign flags = status_reg[4 +: 4];

  // Fix: Read flags to resolve "set but not read" violation.
  initial begin
    #1; // Add a small delay to ensure combinational assignment has settled
    $display("At time %0t: flags = %h", $time, flags);
  end
endmodule
