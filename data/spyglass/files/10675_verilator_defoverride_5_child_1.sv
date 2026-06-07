module top5;
  `define SIZE 8
  logic [(`SIZE-1):0] bus;
  assign bus = 0;

  // Added to resolve W528: Variable 'bus' set but not read.
  initial begin
    $display("Bus value: %0d", bus);
  end
endmodule
