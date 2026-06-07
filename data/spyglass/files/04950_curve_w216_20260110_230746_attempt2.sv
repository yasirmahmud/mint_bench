module curve_w216_20260110_230746_attempt2 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] result
);

  reg [7:0] counter;
  reg [7:0] lower_part;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 8'd0;
      lower_part <= 8'd0;
    end else begin
      counter <= counter + 8'd1;
      // W216: Inappropriate range select for int_part_sel variable: "counter[7:0] "
      // This line is expected to trigger the W216 violation.
      lower_part <= counter[7:0];
      result <= lower_part;
    end
  end

endmodule
