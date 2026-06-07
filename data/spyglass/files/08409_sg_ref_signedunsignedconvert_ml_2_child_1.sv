module signed_unsigned_convert_ex2 (
  output wire [0:0] u_bit
);
  reg signed [7:0] s_data;

  // SpyGlass Violation Fix: Initialize s_data to resolve "Variable 's_data[0]' read but never set"
  initial begin
    s_data = 8'h00;
  end

  // SpyGlass Violation Fix: Make u_bit an output to resolve "Variable 'u_bit' set but not read"
  assign u_bit = s_data[0];
endmodule
