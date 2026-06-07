module booth_algorithm(Q,M,result);
input signed [3:0]Q,M;
output reg signed [7:0]result;

reg [3:0]M_comp;

// Declare intermediate variables for each stage (4 stages for 4-bit Q)
// This explicitly unrolls the loop to avoid multiple assignments to the same 'reg' variable within a combinatorial block.
reg q0_s0, q0_s1, q0_s2, q0_s3;
reg signed [7:0] result_s0, result_s1, result_s2, result_s3, result_s4; // result_s4 holds the final computed result
reg [1:0] operation_s0, operation_s1, operation_s2, operation_s3;

always @(Q,M)
begin
  M_comp = -M;

  // Initial values for the first stage, matching the original loop's initialization
  result_s0 = 8'b0;
  q0_s0 = 1'b0;

  // Stage 0 (corresponds to i=0 in the original loop)
  operation_s0 = {Q[0], q0_s0};
  result_s1 = result_s0; // Initialize with previous stage's result
  case(operation_s0) // Evaluate {Q[i], q0}
    2'b10 : result_s1[7:4] = result_s0[7:4] + M_comp; // Subtract M (add -M)
    2'b01 : result_s1[7:4] = result_s0[7:4] + M;      // Add M
    default: result_s1[7:4] = result_s0[7:4];         // For 00 or 11, just shift (no add/subtract)
  endcase
  result_s1 = result_s1 >>> 1; // Perform arithmetic right shift, matching description
  q0_s1 = Q[0]; // Update q0 for the next iteration

  // Stage 1 (corresponds to i=1 in the original loop)
  operation_s1 = {Q[1], q0_s1};
  result_s2 = result_s1;
  case(operation_s1)
    2'b10 : result_s2[7:4] = result_s1[7:4] + M_comp;
    2'b01 : result_s2[7:4] = result_s1[7:4] + M;
    default: result_s2[7:4] = result_s1[7:4];
  endcase
  result_s2 = result_s2 >>> 1;
  q0_s2 = Q[1];

  // Stage 2 (corresponds to i=2 in the original loop)
  operation_s2 = {Q[2], q0_s2};
  result_s3 = result_s2;
  case(operation_s2)
    2'b10 : result_s3[7:4] = result_s2[7:4] + M_comp;
    2'b01 : result_s3[7:4] = result_s2[7:4] + M;
    default: result_s3[7:4] = result_s2[7:4];
  endcase
  result_s3 = result_s3 >>> 1;
  q0_s3 = Q[2];

  // Stage 3 (corresponds to i=3 in the original loop)
  operation_s3 = {Q[3], q0_s3};
  result_s4 = result_s3;
  case(operation_s3)
    2'b10 : result_s4[7:4] = result_s3[7:4] + M_comp;
    2'b01 : result_s4[7:4] = result_s3[7:4] + M;
    default: result_s4[7:4] = result_s3[7:4];
  endcase
  result_s4 = result_s4 >>> 1;
  // q0 is not needed after the last stage's calculation as it only influences the next iteration.

  // Final assignment to the output 'result'
  result = result_s4;
end
endmodule
