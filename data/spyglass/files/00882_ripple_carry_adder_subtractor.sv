module ripple_carry_adder_subtractor #(parameter SIZE = 4) (
  input wire [SIZE-1:0] A, B,
  input wire CTRL,
  output wire [SIZE-1:0] S,
  output wire Cout
);

  wire [SIZE-1:0] Bc;
  wire [SIZE:0] carry; // Intermediate carry signals
  assign carry[0] = CTRL; // Initial carry is CTRL for subtraction

  genvar g;

  // Generate Bc array based on CTRL (1 for subtraction, 0 for addition)
  generate
    for(g = 0; g < SIZE; g = g + 1) begin
      assign Bc[g] = B[g] ^ CTRL;
    end
  endgenerate

  full_adder fa0(A[0], Bc[0], CTRL, S[0], carry[1]);

  generate
    for(g = 1; g < SIZE; g = g + 1) begin
      full_adder fa(
        .a(A[g]),
        .b(Bc[g]),
        .cin(carry[g]),
        .sum(S[g]),
        .cout(carry[g+1])
      );
    end
  endgenerate

  assign Cout = carry[SIZE]; // Final carry out

endmodule
