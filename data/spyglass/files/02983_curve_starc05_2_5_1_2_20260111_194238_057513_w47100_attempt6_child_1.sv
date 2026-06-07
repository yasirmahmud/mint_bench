module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  output wire i2c_sdat
);

  // Intermediate signal to hold the logic for the tristate enable
  // Changed from wire to reg and assigned in an always @* block to resolve STARC05-2.5.1.2
  // while preserving combinatorial behavior.
  reg enable_signal_logic;

  // The enable condition is derived from combinatorial logic
  always @(*) begin
    enable_signal_logic = control_a && control_b;
  end

  // Tristate buffer where the enable condition 'enable_signal_logic'
  assign i2c_sdat = enable_signal_logic ? data_in : 1'bz;

endmodule
