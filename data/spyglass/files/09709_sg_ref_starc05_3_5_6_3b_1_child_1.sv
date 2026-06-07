module star_c05_3_5_6_3b_ex1 (
  input clk,
  input rst_n, // Added reset input to handle initialization for synthesis
  output reg [7:0] data
);

  // Replaced the non-synthesizable 'initial' block with a synthesizable
  // always block that initializes 'data' on reset. This resolves SYNTH_5143.
  // Using 'clk' in the always block also resolves the W240 warning.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Asynchronous active-low reset
      data <= 8'h00;
    end
    // No 'else' branch is needed, as the original design only specified
    // an initial value and no subsequent updates. Thus, 'data' will hold
    // its reset value after the reset is de-asserted.
  end

endmodule
