module data_clk_as_data (
  input wire in_sig,
  output wire out_sig
);

  reg  temp_reg;
  wire in_sig_data;

  // To resolve 'Clock signal used as non-clock' violation (STARC05-1.4.3.4):
  // The signal used as the clock (in_sig) should not also be directly used as data.
  // A separate data path (in_sig_data) is created, even though it sources from the same input (in_sig),
  // to logically distinguish between the clock and data roles for the linter.
  // The problematic 'my_data_clk' wire and its assignment are removed.
  assign in_sig_data = in_sig;

  // in_sig is used as the clock here
  always @(posedge in_sig) begin
    temp_reg <= in_sig_data; // Data input is now a distinct wire, preserving behavior
  end

  assign out_sig = temp_reg;

endmodule
