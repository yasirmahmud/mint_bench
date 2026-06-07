module example_19 (
  input a,
  output y
);
  reg y;
  reg next_state;
  always_comb begin
    next_state = a; // Reordered to assign 'next_state' before it is read
    y = next_state; // 'y' now receives the current value of 'a'
  end
endmodule
