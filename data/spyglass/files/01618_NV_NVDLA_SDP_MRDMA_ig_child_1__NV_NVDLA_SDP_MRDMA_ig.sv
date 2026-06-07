module NV_NVDLA_SDP_MRDMA_ig (
   nvdla_core_clk            //|< i
  ,nvdla_core_rstn           //|< i
  ,ig2cq_prdy                //|< i
  ,op_load                   //|< i
  ,reg2dp_batch_number       //|< i
  ,reg2dp_channel            //|< i
  ,reg2dp_height             //|< i
  ,reg2dp_in_precision       //|< i
  ,reg2dp_perf_dma_en        //|< i
  ,reg2dp_proc_precision     //|< i
  ,reg2dp_src_base_addr_high //|< i
  ,reg2dp_src_base_addr_low  //|< i
  ,reg2dp_src_line_stride    //|< i
  ,reg2dp_src_ram_type       //|< i
  ,reg2dp_src_surface_stride //|< i
  ,reg2dp_width              //|< i
  ,sdp2cvif_rd_req_ready     //|< i
  ,sdp2mcif_rd_req_ready     //|< i
  ,dp2reg_mrdma_stall        //|> o
  ,ig2cq_pd                  //|> o
  ,ig2cq_pvld                //|> o
  ,sdp2cvif_rd_req_pd        //|> o
  ,sdp2cvif_rd_req_valid     //|> o
  ,sdp2mcif_rd_req_pd        //|> o
  ,sdp2mcif_rd_req_valid     //|> o
  );
//
// NV_NVDLA_SDP_MRDMA_ig_ports.v
//
input  nvdla_core_clk;
input  nvdla_core_rstn;

output        sdp2mcif_rd_req_valid;  /* data valid */
input         sdp2mcif_rd_req_ready;  /* data return handshake */
output [78:0] sdp2mcif_rd_req_pd;

output        sdp2cvif_rd_req_valid;  /* data valid */
input         sdp2cvif_rd_req_ready;  /* data return handshake */
output [78:0] sdp2cvif_rd_req_pd;

output        ig2cq_pvld;  /* data valid */
input         ig2cq_prdy;  /* data return handshake */
output [13:0] ig2cq_pd;

input op_load;
input   [4:0] reg2dp_batch_number;
input  [12:0] reg2dp_channel;
input  [12:0] reg2dp_height;
input   [1:0] reg2dp_in_precision;
input         reg2dp_perf_dma_en;
input   [1:0] reg2dp_proc_precision;
input  [31:0] reg2dp_src_base_addr_high;
input  [26:0] reg2dp_src_base_addr_low;
input  [26:0] reg2dp_src_line_stride;
input         reg2dp_src_ram_type;
input  [26:0] reg2dp_src_surface_stride;
input  [12:0] reg2dp_width;
output [31:0] dp2reg_mrdma_stall;
reg    [58:0] base_addr_elem;
reg    [58:0] base_addr_line;
reg    [58:0] base_addr_surf;
reg    [58:0] base_addr_width;
reg           cmd_process;
reg     [4:0] count_b;
reg     [8:0] count_c;
reg           count_e;
reg    [12:0] count_h;
reg     [9:0] count_w;
reg    [14:0] dma_req_size;
reg    [31:0] dp2reg_mrdma_stall;
reg           mon_base_addr_elem_c;
reg           mon_base_addr_line_c;
reg           mon_base_addr_surf_c;
reg           mon_base_addr_width_c;
reg           mrdma_rd_stall_cnt_cen;
reg     [8:0] size_of_surf;
reg           stl_adv;
reg    [31:0] stl_cnt_cur;
reg    [33:0] stl_cnt_dec;
reg    [33:0] stl_cnt_ext;
reg    [33:0] stl_cnt_inc;
reg    [33:0] stl_cnt_mod;
reg    [33:0] stl_cnt_new;
reg    [33:0] stl_cnt_nxt;
wire   [58:0] cfg_base_addr;
wire          cfg_di_int16;
wire          cfg_di_int8;
wire          cfg_do_int8;
wire   [26:0] cfg_line_stride;
wire          cfg_mode_16to8;
wire          cfg_mode_1x1_pack;
wire          cfg_mode_multi_batch;
wire   [26:0] cfg_surf_stride;
wire          cmd_accept;
wire          cmd_done;
wire          cv_dma_rd_req_rdy;
wire          cv_dma_rd_req_vld;
wire   [78:0] cv_int_rd_req_pd;
wire   [78:0] cv_int_rd_req_pd_d0;
wire   [78:0] cv_int_rd_req_pd_d1;
wire          cv_int_rd_req_ready;
wire          cv_int_rd_req_ready_d0;
wire          cv_int_rd_req_ready_d1;
wire          cv_int_rd_req_valid;
wire          cv_int_rd_req_valid_d0;
wire          cv_int_rd_req_valid_d1;
wire          cv_rd_req_rdyi;
wire   [78:0] dma_rd_req_pd;
wire          dma_rd_req_ram_type;
wire          dma_rd_req_rdy;
wire          dma_rd_req_vld;
wire   [63:0] dma_req_addr;
wire          dp2reg_mrdma_stall_dec;
wire          ig2eg_cube_end;
wire   [14:0] ig2eg_size;
wire          is_batch_end;
wire          is_cube_end;
wire          is_elem_end;
wire          is_last_b;
wire          is_last_c;
wire          is_last_e;
wire          is_last_h;
wire          is_last_w;
wire          is_line_end;
wire          is_surf_end;
wire          mc_dma_rd_req_rdy;
wire          mc_dma_rd_req_vld;
wire   [78:0] mc_int_rd_req_pd;
wire   [78:0] mc_int_rd_req_pd_d0;
wire   [78:0] mc_int_rd_req_pd_d1;
wire          mc_int_rd_req_ready;
wire          mc_int_rd_req_ready_d0;
wire          mc_int_rd_req_ready_d1;
wire          mc_int_rd_req_valid;
wire          mc_int_rd_req_valid_d0;
wire          mc_int_rd_req_valid_d1;
wire          mc_rd_req_rdyi;
wire    [2:0] mode_16to8_req_size;
wire    [8:0] mode_1x1_req_size;
wire          mrdma_rd_stall_cnt_clr;
wire          mrdma_rd_stall_cnt_inc;
wire          rd_req_rdyi;
wire   [58:0] req_addr;
wire    [4:0] size_of_batch;
wire          size_of_elem;
wire    [9:0] size_of_width;
// synoff nets

