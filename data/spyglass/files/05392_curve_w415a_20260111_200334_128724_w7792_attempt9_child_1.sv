module curve_w415a_20260111_200334_128724_w7792_attempt9 (
  input wire [7:0] in_vec,
  output reg [2:0] out_val
);

  integer k;
  reg [2:0] target_reg;

  always @(*) begin
    reg [2:0] temp_target_val; // Temporary signal to hold the computed value
    integer highest_k_with_zero; // To store the highest index k where in_vec[k] is 0

    temp_target_val = 3'b000; // Default value if no '0's are found in in_vec
    highest_k_with_zero = -1; // Initialize to an invalid index to indicate no '0' found yet

    // Iterate through in_vec to find the highest index 'k' where in_vec[k] is 0.
    // This effectively preserves the original behavior where later assignments in the loop overwrite earlier ones.
    for (k = 0; k < 8; k = k + 1) begin
      if (in_vec[k] == 1'b0) begin
        highest_k_with_zero = k; // Update to the current 'k' as it's a higher index (if found)
      end
    end

    // After the loop, if a '0' was found, assign the corresponding ~k to temp_target_val.
    // This ensures target_reg is assigned only once, resolving W415a.
    if (highest_k_with_zero != -1) begin
      temp_target_val = ~highest_k_with_zero[2:0]; // Use the 3 LSBs of k for negation
    end
    
    target_reg = temp_target_val;
    out_val = target_reg;
  end

endmodule
