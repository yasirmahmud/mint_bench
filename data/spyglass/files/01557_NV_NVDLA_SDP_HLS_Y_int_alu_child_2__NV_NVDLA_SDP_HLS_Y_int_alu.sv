// Original module with fixes for linting violations
module NV_NVDLA_SDP_HLS_Y_int_alu (
   alu_data_in     //|< i
  ,alu_in_pvld     //|< i
  ,alu_out_prdy    //|< i
  ,cfg_alu_algo    //|< i
  ,cfg_alu_bypass  //|< i
  ,cfg_alu_op      //|< i
  ,cfg_alu_src     //|< i
  ,chn_alu_op      //|< i
  ,chn_alu_op_pvld //|< i
  ,nvdla_core_clk  //|< i
  ,nvdla_core_rstn //|< i
  ,alu_data_out    //|> o
  ,alu_in_prdy     //|> o
  ,alu_out_pvld    //|> o
  ,chn_alu_op_prdy //|> o
  );

input  [31:0] alu_data_in;
input         alu_in_pvld;
input         alu_out_prdy;
input   [1:0] cfg_alu_algo;
input         cfg_alu_bypass;
input  [31:0] cfg_alu_op;
input         cfg_alu_src;
input  [31:0] chn_alu_op;
input         chn_alu_op_pvld;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output [31:0] alu_data_out;
output        alu_in_prdy;
output        alu_out_pvld;
output        chn_alu_op_prdy;


wire   [32:0] alu_sum;
// 'mon_sum_c' wire removed as it was set but not read (W528 violation) and did not affect functional behavior of alu_dout.
reg    [32:0] alu_dout;
wire   [32:0] alu_data_ext;
wire   [31:0] alu_data_final;
wire   [31:0] alu_data_reg;
wire   [31:0] alu_data_sync;
wire          alu_final_prdy;
wire          alu_final_pvld;
wire          alu_in_srdy;
wire          alu_mux_prdy;
wire          alu_mux_pvld;
wire   [32:0] alu_op_ext;
wire   [31:0] alu_op_mux;
wire   [31:0] alu_op_reg;
wire   [31:0] alu_op_sync;
wire   [31:0] alu_sat;
wire          alu_sync_prdy;
wire          alu_sync_pvld;

    
NV_NVDLA_SDP_HLS_sync2data #(.DATA1_WIDTH(32 ),.DATA2_WIDTH(32 )) y_alu_sync2data (
   .chn1_en         (cfg_alu_src & !cfg_alu_bypass)
  ,.chn2_en         (!cfg_alu_bypass)
  ,.chn1_in_pvld    (chn_alu_op_pvld)
  ,.chn1_in_prdy    (chn_alu_op_prdy)
  ,.chn2_in_pvld    (alu_in_pvld)
  ,.chn2_in_prdy    (alu_in_srdy)
  ,.chn_out_pvld    (alu_sync_pvld)
  ,.chn_out_prdy    (alu_sync_prdy)
  ,.data1_in        (chn_alu_op[31:0])
  ,.data2_in        (alu_data_in[31:0])
  ,.data1_out       (alu_op_sync[31:0])
  ,.data2_out       (alu_data_sync[31:0])
  );

assign  alu_op_mux = cfg_alu_src ? alu_op_sync[31:0] : cfg_alu_op[31:0];

NV_NVDLA_SDP_HLS_Y_INT_ALU_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.alu_data_sync   (alu_data_sync[31:0])
  ,.alu_mux_prdy    (alu_mux_prdy)
  ,.alu_op_mux      (alu_op_mux[31:0])
  ,.alu_sync_pvld   (alu_sync_pvld)
  ,.alu_data_reg    (alu_data_reg[31:0])
  ,.alu_mux_pvld    (alu_mux_pvld)
  ,.alu_op_reg      (alu_op_reg[31:0])
  ,.alu_sync_prdy   (alu_sync_prdy)
  );

assign  alu_op_ext[32:0]   = {{1{alu_op_reg[31]}}, alu_op_reg[31:0]};
assign  alu_data_ext[32:0] = {{1{alu_data_reg[31]}}, alu_data_reg[31:0]};
// Changed assignment to directly assign the 33-bit sum to alu_sum, as 'mon_sum_c' was unused.
assign  alu_sum[32:0] = $signed(alu_data_ext) + $signed(alu_op_ext);

always @(
  cfg_alu_algo
  or alu_data_ext
  or alu_op_ext
  or alu_sum
  ) begin
 if (cfg_alu_algo[1:0] == 0 ) 
     alu_dout[32:0] = ($signed(alu_data_ext) > $signed(alu_op_ext)) ? alu_data_ext : alu_op_ext;
 else if (cfg_alu_algo[1:0] == 1 ) 
     alu_dout[32:0] = ($signed(alu_data_ext) < $signed(alu_op_ext)) ? alu_data_ext : alu_op_ext;
 else if (cfg_alu_algo[1:0] == 3 )
     alu_dout[32:0] = (alu_data_ext == alu_op_ext) ? 0 : 1;
 else 
     alu_dout[32:0] = alu_sum[32:0]; 
end

NV_NVDLA_HLS_saturate #(.IN_WIDTH(32 +1 ),.OUT_WIDTH(32 )) y_alu_saturate (
   .data_in         (alu_dout[32:0])
  ,.data_out        (alu_sat[31:0])
  );

NV_NVDLA_SDP_HLS_Y_INT_ALU_pipe_p2 pipe_p2 (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.alu_final_prdy  (alu_final_prdy)
  ,.alu_mux_pvld    (alu_mux_pvld)
  ,.alu_sat         (alu_sat[31:0])
  ,.alu_data_final  (alu_data_final[31:0])
  ,.alu_final_pvld  (alu_final_pvld)
  ,.alu_mux_prdy    (alu_mux_prdy)
  );

assign  alu_in_prdy    = cfg_alu_bypass ? alu_out_prdy : alu_in_srdy;
assign  alu_final_prdy = cfg_alu_bypass ? 1'b1 : alu_out_prdy;
assign  alu_out_pvld   = cfg_alu_bypass ? alu_in_pvld : alu_final_pvld;
assign  alu_data_out[31:0] = cfg_alu_bypass ? alu_data_in[31:0] : alu_data_final[31:0];

endmodule
