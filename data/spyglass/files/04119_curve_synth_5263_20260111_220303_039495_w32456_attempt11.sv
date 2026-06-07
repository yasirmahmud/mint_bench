module curve_synth_5263_20260111_220303_039495_w32456_attempt11 (
  input clk,
  input rst_n,
  input enable_branch,
  input [7:0] data_in,
  output reg [7:0] out_reg_a,
  output reg [7:0] out_reg_b
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    out_reg_a <= 8'h00;
    out_reg_b <= 8'h00;
  end else begin
    if (enable_branch) begin
      // SYNTH_5263: First non-synthesizable fork-join construct
      fork
        out_reg_a <= data_in;
      join

      // SYNTH_5263: Second non-synthesizable fork-join construct
      fork
        out_reg_b <= data_in + 8'd1;
      join
    end else begin
      out_reg_a <= 8'hFF;
      out_reg_b <= 8'hFF;
    end
  end
end

endmodule
