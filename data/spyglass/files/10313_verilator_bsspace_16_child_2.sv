module test16;
  logic [15:0] wide_bus;

  assign wide_bus = 16'hFFFF;

  // Fix for SpyGlass W528: Variable 'wide_bus' set but not read.
  // Added a display statement to read the variable, preserving functional behavior.
  initial begin
    $display("wide_bus value: %h", wide_bus);
  end
endmodule
