module curve_stx_ve_775_20260111_220200_967083_w49296_attempt16 (
    input clk,
    input rst_n,
    output reg out_signal_a,
    output reg out_signal_b
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_signal_a <= 1'b0;
    end else begin
      initial begin 
        out_signal_a <= 1'b1;
      end
    end
  end

  always @(posedge clk) begin
    initial begin 
      out_signal_b <= 1'b0;
    end
  end

endmodule
