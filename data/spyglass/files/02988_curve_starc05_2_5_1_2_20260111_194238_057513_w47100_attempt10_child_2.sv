module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  input wire clk,      // Added clock input for synchronous logic
  input wire rst_n,    // Added active-low reset input for synchronous logic
  output wire i2c_sdat
);

  // Intermediate wire to hold the combinatorial logic for the tristate enable
  wire tristate_enable_comb;
  // Registered version of the tristate enable signal
  reg tristate_enable_reg;

  // The enable condition is derived from combinatorial logic (AND operation).
  assign tristate_enable_comb = control_a && control_b;

  // Register the enable condition to resolve STARC05-2.5.1.2.
  // This makes the enable signal synchronous and glitch-free, which is the recommended
  // practice for tristate buffer enables.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      tristate_enable_reg <= 1'b0; // Reset tristate enable to inactive (Z state)
    end else begin
      tristate_enable_reg <= tristate_enable_comb;
    end
  end

  // Tristate buffer where the enable condition 'tristate_enable_reg'
  // is now a registered signal, resolving the STARC05-2.5.1.2 violation.
  assign i2c_sdat = tristate_enable_reg ? data_in : 1'bz;

endmodule
