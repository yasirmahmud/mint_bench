module asc_const_declaration;
  const logic [7:0] CONST_VAL_ASC = 8'hDD; // Changed [0:7] to [7:0] to follow best practices and resolve Verilator ASCRANGE concern

  // Added an initial block to use CONST_VAL_ASC and resolve SpyGlass W528 (variable set but not read)
  initial begin
    $display("CONST_VAL_ASC = %h", CONST_VAL_ASC);
  end
endmodule
