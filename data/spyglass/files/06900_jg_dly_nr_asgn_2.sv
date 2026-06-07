module delayed_always_reg (
  input wire clk,
  input wire rst_n,
  input wire in_val,
  output reg out_val
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_val <= #10 1'b0;
    end else begin
      out_val <= #10 in_val;
    end
  end

endmodule
