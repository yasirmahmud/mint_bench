module top10 (
  input wire clk,
  input wire rst_n, // Active-low reset
  output logic [7:0] data_out [0:3]
);
  // Change 'byte' to 'logic [7:0]' for explicit synthesizable register declaration.
  // 'logic' allows assignment from procedural blocks.
  logic [7:0] data [0:3];

  // Replace the non-synthesizable 'initial' block with a synthesizable 'always' block
  // to initialize 'data' on reset. This resolves SYNTH_5143.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Asynchronous, active-low reset condition
      for (int i = 0; i < 4; i++) begin
        data[i] <= i; // Use non-blocking assignments for sequential logic in an always block.
                      // This inherently avoids the Verilator BLKLOOPINIT issue in a synthesizable context.
      end
    end
    // No 'else' branch is needed as the module's only function is initialization on reset.
    // If 'data' were used for other sequential logic, it would be described here.
  end

  // Assign internal 'data' to an output port to resolve W528 (variable set but not read).
  // This also makes the initialized state observable.
  assign data_out = data;

endmodule
