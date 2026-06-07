// Generic single-stage pipeline for a single bit (flow control) with ready/valid handshake
module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_flow (
    input nvdla_core_clk,
    input nvdla_core_rstn,
    input in_data,
    input in_pvld,
    output in_prdy,
    output out_data,
    output out_pvld,
    input out_prdy
);

  reg out_data_reg;
  reg out_pvld_reg;

  assign in_prdy = !out_pvld_reg || out_prdy;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      out_data_reg <= 1'b0;
      out_pvld_reg <= 1'b0;
    end else begin
      if (in_pvld && in_prdy) begin
        out_data_reg <= in_data;
        out_pvld_reg <= 1'b1;
      end else if (out_pvld_reg && out_prdy) begin
        out_pvld_reg <= 1'b0;
      end
    end
  end
  assign out_data = out_data_reg;
  assign out_pvld = out_pvld_reg;

endmodule
