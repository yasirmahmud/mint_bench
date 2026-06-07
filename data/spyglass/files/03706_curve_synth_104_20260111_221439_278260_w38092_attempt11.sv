module curve_synth_104_20260111_221439_278260_w38092_attempt11 (
  input wire clk,
  input wire rst_n,
  output wire out1,
  output wire out2,
  output wire out3
);

  reg my_reg_a;
  reg my_reg_b;
  reg my_reg_c;

  // Initialize internal registers to a known state
  initial begin
    my_reg_a = 1'b0;
    my_reg_b = 1'b0;
    my_reg_c = 1'b0;
  end

  // SYNTH_104 violation 1: deassign statement in an initial block
  initial begin
    #5; // Delay for simulation semantics
    deassign my_reg_a;
  end

  // SYNTH_104 violation 2: deassign statement in a positive-edge triggered always block
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_reg_b <= 1'b0;
    end else begin
      my_reg_b <= my_reg_a; // Use my_reg_a to ensure it's not unused
    end
    deassign my_reg_b;
  end

  // SYNTH_104 violation 3: deassign statement in a negative-edge triggered always block
  always @(negedge clk) begin
    my_reg_c <= my_reg_b; // Use my_reg_b to ensure it's not unused
    deassign my_reg_c;
  end

  // Connect internal registers to outputs to avoid unused signal warnings
  assign out1 = my_reg_a;
  assign out2 = my_reg_b;
  assign out3 = my_reg_c;

endmodule