// monitor nets

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    
assign cmd_done = cmd_accept & is_cube_end;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cmd_process <= 1'b0;
  end else begin
    if (op_load) begin
        cmd_process <= 1'b1;
    end else if (cmd_done) begin
        cmd_process <= 1'b0;
    end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
  // VCS coverage off 
  nv_assert_never #(0,0,"SDP-RDMA: get an op-done without starting the op")      zzz_assert_never_1x (nvdla_core_clk, `ASSERT_RESET, !cmd_process && cmd_done); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON

//assign dp2reg_done = eg2ig_done;

//==============
// Address catenate and offset calc
//==============

//==============
// CFG value calculation 
//==============
assign cfg_base_addr = {reg2dp_src_base_addr_high,reg2dp_src_base_addr_low};

assign cfg_line_stride  = {reg2dp_src_line_stride};
assign cfg_surf_stride  = {reg2dp_src_surface_stride};

//assign cfg_mode_bias = reg2dp_bias_mode;
//assign cfg_mode_bias_per_kernel = (cfg_mode_bias==NVDLA_SDP_RDMA_D_OPERATION_MODE_CFG_0_BIAS_MODE_BIAS_PER_KERNEL);
//assign cfg_mode_bias_per_point = (cfg_mode_bias==NVDLA_SDP_RDMA_D_OPERATION_MODE_CFG_0_BIAS_MODE_BIAS_PER_POINT);
//assign cfg_bias_reload_times = reg2dp_bias_reload_times;

assign cfg_di_int8  = reg2dp_in_precision  == 0 ;
assign cfg_di_int16 = reg2dp_in_precision  == 1 ;
assign cfg_do_int8  = reg2dp_proc_precision == 0 ;
//assign cfg_do_int16 = reg2dp_proc_precision == NVDLA_GENERIC_PRECISION_ENUM_INT16;

assign cfg_mode_16to8 = cfg_di_int16 & cfg_do_int8;

assign cfg_mode_1x1_pack = (reg2dp_width==0) & (reg2dp_height==0);

assign cfg_mode_multi_batch = reg2dp_batch_number!=0;

