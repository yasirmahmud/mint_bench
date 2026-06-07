// Generic single-stage pipeline for data with ready/valid handshake
module NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_data #(
    parameter WIDTH = 1
) (
    input nvdla_core_clk,
    input nvdla_core_rstn,
    input [WIDTH-1:0] data_in,
    input in_pvld,
    output in_prdy,
    output [WIDTH-1:0] data_out,
    output out_pvld,
    input out_prdy
);

  reg [WIDTH-1:0] data_reg;
  reg out_pvld_reg;

  assign in_prdy = !out_pvld_reg || out_prdy;

  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
      data_reg <= {WIDTH{1'b0}};
      out_pvld_reg <= 1'b0;
    end else begin
      if (in_pvld && in_prdy) begin
        data_reg <= data_in;
        out_pvld_reg <= 1'b1;
      end else if (out_pvld_reg && out_prdy) begin
        out_pvld_reg <= 1'b0;
      end
    end
  end
  assign data_out = data_reg;
  assign out_pvld = out_pvld_reg;

endmodule
