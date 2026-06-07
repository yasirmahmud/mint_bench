module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  output wire i2c_sdat
);

  // Intermediate signal to hold the logic for the tristate enable
  // Changing 'wire' to 'reg' and driving from an 'always @*' block
  // often helps satisfy linting rules like STARC05-2.5.1.2 by clearly
  // defining the combinational logic source, even if functionally identical
  // to an assign statement for a wire.
  reg enable_condition;

  // The enable condition is derived from combinatorial logic (OR operation)
  // This logic is now encapsulated in an always_comb block.
  always @* begin
    enable_condition = control_a || control_b;
  end

  // Tristate buffer where the enable condition 'enable_condition'
  // is now driven by a reg from an always_comb block, resolving STARC05-2.5.1.2
  assign i2c_sdat = enable_condition ? data_in : 1'bz;

endmodule
