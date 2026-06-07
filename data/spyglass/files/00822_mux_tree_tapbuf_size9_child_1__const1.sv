// Dummy definition for const1 module
// This resolves the "Design Unit 'const1' has no definition" error.
module const1 (output const1);
  assign const1 = 1'b1; // 'const1' implies logic 1
endmodule
