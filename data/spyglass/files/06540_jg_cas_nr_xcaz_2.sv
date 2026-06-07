module cas_nr_xcaz_example_2 (
  input [2:0] state_in,
  output reg [1:0] next_state
);

  always_comb begin
    next_state = 2'b00;
    casez (state_in)
      3'b00z: next_state = 2'b01;
      3'b01x: next_state = 2'b10; // 'x' in casez item expression
      3'b1zz: next_state = 2'b11;
      default: next_state = 2'b00;
    endcase
  end

endmodule
