module curve_stx_ve_491_20260111_044740_attempt4 (
  input wire [7:0] data_in,
  output wire [3:0] part_out
);

  // This triggers STX_VE_491. The rule flags indexed part-selects
  // [start_expression :- width_expression] when the declaration is MSB-first ([MSB:LSB]),
  // as the tool interprets the bounds as 'reversed' from its internal canonical form.
  // Here, data_in[5 :- 4] attempts to select 4 bits starting from index 5 and going downwards
  // (i.e., bits [5:2]).
  // Even though it's a valid Verilog construct, SpyGlass considers the bounds reversed
  // because the start index (5) is not the MSB of the full vector (7) and the tool
  // expects standard [MSB:LSB] part-selects for MSB-first declarations, or encounters
  // an ambiguity in converting the indexed part-select to its canonical form.
  assign part_out = data_in[5 :- 4];

endmodule
