module truncation_example_2(
    input wire clk,
    input wire rst,
    output reg [9:0] data_out
);

  // Original intention: data_reg = 10'h00FF;
  // W19 (truncation) fixed by widening data_out to 10 bits [9:0].
  // SYNTH_5143 (initial block ignored) fixed by replacing 'initial' with a synthesizable 'always' block.
  // W528 (set but not read) fixed by making data_out an output, ensuring it is 'read' by external modules.
  // Functional behavior (assigning 10'h00FF) is preserved, now without truncation.

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out <= 10'b0; // Initialize on reset
    end else begin
      data_out <= 10'h00FF; // Assign the desired 10-bit value
    end
  end

endmodule
