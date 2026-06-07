module curve_w415a_20260111_160035_923474_w21676_attempt3 (
  input wire [7:0] data_in,
  output reg [7:0] result
);

  reg [7:0] temp_reg; // Signal targeted for W415a violation
  integer i;          // Loop variable

  always @* begin
    // Initialize temp_reg. This assignment is immediately followed by loop assignments.
    // The primary violation comes from assignments within the loop.
    temp_reg = 8'b0;

    // The 'for' loop assigns to 'temp_reg' multiple times in the same simulation cycle.
    // In each iteration, 'temp_reg' is assigned either in the 'if' or 'else' branch,
    // guaranteeing multiple assignments to 'temp_reg' within this loop.
    for (i = 0; i < 8; i = i + 1) begin
      if (data_in[i]) begin
        temp_reg = i; // Blocking assignment to temp_reg
      end else begin
        temp_reg = ~i; // Another blocking assignment to temp_reg
      end
    end
    result = temp_reg; // Assign the final calculated value to the output
  end

endmodule
