module near_overload_ex1 (
    output wire [8:0] dummy_load
);
 reg a;
 reg b;
 wire out_nand;

 // Drive 'a' and 'b' to resolve undriven input violations
 initial begin
  a = 1'b0; // Assign a constant value
  b = 1'b1; // Assign a constant value
 end

 nand (out_nand, a, b);

 // 'dummy_load' is now an output to resolve 'set but not read' violation (W528)
 // This preserves the intent of simulating a load on 'out_nand' for the NearOverload rule.
 buf (dummy_load[0], out_nand);
 buf (dummy_load[1], out_nand);
 buf (dummy_load[2], out_nand);
 buf (dummy_load[3], out_nand);
 buf (dummy_load[4], out_nand);
 buf (dummy_load[5], out_nand);
 buf (dummy_load[6], out_nand);
 buf (dummy_load[7], out_nand);
 buf (dummy_load[8], out_nand);

 endmodule
