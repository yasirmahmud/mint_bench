module now_func_example2 (
  input wire enable,
  output reg [63:0] real_time_val
);

always @* begin
  if (enable) begin
    real_time_val <= 64'h1; // Replaced non-synthesizable $realtime with a constant to resolve latch inference
  end else begin
    real_time_val <= 64'h0;
  }
end

endmodule
