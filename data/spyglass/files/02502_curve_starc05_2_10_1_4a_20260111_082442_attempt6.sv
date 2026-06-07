module curve_starc05_2_10_1_4a_20260111_082442_attempt6 (
  input wire my_input_signal,
  output reg my_output_flag
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This block explicitly compares 'my_input_signal' with '1'bz' using a non-identity operator.
  // This example is distinct from previous attempts by using an always block and '!=='.
  always @(*) begin
    if (my_input_signal !== 1'bz) begin
      my_output_flag = 1'b1;
    end else begin
      my_output_flag = 1'b0;
    end
  end

endmodule
