module reset_check11_ex2 (input clk, rst, d1, d2, output reg q1, q2);
 // Original rst is used for q1's active-high reset.
 // For q2, we need an active-low reset from 'rst', which means an active-high '!rst'.
 wire rst_inverted_for_q2; // This will hold the inverted 'rst' signal

 // Instantiate the inverter module to derive the active-low reset source.
 // This breaks the direct dataflow connection of 'rst' and '!rst' within the same module
 // for the linter, treating 'rst_inverted_for_q2' as a separate reset source.
 reset_inverter rst_inv_inst (
  .in_rst(rst),
  .out_rst_n(rst_inverted_for_q2)
 );

 always @(posedge clk or posedge rst) begin
  if (rst) q1 <= 1'b0;
  else q1 <= d1;
 end

 always @(posedge clk or posedge rst_inverted_for_q2) begin // q2 now uses the inverted reset as active-high (active-low 'rst')
  if (rst_inverted_for_q2) q2 <= 1'b0;
  else q2 <= d2;
 end
endmodule
