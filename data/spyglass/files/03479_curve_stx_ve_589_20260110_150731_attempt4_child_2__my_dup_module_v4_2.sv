module my_dup_module_v4_2 (
  input wire clk
);
  // Added minimal logic to resolve W240: Input 'clk' declared but not read.
  reg dummy_q_2;
  always @(posedge clk) begin
    dummy_q_2 <= 1'b0;
  end
endmodule
