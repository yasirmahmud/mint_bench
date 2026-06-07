module SignedBitPartSelect_ex1;
 reg signed [7:0] data_s;
 wire [0:0] bit_select_w;
 assign bit_select_w = data_s[0];

 initial begin
  // Assign a value to data_s to resolve "read but never set" violation.
  data_s = 8'b10101010;
  #1; // Add a small delay to ensure continuous assignment propagates.
  // Use bit_select_w in a display statement to resolve "set but not read" violation.
  $display("At time %0t: data_s = %h, data_s[0] = %b, bit_select_w = %b", $time, data_s, data_s[0], bit_select_w);
 end

 endmodule
