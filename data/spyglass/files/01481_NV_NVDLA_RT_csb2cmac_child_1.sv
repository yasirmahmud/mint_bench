module NV_NVDLA_RT_csb2cmac (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,csb2cmac_req_src_pvld
  ,csb2cmac_req_src_prdy
  ,csb2cmac_req_src_pd
  ,cmac2csb_resp_src_valid
  ,cmac2csb_resp_src_pd
  ,csb2cmac_req_dst_pvld
  ,csb2cmac_req_dst_prdy
  ,csb2cmac_req_dst_pd
  ,cmac2csb_resp_dst_valid
  ,cmac2csb_resp_dst_pd
  );

//
// NV_NVDLA_RT_csb2cmac_ports.v
//
input  nvdla_core_clk;
input  nvdla_core_rstn;

input         csb2cmac_req_src_pvld;  /* data valid */
output        csb2cmac_req_src_prdy;  /* data return handshake */
input  [62:0] csb2cmac_req_src_pd;

input        cmac2csb_resp_src_valid;  /* data valid */
input [33:0] cmac2csb_resp_src_pd;     /* pkt_id_width=1 pkt_widths=33,33  */

output        csb2cmac_req_dst_pvld;  /* data valid */
input         csb2cmac_req_dst_prdy;  /* data return handshake */
output [62:0] csb2cmac_req_dst_pd;

output        cmac2csb_resp_dst_valid;  /* data valid */
output [33:0] cmac2csb_resp_dst_pd;     /* pkt_id_width=1 pkt_widths=33,33  */

wire [33:0] cmac2csb_resp_pd_d0;
wire        cmac2csb_resp_valid_d0;
wire [62:0] csb2cmac_req_pd_d0;
wire        csb2cmac_req_pvld_d0;
reg  [33:0] cmac2csb_resp_pd_d1;
reg  [33:0] cmac2csb_resp_pd_d2;
reg  [33:0] cmac2csb_resp_pd_d3;
reg         cmac2csb_resp_valid_d1;
reg         cmac2csb_resp_valid_d2;
reg         cmac2csb_resp_valid_d3;
reg  [62:0] csb2cmac_req_pd_d1;
reg  [62:0] csb2cmac_req_pd_d2;
reg  [62:0] csb2cmac_req_pd_d3;
reg         csb2cmac_req_pvld_d1;
reg         csb2cmac_req_pvld_d2;
reg         csb2cmac_req_pvld_d3;


assign csb2cmac_req_src_prdy = 1'b1;




assign csb2cmac_req_pvld_d0 = csb2cmac_req_src_pvld;
assign csb2cmac_req_pd_d0 = csb2cmac_req_src_pd;


assign cmac2csb_resp_valid_d0 = cmac2csb_resp_src_valid;
assign cmac2csb_resp_pd_d0 = cmac2csb_resp_src_pd;



always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    csb2cmac_req_pvld_d1 <= 1'b0;
  end else begin
  csb2cmac_req_pvld_d1 <= csb2cmac_req_pvld_d0;
  end
end
always @(posedge nvdla_core_clk) begin
  if (csb2cmac_req_pvld_d0) begin
    csb2cmac_req_pd_d1 <= csb2cmac_req_pd_d0;
  end else begin
    csb2cmac_req_pd_d1 <= csb2cmac_req_pd_d1; // Hold value when not valid
  end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cmac2csb_resp_valid_d1 <= 1'b0;
  end else begin
  cmac2csb_resp_valid_d1 <= cmac2csb_resp_valid_d0;
  end
end
always @(posedge nvdla_core_clk) begin
  if (cmac2csb_resp_valid_d0) begin
    cmac2csb_resp_pd_d1 <= cmac2csb_resp_pd_d0;
  end else begin
    cmac2csb_resp_pd_d1 <= cmac2csb_resp_pd_d1; // Hold value when not valid
  end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    csb2cmac_req_pvld_d2 <= 1'b0;
  end else begin
  csb2cmac_req_pvld_d2 <= csb2cmac_req_pvld_d1;
  end
end
always @(posedge nvdla_core_clk) begin
  if (csb2cmac_req_pvld_d1) begin
    csb2cmac_req_pd_d2 <= csb2cmac_req_pd_d1;
  end else begin
    csb2cmac_req_pd_d2 <= csb2cmac_req_pd_d2; // Hold value when not valid
  end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cmac2csb_resp_valid_d2 <= 1'b0;
  end else begin
  cmac2csb_resp_valid_d2 <= cmac2csb_resp_valid_d1;
  end
end
always @(posedge nvdla_core_clk) begin
  if (cmac2csb_resp_valid_d1) begin
    cmac2csb_resp_pd_d2 <= cmac2csb_resp_pd_d1;
  end else begin
    cmac2csb_resp_pd_d2 <= cmac2csb_resp_pd_d2; // Hold value when not valid
  end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    csb2cmac_req_pvld_d3 <= 1'b0;
  end else begin
  csb2cmac_req_pvld_d3 <= csb2cmac_req_pvld_d2;
  end
end
always @(posedge nvdla_core_clk) begin
  if (csb2cmac_req_pvld_d2) begin
    csb2cmac_req_pd_d3 <= csb2cmac_req_pd_d2;
  end else begin
    csb2cmac_req_pd_d3 <= csb2cmac_req_pd_d3; // Hold value when not valid
  end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cmac2csb_resp_valid_d3 <= 1'b0;
  end else begin
  cmac2csb_resp_valid_d3 <= cmac2csb_resp_valid_d2;
  end
end
always @(posedge nvdla_core_clk) begin
  if (cmac2csb_resp_valid_d2) begin
    cmac2csb_resp_pd_d3 <= cmac2csb_resp_pd_d2;
  end else begin
    cmac2csb_resp_pd_d3 <= cmac2csb_resp_pd_d3; // Hold value when not valid
  end
end




assign csb2cmac_req_dst_pvld = csb2cmac_req_pvld_d3;
assign csb2cmac_req_dst_pd = csb2cmac_req_pd_d3;


assign cmac2csb_resp_dst_valid = cmac2csb_resp_valid_d3;
assign cmac2csb_resp_dst_pd = cmac2csb_resp_pd_d3;

// Fix for W240: Input 'csb2cmac_req_dst_prdy' declared but not read.
// The input is not used in the existing pipelining logic which performs simple delays.
// To satisfy the linter without altering the functional behavior (simple delay, no backpressure propagation),
// the signal is assigned to an unused wire to mark it as read.
wire _unused_csb2cmac_req_dst_prdy = csb2cmac_req_dst_prdy;



endmodule
