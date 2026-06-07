module example_03 (
  input a,
  output reg y
);
  reg state;
  always_comb begin
    // Fix for ALWCOMBORDER: Assign 'state' before it is used.
    state = a;
    if (state) y = 1'b1;
    else y = 1'b0;
  end
endmodule
