module example_19 (
  input a,
  output reg y
);
  reg next_state;
  always_comb begin
    next_state = a;
    y = next_state;
  end
endmodule
