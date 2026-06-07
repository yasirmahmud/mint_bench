module curve_w415a_20260111_160035_923474_w21676_attempt2 (
  input wire [7:0] data_in,
  output reg [7:0] result
);

  reg [7:0] temp_val; // Signal targeted for W415a violation
  integer i;          // Loop variable

  // Combinational always block to demonstrate W415a
  always @* begin
    temp_val = 8'd0; // Initialize temp_val with a blocking assignment

    // The 'for' loop assigns to 'temp_val' multiple times in the same cycle.
    // This structure triggers the W415a violation for 'temp_val'.
    for (i = 0; i < 8; i = i + 1) begin
      if (data_in[i]) begin
        temp_val = temp_val + 1; // Multiple blocking assignments to temp_val within the loop
      end
    end
    result = temp_val; // Assign the final calculated value to the output
  end

endmodule
