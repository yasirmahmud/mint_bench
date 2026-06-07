module curve_w415a_20260111_160035_923474_w21676_attempt5 (
  input wire [7:0] sel_a,
  input wire [7:0] sel_b,
  output reg [7:0] result
);

  reg [7:0] data_reg; // Signal targeted for W415a violation
  integer i;          // Loop variable

  always @* begin
    data_reg = 8'h00; // Initialize the signal

    // The 'for' loop contains multiple conditional assignments to 'data_reg'.
    // If 'sel_a[i]' is true, 'data_reg' is assigned 'i'.
    // If 'sel_b[i]' is true, 'data_reg' is assigned 'i + 1'.
    // As the loop iterates, if different conditions are met, 'data_reg' will be
    // assigned multiple times within the same execution of the always block,
    // leading to the W415a violation: "Signal data_reg is being assigned multiple times
    // ( assignment within same for-loop ) in same always block".
    for (i = 0; i < 8; i = i + 1) begin
      if (sel_a[i]) begin
        data_reg = i; // First conditional assignment
      end
      if (sel_b[i]) begin
        data_reg = i + 1; // Second conditional assignment to the same signal
      end
    end
    result = data_reg; // Assign the final calculated value to the output
  end

endmodule
