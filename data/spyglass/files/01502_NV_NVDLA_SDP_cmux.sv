module NV_NVDLA_SDP_cmux (
   nvdla_core_clk        //|< i
  ,nvdla_core_rstn       //|< i
  ,cacc2sdp_pd           //|< i
  ,cacc2sdp_valid        //|< i
  ,op_en_load            //|< i
  ,reg2dp_flying_mode    //|< i
  ,reg2dp_nan_to_zero    //|< i
  ,reg2dp_proc_precision //|< i
  ,sdp_cmux2dp_ready     //|< i
  ,sdp_mrdma2cmux_pd     //|< i
  ,sdp_mrdma2cmux_valid  //|< i
  ,cacc2sdp_ready        //|> o
  ,sdp_cmux2dp_pd        //|> o
  ,sdp_cmux2dp_valid     //|> o
  ,sdp_mrdma2cmux_ready  //|> o
  );

//
// NV_NVDLA_SDP_cmux_ports.v
//
input  nvdla_core_clk;
input  nvdla_core_rstn;

input          cacc2sdp_valid;  /* data valid */
output         cacc2sdp_ready;  /* data return handshake */
input  [513:0] cacc2sdp_pd;

input          sdp_mrdma2cmux_valid;  /* data valid */
output         sdp_mrdma2cmux_ready;  /* data return handshake */
input  [513:0] sdp_mrdma2cmux_pd;

input          sdp_cmux2dp_ready;
output [511:0] sdp_cmux2dp_pd;
output         sdp_cmux2dp_valid;
input          reg2dp_flying_mode;
input          reg2dp_nan_to_zero;
input    [1:0] reg2dp_proc_precision;
input          op_en_load;
reg            cfg_flying_mode_on;
reg            cfg_nan_to_zero;
reg            cfg_proc_precision;
reg            cmux_in_en;
wire   [513:0] cacc_pd;
wire           cacc_rdy;
wire           cacc_vld;
wire           cfg_nan_to_zero_en;
wire   [511:0] cmux2dp_pd;
wire           cmux2dp_prdy;
wire           cmux2dp_pvld;
wire   [513:0] cmux_pd;
wire           cmux_pd_batch_end;
wire    [31:0] cmux_pd_data0;
wire    [31:0] cmux_pd_data1;
wire    [31:0] cmux_pd_data10;
wire    [31:0] cmux_pd_data11;
wire    [31:0] cmux_pd_data12;
wire    [31:0] cmux_pd_data13;
wire    [31:0] cmux_pd_data14;
wire    [31:0] cmux_pd_data15;
wire    [31:0] cmux_pd_data2;
wire    [31:0] cmux_pd_data3;
wire    [31:0] cmux_pd_data4;
wire    [31:0] cmux_pd_data5;
wire    [31:0] cmux_pd_data6;
wire    [31:0] cmux_pd_data7;
wire    [31:0] cmux_pd_data8;
wire    [31:0] cmux_pd_data9;
wire           cmux_pd_flush_batch_end_NC;
wire   [511:0] cmux_pd_flush_data;
wire           cmux_pd_layer_end;
wire    [31:0] data_byte0;
wire     [7:0] data_byte0_expo;
wire    [31:0] data_byte0_flush;
wire    [22:0] data_byte0_mant;
wire    [31:0] data_byte1;
wire    [31:0] data_byte10;
wire     [7:0] data_byte10_expo;
wire    [31:0] data_byte10_flush;
wire    [22:0] data_byte10_mant;
wire    [31:0] data_byte11;
wire     [7:0] data_byte11_expo;
wire    [31:0] data_byte11_flush;
wire    [22:0] data_byte11_mant;
wire    [31:0] data_byte12;
wire     [7:0] data_byte12_expo;
wire    [31:0] data_byte12_flush;
wire    [22:0] data_byte12_mant;
wire    [31:0] data_byte13;
wire     [7:0] data_byte13_expo;
wire    [31:0] data_byte13_flush;
wire    [22:0] data_byte13_mant;
wire    [31:0] data_byte14;
wire     [7:0] data_byte14_expo;
wire    [31:0] data_byte14_flush;
wire    [22:0] data_byte14_mant;
wire    [31:0] data_byte15;
wire     [7:0] data_byte15_expo;
wire    [31:0] data_byte15_flush;
wire    [22:0] data_byte15_mant;
wire     [7:0] data_byte1_expo;
wire    [31:0] data_byte1_flush;
wire    [22:0] data_byte1_mant;
wire    [31:0] data_byte2;
wire     [7:0] data_byte2_expo;
wire    [31:0] data_byte2_flush;
wire    [22:0] data_byte2_mant;
wire    [31:0] data_byte3;
wire     [7:0] data_byte3_expo;
wire    [31:0] data_byte3_flush;
wire    [22:0] data_byte3_mant;
wire    [31:0] data_byte4;
wire     [7:0] data_byte4_expo;
wire    [31:0] data_byte4_flush;
wire    [22:0] data_byte4_mant;
wire    [31:0] data_byte5;
wire     [7:0] data_byte5_expo;
wire    [31:0] data_byte5_flush;
wire    [22:0] data_byte5_mant;
wire    [31:0] data_byte6;
wire     [7:0] data_byte6_expo;
wire    [31:0] data_byte6_flush;
wire    [22:0] data_byte6_mant;
wire    [31:0] data_byte7;
wire     [7:0] data_byte7_expo;
wire    [31:0] data_byte7_flush;
wire    [22:0] data_byte7_mant;
wire    [31:0] data_byte8;
wire     [7:0] data_byte8_expo;
wire    [31:0] data_byte8_flush;
wire    [22:0] data_byte8_mant;
wire    [31:0] data_byte9;
wire     [7:0] data_byte9_expo;
wire    [31:0] data_byte9_flush;
wire    [22:0] data_byte9_mant;
wire           is_data_byte0_nan;
wire           is_data_byte10_nan;
wire           is_data_byte11_nan;
wire           is_data_byte12_nan;
wire           is_data_byte13_nan;
wire           is_data_byte14_nan;
wire           is_data_byte15_nan;
wire           is_data_byte1_nan;
wire           is_data_byte2_nan;
wire           is_data_byte3_nan;
wire           is_data_byte4_nan;
wire           is_data_byte5_nan;
wire           is_data_byte6_nan;
wire           is_data_byte7_nan;
wire           is_data_byte8_nan;
wire           is_data_byte9_nan;
// synoff nets

