module my_module_ex1(
  input [7:0] in_port,
  output reg [7:0] out_val,
  input wire clk,
  input wire reset_n
);

reg [7:0] in_val;

always @(posedge clk or negedge reset_n) begin
  if (!reset_n) begin
    // The original 'initial' block performs a sequence of assignments:
    // 1. in_val gets the value of in_port.
    // 2. out_val gets the value of in_val (which is in_port).
    // 3. in_val is then incremented (so it becomes in_port + 1).
    // To preserve this functional behavior in a synthesizable way, we initialize
    // the 'reg' variables with their final values based on in_port when reset is asserted.
    out_val <= in_port;       // out_val gets the value of in_port at reset.
    in_val <= in_port + 1;    // in_val gets (in_port + 1) at reset.
  end
  // After reset, without any further specified logic, these registers will hold
  // their initialized values, matching the one-time assignment nature of 'initial'.
end

endmodule
