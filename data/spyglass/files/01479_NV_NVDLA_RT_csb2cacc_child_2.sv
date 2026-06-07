module NV_NVDLA_RT_csb2cacc (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,csb2cacc_req_src_pvld
  ,csb2cacc_req_src_prdy
  ,csb2cacc_req_src_pd
  ,cacc2csb_resp_src_valid
  ,cacc2csb_resp_src_pd
  ,csb2cacc_req_dst_pvld
  ,csb2cacc_req_dst_prdy
  ,csb2cacc_req_dst_pd
  ,cacc2csb_resp_dst_valid
  ,cacc2csb_resp_dst_pd
  );

//
// NV_NVDLA_RT_csb2cacc_ports.v
//
input  nvdla_core_clk;
input  nvdla_core_rstn;

input         csb2cacc_req_src_pvld;  /* data valid */
output        csb2cacc_req_src_prdy;  /* data return handshake */
input  [62:0] csb2cacc_req_src_pd;

input        cacc2csb_resp_src_valid;  /* data valid */
input [33:0] cacc2csb_resp_src_pd;     /* pkt_id_width=1 pkt_widths=33,33  */

output        csb2cacc_req_dst_pvld;  /* data valid */
input         csb2cacc_req_dst_prdy;  /* data return handshake */
output [62:0] csb2cacc_req_dst_pd;

output        cacc2csb_resp_dst_valid;  /* data valid */
output [33:0] cacc2csb_resp_dst_pd;     /* pkt_id_width=1 pkt_widths=33,33  */

wire [33:0] cacc2csb_resp_pd_d0;
wire        cacc2csb_resp_valid_d0;
wire [62:0] csb2cacc_req_pd_d0;
wire        csb2cacc_req_pvld_d0;
reg  [33:0] cacc2csb_resp_pd_d1;
reg  [33:0] cacc2csb_resp_pd_d2;
reg  [33:0] cacc2csb_resp_pd_d3;
reg         cacc2csb_resp_valid_d1;
reg         cacc2csb_resp_valid_d2;
reg         cacc2csb_resp_valid_d3;
reg  [62:0] csb2cacc_req_pd_d1;
reg  [62:0] csb2cacc_req_pd_d2;
reg  [62:0] csb2cacc_req_pd_d3;
reg         csb2cacc_req_pvld_d1;
reg         csb2cacc_req_pvld_d2;
reg         csb2cacc_req_pvld_d3;


assign csb2cacc_req_src_prdy = 1'b1;




assign csb2cacc_req_pvld_d0 = csb2cacc_req_src_pvld;
assign csb2cacc_req_pd_d0 = csb2cacc_req_src_pd;


assign cacc2csb_resp_valid_d0 = cacc2csb_resp_src_valid;
assign cacc2csb_resp_pd_d0 = cacc2csb_resp_src_pd;

// To resolve W528, the unused wire '_unused_csb2cacc_req_dst_prdy' and its assignment
// have been removed. The input 'csb2cacc_req_dst_prdy' remains unused as per design intent.


always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    csb2cacc_req_pvld_d1 <= 1'b0;
  end else begin
  csb2cacc_req_pvld_d1 <= csb2cacc_req_pvld_d0;
  end
end
always @(posedge nvdla_core_clk) begin
  // Resolve NoAssignX-ML (line 82): Data register holds value if not valid
  if (csb2cacc_req_pvld_d0) begin
    csb2cacc_req_pd_d1 <= csb2cacc_req_pd_d0;
  end
end


always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cacc2csb_resp_valid_d1 <= 1'b0;
  end else begin
  cacc2csb_resp_valid_d1 <= cacc2csb_resp_valid_d0;
  end
end
always @(posedge nvdla_core_clk) begin
  // Resolve NoAssignX-ML (line 101): Data register holds value if not valid
  if (cacc2csb_resp_valid_d0) begin
    cacc2csb_resp_pd_d1 <= cacc2csb_resp_pd_d0;
  end
}


always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    csb2cacc_req_pvld_d2 <= 1'b0;
  end else begin
  csb2cacc_req_pvld_d2 <= csb2cacc_req_pvld_d1;
  end
end
always @(posedge nvdla_core_clk) begin
  // Resolve NoAssignX-ML (line 120): Data register holds value if not valid
  if (csb2cacc_req_pvld_d1) begin
    csb2cacc_req_pd_d2 <= csb2cacc_req_pd_d1;
  end
end


always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cacc2csb_resp_valid_d2 <= 1'b0;
  end else begin
  cacc2csb_resp_valid_d2 <= cacc2csb_resp_valid_d1;
  end
end
always @(posedge nvdla_core_clk) begin
  // Resolve NoAssignX-ML (line 139): Data register holds value if not valid
  if (cacc2csb_resp_valid_d1) begin
    cacc2csb_resp_pd_d2 <= cacc2csb_resp_pd_d1;
  end
end


always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    csb2cacc_req_pvld_d3 <= 1'b0;
  end else begin
  csb2cacc_req_pvld_d3 <= csb2cacc_req_pvld_d2;
  end
}
always @(posedge nvdla_core_clk) begin
  // Resolve NoAssignX-ML (line 158): Data register holds value if not valid
  if (csb2cacc_req_pvld_d2) begin
    csb2cacc_req_pd_d3 <= csb2cacc_req_pd_d2;
  end
end


always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cacc2csb_resp_valid_d3 <= 1'b0;
  end else begin
  cacc2csb_resp_valid_d3 <= cacc2csb_resp_valid_d2;
  end
end
always @(posedge nvdla_core_clk) begin
  // Resolve NoAssignX-ML (line 177): Data register holds value if not valid
  if (cacc2csb_resp_valid_d2) begin
    cacc2csb_resp_pd_d3 <= cacc2csb_resp_pd_d2;
  end
end




assign csb2cacc_req_dst_pvld = csb2cacc_req_pvld_d3;
assign csb2cacc_req_dst_pd = csb2cacc_req_pd_d3;


assign cacc2csb_resp_dst_valid = cacc2csb_resp_valid_d3;
assign cacc2csb_resp_dst_pd = cacc2csb_resp_pd_d3;





endmodule
