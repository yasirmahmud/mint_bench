module data_clk_as_data (
  input wire in_sig,
  output wire out_sig
);

  wire my_data_clk; // Follows *_clk pattern
  reg  temp_reg;

  // my_data_clk is used as a data signal, not a clock
  assign my_data_clk = in_sig;

  // A different signal (in_sig) is used as the clock here
  always @(posedge in_sig) begin
    temp_reg <= my_data_clk; // my_data_clk is data
  end

  assign out_sig = temp_reg;

endmodule
