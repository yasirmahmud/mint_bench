module example_08 (
  input a,
  output y
);
  reg y; // 'y' must be declared as reg as it is assigned in an always block
  reg flag; // 'flag' must be declared as reg as it is assigned in an always block

  // Replaced always_comb with always @(*) for Verilog-2001 compatibility
  // and to address the STX_VE_479 syntax error regarding 'logic' and SystemVerilog constructs.
  always @(*) begin
    // Fix ALWCOMBORDER: Ensure 'flag' is assigned its new value
    // before it is used to assign 'y' in the same combinational block.
    flag = (a == 1'b1);
    y = flag;
  end
endmodule
