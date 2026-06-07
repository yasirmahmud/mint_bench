module booths_mul_algo(X, Y, Z);
  input signed [3:0] X, Y;
  output signed [7:0] Z;
  
  // Registers to hold the Z and X1 values at the *end* of each iteration.
  // Z_0 holds initial Z, Z_1 holds Z after iter 0, ..., Z_4 holds Z after iter 3.
  reg signed [7:0] Z_0, Z_1, Z_2, Z_3, Z_4;
  reg X1_0, X1_1, X1_2, X1_3; // X1_0 is initial X1, X1_1 after iter 0, etc.

  // This will store the result of the final conditional negation
  reg signed [7:0] Z_final_output_reg;

  // Declarations moved to module scope to resolve STX_VE_481, STX_VE_606, and STX_VE_479.
  reg signed [3:0] Y_neg_val;
  reg [1:0] temp_0;
  reg signed [7:0] Z_after_add_0;
  reg [1:0] temp_1;
  reg signed [7:0] Z_after_add_1;
  reg [1:0] temp_2;
  reg signed [7:0] Z_after_add_2;
  reg [1:0] temp_3;
  reg signed [7:0] Z_after_add_3;

  always @ (X, Y)
    begin
      // Y_neg_val is constant for all iterations, declared and assigned once.
      Y_neg_val = -Y;

      // --- Initial values before any iterations ---
      // Each variable is assigned once here.
      Z_0 = 8'd0;
      X1_0 = 1'd0;

      // --- Iteration 0 (i=0) ---
      temp_0 = {X[0], X1_0}; // Assigned once
      
      // Calculate Z_after_add_0 in a single assignment using a full case statement
      case (temp_0)
        2'd2 : Z_after_add_0 = { (Z_0[7:4] + Y_neg_val), Z_0[3:0] };
        2'd1 : Z_after_add_0 = { (Z_0[7:4] + Y), Z_0[3:0] };
        default : Z_after_add_0 = Z_0; // Ensure assignment in all paths
      endcase
      
      // Calculate Z_1 (Z after shift) with custom Z[7] rule in a single assignment.
      // The expression {Z_after_add_0[6], (Z_after_add_0 >> 1)[6:0]} implements the behavior
      // of `Z = Z >> 1; Z[7] = Z[6];` in a single assignment.
      Z_1 = {Z_after_add_0[6], (Z_after_add_0 >> 1)[6:0]}; // Assigned once
      
      X1_1 = X[0]; // Assigned once

      // --- Iteration 1 (i=1) ---
      temp_1 = {X[1], X1_1}; // Assigned once
      
      case (temp_1)
        2'd2 : Z_after_add_1 = { (Z_1[7:4] + Y_neg_val), Z_1[3:0] };
        2'd1 : Z_after_add_1 = { (Z_1[7:4] + Y), Z_1[3:0] };
        default : Z_after_add_1 = Z_1;
      endcase
      
      Z_2 = {Z_after_add_1[6], (Z_after_add_1 >> 1)[6:0]}; // Assigned once

      X1_2 = X[1]; // Assigned once

      // --- Iteration 2 (i=2) ---
      temp_2 = {X[2], X1_2}; // Assigned once
      
      case (temp_2)
        2'd2 : Z_after_add_2 = { (Z_2[7:4] + Y_neg_val), Z_2[3:0] };
        2'd1 : Z_after_add_2 = { (Z_2[7:4] + Y), Z_2[3:0] };
        default : Z_after_add_2 = Z_2;
      endcase
      
      Z_3 = {Z_after_add_2[6], (Z_after_add_2 >> 1)[6:0]}; // Assigned once

      X1_3 = X[2]; // Assigned once

      // --- Iteration 3 (i=3) ---
      temp_3 = {X[3], X1_3}; // Assigned once
      
      case (temp_3)
        2'd2 : Z_after_add_3 = { (Z_3[7:4] + Y_neg_val), Z_3[3:0] };
        2'd1 : Z_after_add_3 = { (Z_3[7:4] + Y), Z_3[3:0] };
        default : Z_after_add_3 = Z_3;
      endcase
      
      Z_4 = {Z_after_add_3[6], (Z_after_add_3 >> 1)[6:0]}; // Assigned once (final Z from loop)

      // The final X1 (X[3]) is not needed after the loop.

      // --- Final conditional negation ---
      // Ensure Z_final_output_reg is assigned in all paths to avoid implicit latch and W415a.
      if (Y == 4'd8)
        begin
          Z_final_output_reg = -Z_4; // Assigned once conditionally
        end
      else
        begin
          Z_final_output_reg = Z_4;  // Assigned once conditionally
        end
    end
    
  assign Z = Z_final_output_reg; // Drive output port from the single-assigned reg
      
endmodule
