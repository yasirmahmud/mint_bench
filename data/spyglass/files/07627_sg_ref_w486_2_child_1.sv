module W486_ex2;
 reg [3:0] data_in;
 reg [5:0] shift_val;
 wire [9:0] result;

 assign result = data_in << shift_val;

 initial begin
  // Assigning arbitrary values to data_in and shift_val to resolve 'undriven' and 'never set' violations.
  // In a real design, these would typically be inputs or driven by other logic.
  data_in = 4'b1010;
  shift_val = 6'd3;

  // Adding a display statement to use 'result' and resolve the 'set but not read' violation.
  #1; // Wait a delta cycle for combinational assignment to propagate
  $display("data_in = %b, shift_val = %d, result = %b", data_in, shift_val, result);
 end

 endmodule
