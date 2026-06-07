module mult_oper_var_ex1(
  input wire clk,
  input wire rst_n, // Active-low reset for initialization
  output reg [7:0] out
);
  reg [7:0] val;

  // Replacing the non-synthesizable 'initial' block with a synthesizable 'always_ff' block
  // triggered by a reset. This resolves SYNTH_5143.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // To resolve MultOperVar-ML, we calculate the intended final values explicitly.
      // Original logic: val = 8'd1;
      //   temp1 = val; val = val + 1; // temp1 = 1, val = 2
      //   temp2 = val; val = val + 1; // temp2 = 2, val = 3
      //   out = temp1 + temp2;        // out = 1 + 2 = 3
      // So, on reset, we set 'val' and 'out' to their calculated final values.
      val <= 8'd3;
      out <= 8'd3;
    end
    // No 'else' block is needed as the original 'initial' block performs a one-time assignment,
    // implying that 'val' and 'out' remain stable after initialization.
  end
endmodule
