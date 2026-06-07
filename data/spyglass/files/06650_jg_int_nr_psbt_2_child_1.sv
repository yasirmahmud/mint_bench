module int_part_select_violation();
  reg [8:0] counter; // Changed from integer to reg with sufficient width to hold 500
  reg [7:0] lower_byte;

  initial begin
    counter = 500;
    lower_byte = counter[7:0]; // Valid part-select on a sized reg
    $display("lower_byte = %h (%0d)", lower_byte, lower_byte); // Added to resolve 'variable set but not read' warning
  end
endmodule
