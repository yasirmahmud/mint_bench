module curve_synth_77_20260111_154018_106011_w21676_attempt6 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire control_signal,
    output reg [7:0] target_reg
);

  // This always block demonstrates the SYNTH_77 violation by assigning to 'target_reg'
  // using both non-blocking ('<=') and blocking ('=') assignments within the same procedural block.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      target_reg <= 8'h00; // Non-blocking assignment (e.g., for reset)
    end else begin
      // Depending on 'control_signal', 'target_reg' receives either a blocking or non-blocking assignment.
      if (control_signal) begin
        // Blocking assignment: This is in a synchronous always block, mixing it
        // with non-blocking assignments to the same 'target_reg' is a violation.
        target_reg = data_in; // Blocking assignment
      end else begin
        // Non-blocking assignment: Standard sequential update.
        // Its presence alongside the blocking assignment above triggers SYNTH_77.
        target_reg <= data_in + 1; // Non-blocking assignment
      end
    end
  end

endmodule
