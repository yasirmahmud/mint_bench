module GroupOFAsgn_ML_ex1 (input wire in_d, output reg out_b, output reg out_c);
  // Original statement: always @* begin out_b <= out_c <= in_d <= 1'b0; end
  // This original statement has multiple issues:
  // 1. Illegal assignment to an input port 'in_d' (in_d <= 1'b0).
  // 2. Chained assignments are flagged by GroupOFAsgn-ML.
  // 3. Due to the illegal assignment or complex chaining, 'out_c' is reported as undriven by UndrivenInTerm-ML.
  //
  // To fix these, we must remove the illegal assignment to 'in_d' and separate the chained assignments.
  // Assuming the intent of the chain was to assign '1'b0' to 'out_b' and 'out_c'.
  always @* begin
    out_b <= 1'b0; // Assigns 0 to out_b
    out_c <= 1'b0; // Assigns 0 to out_c
  end
endmodule
