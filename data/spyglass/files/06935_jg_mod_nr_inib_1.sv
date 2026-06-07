module my_initial_module (
  output reg reset_val
);
  initial begin
    reset_val = 1'b0; // This initial block is not synthesizable
  end
endmodule
