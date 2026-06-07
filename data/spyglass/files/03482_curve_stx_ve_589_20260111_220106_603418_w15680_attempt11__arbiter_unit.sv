module arbiter_unit (
  input wire clk,
  input wire rst_n,
  output reg grant_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      grant_out <= 1'b0;
    end else begin
      grant_out <= ~grant_out; // Minimal logic
    end
  end

endmodule
