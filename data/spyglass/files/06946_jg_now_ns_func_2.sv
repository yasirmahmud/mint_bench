module now_func_example2 (
  input wire enable,
  output reg [63:0] real_time_val
);

always @(enable) begin
  if (enable) begin
    real_time_val <= $realtime; // Non-synthesizable function
  end else begin
    real_time_val <= 64'h0;
  end
end

endmodule