// monitor nets

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    
//=======================
// CFG
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cfg_flying_mode_on <= 1'b0;
  end else begin
  cfg_flying_mode_on <= reg2dp_flying_mode == 1'h1;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cfg_nan_to_zero <= 1'b0;
  end else begin
  cfg_nan_to_zero <= reg2dp_nan_to_zero == 1'h1;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cfg_proc_precision <= 1'b0;
  end else begin
  cfg_proc_precision <= reg2dp_proc_precision == 2'h2;
  end
end
assign cfg_nan_to_zero_en = cfg_nan_to_zero & cfg_proc_precision;

NV_NVDLA_SDP_CMUX_pipe_p1 pipe_p1 (
   .nvdla_core_clk    (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn   (nvdla_core_rstn)       //|< i
  ,.cacc2sdp_pd       (cacc2sdp_pd[513:0])    //|< i
  ,.cacc2sdp_valid    (cacc2sdp_valid)        //|< i
  ,.cacc_rdy          (cacc_rdy)              //|< w
  ,.cacc2sdp_ready    (cacc2sdp_ready)        //|> o
  ,.cacc_pd           (cacc_pd[513:0])        //|> w
  ,.cacc_vld          (cacc_vld)              //|> w
  );
assign cmux2dp_pvld = cmux_in_en & ((cfg_flying_mode_on) ? cacc_vld : sdp_mrdma2cmux_valid);

assign cacc_rdy             = cmux_in_en &   cfg_flying_mode_on  & cmux2dp_prdy;
assign sdp_mrdma2cmux_ready = cmux_in_en & (!cfg_flying_mode_on) & cmux2dp_prdy;

//===========================================
// Layer Switch
//===========================================
assign cmux_pd   = (cfg_flying_mode_on) ? cacc_pd    : sdp_mrdma2cmux_pd;

// flush NAN to zero

// PKT_UNPACK_WIRE( nvdla_cc2pp_pkg ,  cmux_pd_  ,  cmux_pd  )
assign        cmux_pd_data0[31:0] =     cmux_pd[31:0];
assign        cmux_pd_data1[31:0] =     cmux_pd[63:32];
assign        cmux_pd_data2[31:0] =     cmux_pd[95:64];
assign        cmux_pd_data3[31:0] =     cmux_pd[127:96];
assign        cmux_pd_data4[31:0] =     cmux_pd[159:128];
assign        cmux_pd_data5[31:0] =     cmux_pd[191:160];
assign        cmux_pd_data6[31:0] =     cmux_pd[223:192];
assign        cmux_pd_data7[31:0] =     cmux_pd[255:224];
assign        cmux_pd_data8[31:0] =     cmux_pd[287:256];
assign        cmux_pd_data9[31:0] =     cmux_pd[319:288];
assign        cmux_pd_data10[31:0] =     cmux_pd[351:320];
assign        cmux_pd_data11[31:0] =     cmux_pd[383:352];
assign        cmux_pd_data12[31:0] =     cmux_pd[415:384];
assign        cmux_pd_data13[31:0] =     cmux_pd[447:416];
assign        cmux_pd_data14[31:0] =     cmux_pd[479:448];
assign        cmux_pd_data15[31:0] =     cmux_pd[511:480];
assign         cmux_pd_batch_end  =     cmux_pd[512];
assign         cmux_pd_layer_end  =     cmux_pd[513];
assign cmux_pd_flush_batch_end_NC = cmux_pd_batch_end;
//assign cmux_pd_flush_layer_end = cmux_pd_layer_end;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    cmux_in_en <= 1'b0;
  end else begin
    if (op_en_load) begin
       cmux_in_en  <= 1'b1;
    end else if (cmux_pd_layer_end && cmux2dp_pvld && cmux2dp_prdy) begin
       cmux_in_en  <= 1'b0;
    end
  end
end

//=======================

assign data_byte0 = cmux_pd_data0;
assign data_byte0_expo = data_byte0[30:23];
assign data_byte0_mant = data_byte0[22:0];
assign is_data_byte0_nan = (data_byte0_expo==8'hff) & (data_byte0_mant!=0);

assign data_byte0_flush = (cfg_nan_to_zero_en & is_data_byte0_nan)? 32'h0 : data_byte0;
assign cmux_pd_flush_data[31:0] = data_byte0_flush;
assign data_byte1 = cmux_pd_data1;
assign data_byte1_expo = data_byte1[30:23];
assign data_byte1_mant = data_byte1[22:0];
assign is_data_byte1_nan = (data_byte1_expo==8'hff) & (data_byte1_mant!=0);

assign data_byte1_flush = (cfg_nan_to_zero_en & is_data_byte1_nan)? 32'h0 : data_byte1;
assign cmux_pd_flush_data[63:32] = data_byte1_flush;
assign data_byte2 = cmux_pd_data2;
assign data_byte2_expo = data_byte2[30:23];
assign data_byte2_mant = data_byte2[22:0];
assign is_data_byte2_nan = (data_byte2_expo==8'hff) & (data_byte2_mant!=0);

assign data_byte2_flush = (cfg_nan_to_zero_en & is_data_byte2_nan)? 32'h0 : data_byte2;
assign cmux_pd_flush_data[95:64] = data_byte2_flush;
assign data_byte3 = cmux_pd_data3;
assign data_byte3_expo = data_byte3[30:23];
assign data_byte3_mant = data_byte3[22:0];
assign is_data_byte3_nan = (data_byte3_expo==8'hff) & (data_byte3_mant!=0);

assign data_byte3_flush = (cfg_nan_to_zero_en & is_data_byte3_nan)? 32'h0 : data_byte3;
assign cmux_pd_flush_data[127:96] = data_byte3_flush;
assign data_byte4 = cmux_pd_data4;
assign data_byte4_expo = data_byte4[30:23];
assign data_byte4_mant = data_byte4[22:0];
assign is_data_byte4_nan = (data_byte4_expo==8'hff) & (data_byte4_mant!=0);

assign data_byte4_flush = (cfg_nan_to_zero_en & is_data_byte4_nan)? 32'h0 : data_byte4;
assign cmux_pd_flush_data[159:128] = data_byte4_flush;
assign data_byte5 = cmux_pd_data5;
assign data_byte5_expo = data_byte5[30:23];
assign data_byte5_mant = data_byte5[22:0];
assign is_data_byte5_nan = (data_byte5_expo==8'hff) & (data_byte5_mant!=0);

assign data_byte5_flush = (cfg_nan_to_zero_en & is_data_byte5_nan)? 32'h0 : data_byte5;
assign cmux_pd_flush_data[191:160] = data_byte5_flush;
assign data_byte6 = cmux_pd_data6;
assign data_byte6_expo = data_byte6[30:23];
assign data_byte6_mant = data_byte6[22:0];
assign is_data_byte6_nan = (data_byte6_expo==8'hff) & (data_byte6_mant!=0);

assign data_byte6_flush = (cfg_nan_to_zero_en & is_data_byte6_nan)? 32'h0 : data_byte6;
assign cmux_pd_flush_data[223:192] = data_byte6_flush;
assign data_byte7 = cmux_pd_data7;
assign data_byte7_expo = data_byte7[30:23];
assign data_byte7_mant = data_byte7[22:0];
assign is_data_byte7_nan = (data_byte7_expo==8'hff) & (data_byte7_mant!=0);

assign data_byte7_flush = (cfg_nan_to_zero_en & is_data_byte7_nan)? 32'h0 : data_byte7;
assign cmux_pd_flush_data[255:224] = data_byte7_flush;
assign data_byte8 = cmux_pd_data8;
assign data_byte8_expo = data_byte8[30:23];
assign data_byte8_mant = data_byte8[22:0];
assign is_data_byte8_nan = (data_byte8_expo==8'hff) & (data_byte8_mant!=0);

assign data_byte8_flush = (cfg_nan_to_zero_en & is_data_byte8_nan)? 32'h0 : data_byte8;
assign cmux_pd_flush_data[287:256] = data_byte8_flush;
assign data_byte9 = cmux_pd_data9;
assign data_byte9_expo = data_byte9[30:23];
assign data_byte9_mant = data_byte9[22:0];
assign is_data_byte9_nan = (data_byte9_expo==8'hff) & (data_byte9_mant!=0);

assign data_byte9_flush = (cfg_nan_to_zero_en & is_data_byte9_nan)? 32'h0 : data_byte9;
assign cmux_pd_flush_data[319:288] = data_byte9_flush;
assign data_byte10 = cmux_pd_data10;
assign data_byte10_expo = data_byte10[30:23];
assign data_byte10_mant = data_byte10[22:0];
assign is_data_byte10_nan = (data_byte10_expo==8'hff) & (data_byte10_mant!=0);

assign data_byte10_flush = (cfg_nan_to_zero_en & is_data_byte10_nan)? 32'h0 : data_byte10;
assign cmux_pd_flush_data[351:320] = data_byte10_flush;
assign data_byte11 = cmux_pd_data11;
assign data_byte11_expo = data_byte11[30:23];
assign data_byte11_mant = data_byte11[22:0];
assign is_data_byte11_nan = (data_byte11_expo==8'hff) & (data_byte11_mant!=0);

assign data_byte11_flush = (cfg_nan_to_zero_en & is_data_byte11_nan)? 32'h0 : data_byte11;
assign cmux_pd_flush_data[383:352] = data_byte11_flush;
assign data_byte12 = cmux_pd_data12;
assign data_byte12_expo = data_byte12[30:23];
assign data_byte12_mant = data_byte12[22:0];
assign is_data_byte12_nan = (data_byte12_expo==8'hff) & (data_byte12_mant!=0);

assign data_byte12_flush = (cfg_nan_to_zero_en & is_data_byte12_nan)? 32'h0 : data_byte12;
assign cmux_pd_flush_data[415:384] = data_byte12_flush;
assign data_byte13 = cmux_pd_data13;
assign data_byte13_expo = data_byte13[30:23];
assign data_byte13_mant = data_byte13[22:0];
assign is_data_byte13_nan = (data_byte13_expo==8'hff) & (data_byte13_mant!=0);

assign data_byte13_flush = (cfg_nan_to_zero_en & is_data_byte13_nan)? 32'h0 : data_byte13;
assign cmux_pd_flush_data[447:416] = data_byte13_flush;
assign data_byte14 = cmux_pd_data14;
assign data_byte14_expo = data_byte14[30:23];
assign data_byte14_mant = data_byte14[22:0];
assign is_data_byte14_nan = (data_byte14_expo==8'hff) & (data_byte14_mant!=0);

assign data_byte14_flush = (cfg_nan_to_zero_en & is_data_byte14_nan)? 32'h0 : data_byte14;
assign cmux_pd_flush_data[479:448] = data_byte14_flush;
assign data_byte15 = cmux_pd_data15;
assign data_byte15_expo = data_byte15[30:23];
assign data_byte15_mant = data_byte15[22:0];
assign is_data_byte15_nan = (data_byte15_expo==8'hff) & (data_byte15_mant!=0);

assign data_byte15_flush = (cfg_nan_to_zero_en & is_data_byte15_nan)? 32'h0 : data_byte15;
assign cmux_pd_flush_data[511:480] = data_byte15_flush;

//assign nan_input_num[::range(5)] = ::replcat_dn(16, " + ", 'is_data_byte${ii}_nan');
//assign nan_input_cen = cmux2dp_pvld & cmux2dp_prdy & (::replcat_dn(16, " | ", 'is_data_byte${ii}_nan'));
//
//assign {nan_input_cnt_add_c,nan_input_cnt_add[::range(32)]} = nan_input_cnt[::range(32)] + nan_input_num;
//assign nan_input_cnt_nxt = nan_input_cnt_add_c ? 32'hffff_ffff : nan_input_cnt_add;
//
//&Always posedge;
//    if (cfg_perf_nan_inf_count_en) begin
//        if (op_en_load) begin
//            nan_input_cnt <0= 0;
//        end else if (nan_input_cen) begin
//            nan_input_cnt <0= nan_input_cnt_nxt;
//        end
//    end
//&End;
//assign dp2reg_status_nan_input_num = nan_input_cnt;
//
//assign inf_input_num[::range(5)] = ::replcat_dn(16, " + ", 'is_data_byte${ii}_inf');
//assign inf_input_cen = cmux2dp_pvld & cmux2dp_prdy & (::replcat_dn(16, " | ", 'is_data_byte${ii}_inf'));
//
//assign {inf_input_cnt_add_c,inf_input_cnt_add[::range(32)]} = inf_input_cnt[::range(32)] + inf_input_num;
//assign inf_input_cnt_nxt = inf_input_cnt_add_c ? 32'hffff_ffff : inf_input_cnt_add;
//
//&Always posedge;
//    if (cfg_perf_nan_inf_count_en) begin
//        if (op_en_load) begin
//            inf_input_cnt <0= 0;
//        end else if (inf_input_cen) begin
//            inf_input_cnt <0= inf_input_cnt_nxt;
//        end
//    end
//&End;
//assign dp2reg_status_inf_input_num = inf_input_cnt;


// PKT_PACK_WIRE(  sdp_cmux2dp  ,  cmux_pd_flush_  ,  cmux2dp_pd  )
assign       cmux2dp_pd[511:0] =     cmux_pd_flush_data[511:0];

NV_NVDLA_SDP_CMUX_pipe_p2 pipe_p2 (
   .nvdla_core_clk    (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn   (nvdla_core_rstn)       //|< i
  ,.cmux2dp_pd        (cmux2dp_pd[511:0])     //|< w
  ,.cmux2dp_pvld      (cmux2dp_pvld)          //|< w
  ,.sdp_cmux2dp_ready (sdp_cmux2dp_ready)     //|< i
  ,.cmux2dp_prdy      (cmux2dp_prdy)          //|> w
  ,.sdp_cmux2dp_pd    (sdp_cmux2dp_pd[511:0]) //|> o
  ,.sdp_cmux2dp_valid (sdp_cmux2dp_valid)     //|> o
  );
//assign sdp_cmux2dp_pd = cmux2dp_pd;
//assign sdp_cmux2dp_valid = cmux2dp_pvld;
//assign cmux2dp_prdy = sdp_cmux2dp_ready;

endmodule
