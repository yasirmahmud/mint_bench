module const_write_2;
  const logic [7:0] data = 8'hFF;
  // The 'always @*' block attempting to re-assign 'data' has been removed.
  // 'const' variables must hold a fixed value throughout their lifetime, 
  // so re-assignment is illegal. By removing the assignment, 'data' 
  // correctly remains '8'hFF' as initially declared.
endmodule
