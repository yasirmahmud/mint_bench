module NV_NVDLA_SDP_HLS_lut_expn (
   cfg_lut_offset  //|< i
  ,cfg_lut_start   //|< i
  ,idx_data_in     //|< i
  ,idx_in_pvld     //|< i
  ,idx_out_prdy    //|< i
  ,nvdla_core_clk  //|< i
  ,nvdla_core_rstn //|< i
  ,idx_in_prdy     //|> o
  ,idx_out_pvld    //|> o
  ,lut_frac_out    //|> o
  ,lut_index_out   //|> o
  ,lut_oflow_out   //|> o
  ,lut_uflow_out   //|> o
  );

parameter   LUT_DEPTH = 256;

input   [7:0] cfg_lut_offset;
input  [31:0] cfg_lut_start;
input  [31:0] idx_data_in;
input         idx_in_pvld;
input         idx_out_prdy;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output        idx_in_prdy;
output        idx_out_pvld;
output [34:0] lut_frac_out;
output  [8:0] lut_index_out;
output        lut_oflow_out;
output        lut_uflow_out;

reg     [8:0] lut_index_final;
wire    [8:0] cfg_lut_offset_ext;
wire   [31:0] filter_frac;
wire    [4:0] leadzero;
wire   [31:0] log2_lut_frac;
wire   [31:0] log2_lut_frac_reg;
wire   [31:0] log2_lut_index;
wire    [8:0] log2_lut_index_reg;
wire    [8:0] log2_lut_index_tru;
wire          log2_prdy;
wire          log2_pvld;
wire   [34:0] lut_frac_final;
wire   [31:0] lut_index_sub;
wire    [8:0] lut_index_sub_mid;
wire    [9:0] lut_index_sub_mid_tmp;
wire   [31:0] lut_index_sub_reg;
wire   [31:0] lut_index_sub_tmp;
wire          lut_oflow_final;
wire          lut_uflow_final;
wire          lut_uflow_in;
wire          lut_uflow_mid;
wire          lut_uflow_reg;
wire          lut_uflow_reg2;
wire          mon_lutin_sub_c;
wire          mon_lutmid_sub_c;
wire          sub_prdy;
wire          sub_pvld;


// synoff nets

// monitor nets

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    
assign  lut_uflow_in = ($signed(idx_data_in[31:0]) <= $signed(cfg_lut_start[31:0])); 

assign  {mon_lutin_sub_c,lut_index_sub_tmp[31:0]} = $signed(idx_data_in[31:0])- $signed(cfg_lut_start[31:0]);

//unsigned int
assign  lut_index_sub[31:0] = lut_uflow_in ? 0 : lut_index_sub_tmp[31:0];

NV_NVDLA_SDP_HLS_LUT_EXPN_pipe_p1 pipe_p1 (
   .nvdla_core_clk     (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)         //|< i
  ,.idx_in_pvld        (idx_in_pvld)             //|< i
  ,.lut_index_sub      (lut_index_sub[31:0])     //|< w
  ,.lut_uflow_in       (lut_uflow_in)            //|< w
  ,.sub_prdy           (sub_prdy)                //|< w
  ,.idx_in_prdy        (idx_in_prdy)             //|> o
  ,.lut_index_sub_reg  (lut_index_sub_reg[31:0]) //|> w
  ,.lut_uflow_reg      (lut_uflow_reg)           //|> w
  ,.sub_pvld           (sub_pvld)                //|> w
  );

//log2 function
wire loadzero_nc;
NV_DW_lsd #(.a_width(33)) log2_dw_lsd(.a({1'b0,lut_index_sub_reg[31:0]}), .enc({leadzero_nc, leadzero[4:0]}), .dec());    //unsigned 

assign  log2_lut_index[31:0] = (lut_uflow_reg | !(|lut_index_sub_reg)) ? {32{1'b0}} : (31 - leadzero[4:0]);   //morework

assign  filter_frac[31:0] = (1 << log2_lut_index) - 1 ; 

assign  log2_lut_frac[31:0] = lut_index_sub_reg & filter_frac;
//log2 end

assign  log2_lut_index_tru[8:0] = log2_lut_index[8:0];    //always positive

NV_NVDLA_SDP_HLS_LUT_EXPN_pipe_p2 pipe_p2 (
   .nvdla_core_clk     (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)         //|< i
  ,.log2_lut_frac      (log2_lut_frac[31:0])     //|< w
  ,.log2_lut_index_tru (log2_lut_index_tru[8:0]) //|< w
  ,.log2_prdy          (log2_prdy)               //|< w
  ,.lut_uflow_reg      (lut_uflow_reg)           //|< w
  ,.sub_pvld           (sub_pvld)                //|< w
  ,.log2_lut_frac_reg  (log2_lut_frac_reg[31:0]) //|> w
  ,.log2_lut_index_reg (log2_lut_index_reg[8:0]) //|> w
  ,.log2_pvld          (log2_pvld)               //|> w
  ,.lut_uflow_reg2     (lut_uflow_reg2)          //|> w
  ,.sub_prdy           (sub_prdy)                //|> w
  );

assign  cfg_lut_offset_ext[8:0] = {{1{cfg_lut_offset[7]}}, cfg_lut_offset[7:0]};  

assign  lut_uflow_mid = $signed({1'b0,log2_lut_index_reg[8:0]}) < $signed(cfg_lut_offset_ext[8:0]);   //morework 

//10bit signed to 9bit unsigned,need saturation
assign  {mon_lutmid_sub_c,lut_index_sub_mid_tmp[9:0]} = $signed({1'b0,log2_lut_index_reg[8:0]}) - $signed(cfg_lut_offset_ext[8:0]);  // spyglass disable W164b

assign  lut_index_sub_mid[8:0] = (lut_uflow_reg2 | lut_uflow_mid) ? 0 : lut_index_sub_mid_tmp[9] ? 9'h1ff:  lut_index_sub_mid_tmp[8:0];

assign  lut_oflow_final = (lut_index_sub_mid >= LUT_DEPTH -1); 
assign  lut_uflow_final =  lut_uflow_reg2 | lut_uflow_mid; 

//index integar
always @(
  lut_oflow_final
  or lut_index_sub_mid
  ) begin
   if (lut_oflow_final) 
       lut_index_final[8:0] = LUT_DEPTH - 1;
   else 
       lut_index_final[8:0] = lut_index_sub_mid[8:0];
end

//index fraction
assign  lut_frac_final[34:0] = {{(35 - 32  ){1'b0}},log2_lut_frac_reg[31:0]} << (35  - log2_lut_index_reg[8:0]); 

NV_NVDLA_SDP_HLS_LUT_EXPN_pipe_p3 pipe_p3 (
   .nvdla_core_clk     (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)         //|< i
  ,.idx_out_prdy       (idx_out_prdy)            //|< i
  ,.log2_pvld          (log2_pvld)               //|< w
  ,.lut_frac_final     (lut_frac_final[34:0])    //|< w
  ,.lut_index_final    (lut_index_final[8:0])    //|< r
  ,.lut_oflow_final    (lut_oflow_final)         //|< w
  ,.lut_uflow_final    (lut_uflow_final)         //|< w
  ,.idx_out_pvld       (idx_out_pvld)            //|> o
  ,.log2_prdy          (log2_prdy)               //|> w
  ,.lut_frac_out       (lut_frac_out[34:0])      //|> o
  ,.lut_index_out      (lut_index_out[8:0])      //|> o
  ,.lut_oflow_out      (lut_oflow_out)           //|> o
  ,.lut_uflow_out      (lut_uflow_out)           //|> o
  );


endmodule
