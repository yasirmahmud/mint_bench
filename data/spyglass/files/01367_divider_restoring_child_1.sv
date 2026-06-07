module divider_restoring #(
  parameter WN = 8,       // width of N [1]
  parameter WD = 6)       // width of D [1]
(
  input            clk,   // system synchronous clock
  input  [WN-1:0]  n_in,  // input value n [1]
  input  [WD-1:0]  d_in,  // input value d [1]
  output reg [WD-1:0]  r_out, // output value r [1]
  output reg [WN-1:0]  q_out);// output value q [1]

  parameter PO2WND = 2**(WN+WD);
  parameter PO2WN1 = 2**(WN-1);
  parameter PO2WN   = 2**(WN) - 1;

  wire [WN+WD-1:0] r,d; // range -1 to PO2WND-1 (!)
  wire [WN-1:0] q;

  // Internal registers to implement a synchronous restoring division logic
  reg [WN-1:0]  q_reg;     // Internal quotient register
  reg [WD:0]    a_reg;     // Internal remainder register (needs WD+1 bits for sign check)
  reg [WD-1:0]  m_reg;     // Internal divisor register
  reg [$clog2(WN+1)-1:0] count; // Iteration counter for WN steps

  always @(posedge clk) begin
    // When count is 0, it signifies the start of a new division cycle (or reset).
    // This is where n_in and d_in are read to initialize the division process.
    if (count == 0) begin
      // Initialize for a new division operation
      a_reg <= {1'b0, {WD{1'b0}}}; // Partial Remainder (A) starts at 0
      q_reg <= n_in;              // Quotient (Q) starts with the dividend n_in
      m_reg <= d_in;              // Divisor (M) is d_in
      count <= WN;                // Start WN iterations for a WN-bit quotient
    end else begin
      // Perform one step of the restoring division algorithm
      reg [WD:0] next_a_shifted;
      reg [WN-1:0] next_q_shifted;

      // Step 1: Shift Partial Remainder (A) and Quotient (Q) left by 1 bit
      // The MSB of Q goes into the LSB of A.
      next_a_shifted = {a_reg[WD-1:0], q_reg[WN-1]};
      next_q_shifted = q_reg << 1;

      // Step 2: Subtract Divisor (M) from the shifted Partial Remainder (A)
      reg [WD:0] a_minus_m = next_a_shifted - {1'b0, m_reg};

      // Step 3: Check the sign of the result (A - M)
      if (a_minus_m[WD]) begin // If MSB is 1, the result is negative (A < M)
        // Restore A (A = A + M, by keeping the un-subtracted value)
        a_reg <= next_a_shifted;
        // Set LSB of Q to 0 (already handled by shift if it was 0 before)
        q_reg <= next_q_shifted;
      end else begin
        // Update A with the subtracted value
        a_reg <= a_minus_m;
        // Set LSB of Q to 1
        q_reg <= next_q_shifted | 1'b1;
      end

      count <= count - 1; // Decrement iteration counter
    end

    // Continuously assign outputs from the internal registers.
    // The final valid q_out and r_out will be present when 'count' becomes 0 after WN steps.
    q_out <= q_reg;
    r_out <= a_reg[WD-1:0]; // The remainder is the lower WD bits of a_reg
  end

endmodule
