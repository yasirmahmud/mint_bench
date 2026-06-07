module W468_ex1 (
    output out_bit
);
 reg [31:0] wide_bus;
 reg [3:0] narrow_idx;

 initial begin
  // Assign constant values to prevent undriven/never-set violations
  wide_bus = 32'hDEADBEEF;
  narrow_idx = 4'h7; // Example index
 end

 assign out_bit = wide_bus[narrow_idx];
 endmodule
