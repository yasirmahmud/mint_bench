module complex_reset_ex2 (input clk, input reset_a, input reset_b, input d, output reg q);
  wire async_reset_active = reset_a && reset_b; // Define the combined asynchronous reset condition

  always @(posedge clk or posedge reset_a or posedge reset_b) begin
    if (async_reset_active == 1'b1) begin // W442f: Check the derived reset condition using '=='
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end
endmodule
