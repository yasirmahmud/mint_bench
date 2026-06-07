module const_write_9;
  // Removed 'const' keyword to allow modification of 's.a' as intended by the initial block.
  // This resolves the Verilator CONSTWRITTEN violation (as described in the problem statement).
  struct { int a; int b; } s = '{a:1, b:2};
  initial begin
    s.a = 10;
    // Added $display statements to read s.a and s.b, resolving SpyGlass W528 warnings
    // (Variable 's.a[31:0]' set but not read, Variable 's.b[31:0]' set but not read).
    $display("At time %0t: s.a = %0d, s.b = %0d", $time, s.a, s.b);
  end
endmodule
