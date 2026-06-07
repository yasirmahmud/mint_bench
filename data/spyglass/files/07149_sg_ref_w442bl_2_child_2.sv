module complex_reset_ex2 (input clk, input reset_a, input reset_b, input d, output reg q);
  wire async_reset_active = reset_a && reset_b; // Define the combined asynchronous reset condition

  always @(posedge clk or posedge async_reset_active) begin // Fixed: Only one asynchronous reset signal in sensitivity list
    if (async_reset_active) begin // Fixed: Direct check for asynchronous reset condition
      q <= 1'b0;
    end else begin
      q <= d;
    }
  end
endmodule
