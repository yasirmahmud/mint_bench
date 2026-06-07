module const_write_15 (
  input logic clk,
  input logic rst_n,
  output logic [15:0] data_bus
);

  // SYNTH_89 and SYNTH_5143 are resolved by using a synthesizable 'always_ff' block for initialization.
  // W528 is resolved by making 'data_bus' an output, implying it is read by external logic.
  // The original 'initial' block's final assignment of 16'h0000 is reflected as the reset value.

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_bus <= 16'h0000;
    end
  end

endmodule
