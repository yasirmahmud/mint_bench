module UnusedRegisterExample1 (
  input clk,
  input rst_n,
  input data_in
);

  reg my_unused_ff; // This flip-flop will have no load

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_unused_ff <= 1'b0;
    end else begin
      my_unused_ff <= data_in;
    end
  end

  // my_unused_ff is never read or used by any other logic or output port.

endmodule
