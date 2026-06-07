module curve_synth_104_20260111_221439_278260_w38092_attempt12 (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg out1,
  output reg out2,
  output reg out3
);

  reg internal_reg_a; // Target for SYNTH_104 violation 1
  reg internal_reg_b; // Target for SYNTH_104 violation 2
  reg internal_reg_c; // Target for SYNTH_104 violation 3

  // Synchronous block with asynchronous reset to drive internal_reg_a
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      internal_reg_a <= 1'b0;
      out1 <= 1'b0; // Drive output to avoid unused signal warning
    end else begin
      internal_reg_a <= data_in; // Use data_in input
      out1 <= internal_reg_a; // Connect to output
    end
  end

  // Synchronous block to drive internal_reg_b
  always @(posedge clk) begin
    internal_reg_b <= internal_reg_a; // Use internal_reg_a
    out2 <= internal_reg_b; // Connect to output
  end

  // Synchronous block to drive internal_reg_c
  always @(posedge clk) begin
    internal_reg_c <= internal_reg_b; // Use internal_reg_b
    out3 <= internal_reg_c; // Connect to output
  end

  // SYNTH_104 violation 1: DEASSIGN statement in a negative-edge triggered always block
  // Targets internal_reg_a
  always @(negedge clk) begin
    deassign internal_reg_a; // SYNTH_104 trigger #1
  end

  // SYNTH_104 violation 2: DEASSIGN statement in a positive-edge triggered reset always block
  // Targets internal_reg_b
  always @(posedge rst) begin
    deassign internal_reg_b; // SYNTH_104 trigger #2
  end

  // SYNTH_104 violation 3: DEASSIGN statement in a combinational always @* block
  // Targets internal_reg_c
  always @* begin
    deassign internal_reg_c; // SYNTH_104 trigger #3
  end

endmodule