//==============
// CHANNEL Direction
// calculate how many 32x8 blocks in channel direction
//==============
always @(
  cfg_mode_16to8
  or cfg_mode_1x1_pack
  or reg2dp_channel
  or cfg_di_int8
  or cfg_di_int16
  ) begin
    if (cfg_mode_16to8) begin
        if (cfg_mode_1x1_pack) begin
            size_of_surf = {reg2dp_channel[12:5],1'b1};
        end else begin
            size_of_surf = {1'b0,reg2dp_channel[12:5]};
        end
    end else if (cfg_di_int8) begin
        size_of_surf = {1'b0,reg2dp_channel[12:5]};
    end else if (cfg_di_int16) begin
        size_of_surf = reg2dp_channel[12:4];
    end else begin
        size_of_surf = reg2dp_channel[12:4];
    end
end

//=================================================
// Cube Shape
//=================================================
assign is_batch_end = is_last_b;
assign is_elem_end  = is_batch_end & ( (cfg_mode_1x1_pack) || (!cfg_mode_16to8) || (is_last_e) );
assign is_line_end  = is_elem_end  & ( (cfg_mode_1x1_pack) || (!cfg_mode_16to8) || (is_last_w) );
assign is_surf_end  = is_line_end  & ( (cfg_mode_1x1_pack) || (is_last_h) );
assign is_cube_end  = is_surf_end  & ( (cfg_mode_1x1_pack) || (is_last_c) );

//==============
// Batch Count:
//==============
assign size_of_batch = reg2dp_batch_number;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_b <= {5{1'b0}};
  end else begin
    if (cfg_mode_multi_batch) begin
        if (cmd_accept) begin
            if (is_batch_end) begin
                count_b <= 0;
            end else begin
                count_b <= count_b + 1'b1;
            end
        end
    end
  end
end
assign is_last_b = (count_b==size_of_batch);
//==============
// Element Count: one step in channel direction
// count_e is only used when need precision conversion 16->8
//==============
assign size_of_elem = 1'b1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_e <= 1'b0;
  end else begin
    if (cfg_mode_16to8) begin
        if (cmd_accept) begin
            if (is_elem_end) begin
                count_e <= 0;
            end else begin
                count_e <= count_e + 1'b1;
            end
        end
    end
  end
end
assign is_last_e = (count_e==size_of_elem);

//==============
// Width Count:
// count_w is only used when need precision conversion 16->8
//==============
assign size_of_width = reg2dp_width[12:3];
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_w <= {10{1'b0}};
  end else begin
    if (cfg_mode_16to8) begin
        if (cmd_accept) begin
            if (is_line_end) begin
                count_w <= 0;
            end else if (is_elem_end) begin
                count_w <= count_w + 1'b1;
            end
        end
    end
  end
end
assign is_last_w = (count_w==size_of_width);

//==============
// CHANNEL Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_c <= {9{1'b0}};
  end else begin
    if (cmd_accept) begin
        if (is_cube_end) begin
            count_c <= 0;
        end else if (is_surf_end) begin
            count_c <= count_c + 1'b1;
        end
    end
  end
end
assign is_last_c = (count_c==size_of_surf);

//==============
// LINE Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    count_h <= {13{1'b0}};
  end else begin
    if (cmd_accept) begin
        if (is_surf_end) begin
            count_h <= 0;
        end else if (is_line_end) begin
            count_h <= count_h + 1'b1;
        end
    end
  end
end
assign is_last_h = (count_h==reg2dp_height);

//==========================================
// DMA Req : ADDR PREPARE
//==========================================
// ELEM
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    //base_addr_elem <= {59{1'b0}}; // Removed redundant assignment
    {mon_base_addr_elem_c,base_addr_elem} <= {60{1'b0}};
  end else begin
    if (op_load) begin
        {mon_base_addr_elem_c,base_addr_elem} <= {1'b0, cfg_base_addr}; // Use concatenated assignment
    end else if (cmd_accept) begin
        if (cfg_mode_16to8) begin
            if (is_surf_end) begin
                {mon_base_addr_elem_c,base_addr_elem} <= base_addr_surf + (cfg_surf_stride<<1);
            end else if (is_line_end) begin
                {mon_base_addr_elem_c,base_addr_elem} <= base_addr_line + cfg_line_stride;
            end else if (is_elem_end) begin
                {mon_base_addr_elem_c,base_addr_elem} <= base_addr_width + 8;
            end else begin
                {mon_base_addr_elem_c,base_addr_elem} <= base_addr_elem + cfg_surf_stride;
            end
        end
    end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
  // VCS coverage off 
  nv_assert_never #(0,0,"MRDMA: no overflow is allowed")      zzz_assert_never_2x (nvdla_core_clk, `ASSERT_RESET, mon_base_addr_elem_c); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON

// WIDTH
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    //base_addr_width <= {59{1'b0}}; // Removed redundant assignment
    {mon_base_addr_width_c,base_addr_width} <= {60{1'b0}};
  end else begin
    if (op_load) begin
        {mon_base_addr_width_c,base_addr_width} <= {1'b0, cfg_base_addr}; // Use concatenated assignment
    end else if (cmd_accept) begin
        if (cfg_mode_16to8) begin
            if (is_surf_end) begin
                {mon_base_addr_width_c,base_addr_width} <= base_addr_surf + (cfg_surf_stride<<1);
            end else if (is_line_end) begin
                {mon_base_addr_width_c,base_addr_width} <= base_addr_line + cfg_line_stride;
            end else if (is_elem_end) begin
                {mon_base_addr_width_c,base_addr_width} <= base_addr_width + 8;
            end
        end
    end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
  // VCS coverage off 
  nv_assert_never #(0,0,"MRDMA: no overflow is allowed")      zzz_assert_never_3x (nvdla_core_clk, `ASSERT_RESET, mon_base_addr_width_c); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON

// LINE
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    //base_addr_line <= {59{1'b0}}; // Removed redundant assignment
    {mon_base_addr_line_c,base_addr_line} <= {60{1'b0}};
  end else begin
    if (op_load) begin
        {mon_base_addr_line_c,base_addr_line} <= {1'b0, cfg_base_addr}; // Use concatenated assignment
    end else if (cmd_accept) begin
        if (cfg_mode_16to8) begin
            if (is_surf_end) begin
                {mon_base_addr_line_c,base_addr_line} <= base_addr_surf + (cfg_surf_stride<<1);
            end else if (is_line_end) begin
                {mon_base_addr_line_c,base_addr_line} <= base_addr_line + cfg_line_stride;
            end
        end else begin
            if (is_surf_end) begin
                {mon_base_addr_line_c,base_addr_line} <= base_addr_surf + cfg_surf_stride;
            end else if (is_line_end) begin
                {mon_base_addr_line_c,base_addr_line} <= base_addr_line + cfg_line_stride;
            end
        end
    end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
  // VCS coverage off 
  nv_assert_never #(0,0,"MRDMA: no overflow is allowed")      zzz_assert_never_4x (nvdla_core_clk, `ASSERT_RESET, mon_base_addr_line_c); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON

// SURF
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    //base_addr_surf <= {59{1'b0}}; // Removed redundant assignment
    {mon_base_addr_surf_c,base_addr_surf} <= {60{1'b0}};
  end else begin
    if (op_load) begin
        {mon_base_addr_surf_c,base_addr_surf} <= {1'b0, cfg_base_addr}; // Use concatenated assignment
    end else if (cmd_accept) begin
        if (cfg_mode_16to8) begin
            if (is_surf_end) begin
                {mon_base_addr_surf_c,base_addr_surf} <= base_addr_surf + (cfg_surf_stride<<1);
            end
        end else begin
            if (is_surf_end) begin
                {mon_base_addr_surf_c,base_addr_surf} <= base_addr_surf + cfg_surf_stride;
            end
        end
    end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
  // VCS coverage off 
  nv_assert_never #(0,0,"MRDMA: no overflow is allowed")      zzz_assert_never_5x (nvdla_core_clk, `ASSERT_RESET, mon_base_addr_surf_c); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON

//==========================================
// DMA Req : Addr : Generation
//==========================================
assign req_addr = cfg_mode_16to8 ? base_addr_elem : base_addr_line;
assign dma_req_addr = {req_addr,5'd0};

//==============
// DMA Req : SIZE : Generation
//==============
// in 16to8 mode, always send full size (size=7), and send the remaining in the last req
assign mode_16to8_req_size = (is_last_w) ? reg2dp_width[2:0] : 3'd7;
// in 1x1_pack mode, only send one request out 
assign mode_1x1_req_size = size_of_surf;
always @(
  cfg_mode_1x1_pack
  or mode_1x1_req_size
  or cfg_mode_16to8
  or mode_16to8_req_size
  or reg2dp_width
  ) begin
    if (cfg_mode_1x1_pack) begin
        dma_req_size = {{6{1'b0}}, mode_1x1_req_size};
    end else if (cfg_mode_16to8) begin
        dma_req_size = {{12{1'b0}}, mode_16to8_req_size};
    end else begin
        dma_req_size = {{2{1'b0}}, reg2dp_width};
    end
end

assign ig2eg_size = dma_req_size;
assign ig2eg_cube_end  = is_cube_end;

// PKT_PACK_WIRE( sdp_mrdma_ig2eg ,  ig2eg_ ,  ig2cq_pd )
assign       ig2cq_pd[12:0] =     ig2eg_size[12:0];
assign       ig2cq_pd[13] =     ig2eg_cube_end ;
assign ig2cq_pvld = cmd_process & dma_rd_req_rdy;

`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
  // VCS coverage off 
  nv_assert_never #(0,0,"SDP-RDMA: CQ and DMA should accept or reject together")      zzz_assert_never_6x (nvdla_core_clk, `ASSERT_RESET, (ig2cq_pvld & ig2cq_prdy) ^ (dma_rd_req_vld & dma_rd_req_rdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON

//==============
// DMA Req : PIPE
//==============
// VALID: clamp when when cq is not ready
assign dma_rd_req_vld = cmd_process & ig2cq_prdy;

// PayLoad

// PKT_PACK_WIRE( dma_read_cmd ,  dma_req_ ,  dma_rd_req_pd )
assign       dma_rd_req_pd[63:0] =     dma_req_addr[63:0];
assign       dma_rd_req_pd[78:64] =     dma_req_size[14:0];

assign dma_rd_req_ram_type   = reg2dp_src_ram_type;
// Accept
assign cmd_accept = dma_rd_req_vld & dma_rd_req_rdy;
//==============
// DMA Interface
//==============
//dma_rd_req_vld dma_rd_req_rdy dma_rd_req_ram_type
// rd Channel: Request 
assign cv_dma_rd_req_vld = dma_rd_req_vld & (dma_rd_req_ram_type == 1'b0);
assign mc_dma_rd_req_vld = dma_rd_req_vld & (dma_rd_req_ram_type == 1'b1);
assign cv_rd_req_rdyi = cv_dma_rd_req_rdy & (dma_rd_req_ram_type == 1'b0);
assign mc_rd_req_rdyi = mc_dma_rd_req_rdy & (dma_rd_req_ram_type == 1'b1);
assign rd_req_rdyi = mc_rd_req_rdyi | cv_rd_req_rdyi;
assign dma_rd_req_rdy= rd_req_rdyi;
NV_NVDLA_SDP_MRDMA_IG_pipe_p1 pipe_p1 (
   .nvdla_core_clk         (nvdla_core_clk)            //|< i
  ,.nvdla_core_rstn        (nvdla_core_rstn)           //|< i
  ,.dma_rd_req_pd          (dma_rd_req_pd[78:0])       //|< w
  ,.mc_dma_rd_req_vld      (mc_dma_rd_req_vld)         //|< w
  ,.mc_int_rd_req_ready    (mc_int_rd_req_ready)       //|< w
  ,.mc_dma_rd_req_rdy      (mc_dma_rd_req_rdy)         //|> w
  ,.mc_int_rd_req_pd       (mc_int_rd_req_pd[78:0])    //|> w
  ,.mc_int_rd_req_valid    (mc_int_rd_req_valid)       //|> w
  );
NV_NVDLA_SDP_MRDMA_IG_pipe_p2 pipe_p2 (
   .nvdla_core_clk         (nvdla_core_clk)            //|< i
  ,.nvdla_core_rstn        (nvdla_core_rstn)           //|< i
  ,.cv_dma_rd_req_vld      (cv_dma_rd_req_vld)         //|< w
  ,.cv_int_rd_req_ready    (cv_int_rd_req_ready)       //|< w
  ,.dma_rd_req_pd          (dma_rd_req_pd[78:0])       //|< w
  ,.cv_dma_rd_req_rdy      (cv_dma_rd_req_rdy)         //|> w
  ,.cv_int_rd_req_pd       (cv_int_rd_req_pd[78:0])    //|> w
  ,.cv_int_rd_req_valid    (cv_int_rd_req_valid)       //|> w
  );

assign mc_int_rd_req_valid_d0 = mc_int_rd_req_valid;
assign mc_int_rd_req_ready = mc_int_rd_req_ready_d0;
assign mc_int_rd_req_pd_d0[78:0] = mc_int_rd_req_pd[78:0];
NV_NVDLA_SDP_MRDMA_IG_pipe_p3 pipe_p3 (
   .nvdla_core_clk         (nvdla_core_clk)            //|< i
  ,.nvdla_core_rstn        (nvdla_core_rstn)           //|< i
  ,.mc_int_rd_req_pd_d0    (mc_int_rd_req_pd_d0[78:0]) //|< w
  ,.mc_int_rd_req_ready_d1 (mc_int_rd_req_ready_d1)    //|< w
  ,.mc_int_rd_req_valid_d0 (mc_int_rd_req_valid_d0)    //|< w
  ,.mc_int_rd_req_pd_d1    (mc_int_rd_req_pd_d1[78:0]) //|> w
  ,.mc_int_rd_req_ready_d0 (mc_int_rd_req_ready_d0)    //|> w
  ,.mc_int_rd_req_valid_d1 (mc_int_rd_req_valid_d1)    //|> w
  );
assign sdp2mcif_rd_req_valid = mc_int_rd_req_valid_d1;
assign mc_int_rd_req_ready_d1 = sdp2mcif_rd_req_ready;
assign sdp2mcif_rd_req_pd[78:0] = mc_int_rd_req_pd_d1[78:0];


assign cv_int_rd_req_valid_d0 = cv_int_rd_req_valid;
assign cv_int_rd_req_ready = cv_int_rd_req_ready_d0;
assign cv_int_rd_req_pd_d0[78:0] = cv_int_rd_req_pd[78:0];
NV_NVDLA_SDP_MRDMA_IG_pipe_p4 pipe_p4 (
   .nvdla_core_clk         (nvdla_core_clk)            //|< i
  ,.nvdla_core_rstn        (nvdla_core_rstn)           //|< i
  ,.cv_int_rd_req_pd_d0    (cv_int_rd_req_pd_d0[78:0]) //|< w
  ,.cv_int_rd_req_ready_d1 (cv_int_rd_req_ready_d1)    //|< w
  ,.cv_int_rd_req_valid_d0 (cv_int_rd_req_valid_d0)    //|< w
  ,.cv_int_rd_req_pd_d1    (cv_int_rd_req_pd_d1[78:0]) //|> w
  ,.cv_int_rd_req_ready_d0 (cv_int_rd_req_ready_d0)    //|> w
  ,.cv_int_rd_req_valid_d1 (cv_int_rd_req_valid_d1)    //|> w
  );
assign sdp2cvif_rd_req_valid = cv_int_rd_req_valid_d1;
assign cv_int_rd_req_ready_d1 = sdp2cvif_rd_req_ready;
assign sdp2cvif_rd_req_pd[78:0] = cv_int_rd_req_pd_d1[78:0];


//==============
// PERF STATISTIC
assign mrdma_rd_stall_cnt_inc = dma_rd_req_vld & !dma_rd_req_rdy;
assign mrdma_rd_stall_cnt_clr = op_load;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    mrdma_rd_stall_cnt_cen <= 1'b0;
  end else begin
    if (op_load) begin
      mrdma_rd_stall_cnt_cen <= reg2dp_perf_dma_en;
    end else begin
      mrdma_rd_stall_cnt_cen <= 1'b0;
    end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML 
// spyglass disable_block STARC-2.10.3.2a 
// spyglass disable_block STARC05-2.1.3.1 
// spyglass disable_block STARC-2.1.4.6 
// spyglass disable_block W116 
// spyglass disable_block W154 
// spyglass disable_block W239 
// spyglass disable_block W362 
// spyglass disable_block WRN_58 
// spyglass disable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
  // VCS coverage off 
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals")      zzz_assert_no_x_7x (nvdla_core_clk, `ASSERT_RESET, 1'd1,  (^(op_load))); // spyglass disable W504 SelfDeterminedExpr-ML 
  // VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML 
// spyglass enable_block STARC-2.10.3.2a 
// spyglass enable_block STARC05-2.1.3.1 
// spyglass enable_block STARC-2.1.4.6 
// spyglass enable_block W116 
// spyglass enable_block W154 
// spyglass enable_block W239 
// spyglass enable_block W362 
// spyglass enable_block WRN_58 
// spyglass enable_block WRN_61 
`endif // SPYGLASS_ASSERT_ON



    assign dp2reg_mrdma_stall_dec = 1'b0;

    // stl adv logic

    always @(
      mrdma_rd_stall_cnt_inc
      or dp2reg_mrdma_stall_dec
      ) begin
      stl_adv = mrdma_rd_stall_cnt_inc ^ dp2reg_mrdma_stall_dec;
    end
        
    // stl cnt logic
    always @(
      stl_cnt_cur
      or mrdma_rd_stall_cnt_inc
      or dp2reg_mrdma_stall_dec
      or stl_adv
      or mrdma_rd_stall_cnt_clr
      ) begin
      // VCS sop_coverage_off start
      stl_cnt_ext[33:0] = {1'b0, 1'b0, stl_cnt_cur};
      stl_cnt_inc[33:0] = stl_cnt_cur + 1'b1; // spyglass disable W164b
      stl_cnt_dec[33:0] = stl_cnt_cur - 1'b1; // spyglass disable W164b
      stl_cnt_mod[33:0] = (mrdma_rd_stall_cnt_inc && !dp2reg_mrdma_stall_dec)? stl_cnt_inc : (!mrdma_rd_stall_cnt_inc && dp2reg_mrdma_stall_dec)? stl_cnt_dec : stl_cnt_ext;
      stl_cnt_new[33:0] = (stl_adv)? stl_cnt_mod[33:0] : stl_cnt_ext[33:0];
      stl_cnt_nxt[33:0] = (mrdma_rd_stall_cnt_clr)? 34'd0 : stl_cnt_new[33:0];
      // VCS sop_coverage_off end
    end

    // stl flops

    always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
      if (!nvdla_core_rstn) begin
        stl_cnt_cur[31:0] <= 0;
      end else begin
      if (mrdma_rd_stall_cnt_cen) begin
      stl_cnt_cur[31:0] <= stl_cnt_nxt[31:0];
      end
      end
    end

    // stl output logic

    always @(
      stl_cnt_cur
      ) begin
      dp2reg_mrdma_stall[31:0] = stl_cnt_cur[31:0];
    end
        
      

//==============
// OBS BUS
//assign obs_bus_sdp_mrdma_ig_cmd_done          = cmd_done;
//assign obs_bus_sdp_mrdma_ig_cq_wr_prdy        = ig2cq_prdy; 
//assign obs_bus_sdp_mrdma_ig_cq_wr_pvld        = ig2cq_prdy; 
//assign obs_bus_sdp_mrdma_ig_cube_end          = is_cube_end; 
//assign obs_bus_sdp_mrdma_ig_cvif_rd_req_ready = sdp2cvif_rd_req_ready; 
//assign obs_bus_sdp_mrdma_ig_cvif_rd_req_valid = sdp2cvif_rd_req_valid; 
//assign obs_bus_sdp_mrdma_ig_mcif_rd_req_ready = sdp2mcif_rd_req_ready; 
//assign obs_bus_sdp_mrdma_ig_mcif_rd_req_valid = sdp2mcif_rd_req_valid; 

//==============
// FUNCTION POINT

//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT

    reg funcpoint_cover_off;
    initial begin
        if ( $test$plusargs( "cover_off" ) ) begin
            funcpoint_cover_off = 1'b1;
        end else begin
            funcpoint_cover_off = 1'b0;
        end
    end

    property sdp_mrdma_ig__access_CVIF__0_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((dma_rd_req_vld) && nvdla_core_rstn) |-> (dma_rd_req_ram_type==0);
    endproperty
    // Cover 0 : "dma_rd_req_ram_type==0"
    FUNCPOINT_sdp_mrdma_ig__access_CVIF__0_COV : cover property (sdp_mrdma_ig__access_CVIF__0_cov);

  `endif
`endif
//VCS coverage on

//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT

    property sdp_mrdma_ig__access_MCIF__1_cov;
        disable iff((nvdla_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge nvdla_core_clk)
        ((dma_rd_req_vld) && nvdla_core_rstn) |-> (dma_rd_req_ram_type==1);
    endproperty
    // Cover 1 : "dma_rd_req_ram_type==1"
    FUNCPOINT_sdp_mrdma_ig__access_MCIF__1_COV : cover property (sdp_mrdma_ig__access_MCIF__1_cov);

  `endif
`endif
//VCS coverage on


endmodule
