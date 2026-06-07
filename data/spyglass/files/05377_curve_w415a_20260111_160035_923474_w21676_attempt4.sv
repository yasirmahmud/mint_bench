module curve_w415a_20260111_160035_923474_w21676_attempt4 (
  input wire [7:0] data_in,
  output reg [7:0] result
);

  reg [7:0] count_reg; // Signal targeted for W415a violation
  integer i;           // Loop variable

  always @* begin
    count_reg = 8'b0; // Initialize the counter

    // The 'for' loop assigns to 'count_reg' multiple times in the same simulation cycle
    // if multiple bits of 'data_in' are set. This leads to the W415a violation.
    for (i = 0; i < 8; i = i + 1) begin
      if (data_in[i]) begin
        count_reg = count_reg + 1; // This single assignment statement triggers the W415a rule
      end
    end
    result = count_reg; // Assign the final calculated value to the output
  end

endmodule
