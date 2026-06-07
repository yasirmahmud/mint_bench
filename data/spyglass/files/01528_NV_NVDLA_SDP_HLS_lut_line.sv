module NV_NVDLA_SDP_HLS_lut_line (
   cfg_lut_sel     //|< i
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

input   [7:0] cfg_lut_sel;
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
wire    [7:0] cfg_lut_sel_reg;
wire   [31:0] cfg_lut_start_reg;
wire   [31:0] idx_data_reg;
wire   [34:0] lut_frac_final;
wire   [34:0] lut_frac_shift;
wire    [8:0] lut_index_shift;
wire   [31:0] lut_index_sub;
wire   [31:0] lut_index_sub_reg;
wire   [31:0] lut_index_sub_tmp;
wire          lut_oflow;
wire          lut_uflow;
wire          lut_uflow_in;
wire          mon_index_sub_c;
wire          mux_prdy;
wire          mux_pvld;
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

    
NV_NVDLA_SDP_HLS_LUT_LINE_pipe_p1 pipe_p1 (
   .nvdla_core_clk    (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn   (nvdla_core_rstn)         //|< i
  ,.cfg_lut_sel       (cfg_lut_sel[7:0])        //|< i
  ,.cfg_lut_start     (cfg_lut_start[31:0])     //|< i
  ,.idx_data_in       (idx_data_in[31:0])       //|< i
  ,.idx_in_pvld       (idx_in_pvld)             //|< i
  ,.mux_prdy          (mux_prdy)                //|< w
  ,.cfg_lut_sel_reg   (cfg_lut_sel_reg[7:0])    //|> w
  ,.cfg_lut_start_reg (cfg_lut_start_reg[31:0]) //|> w
  ,.idx_data_reg      (idx_data_reg[31:0])      //|> w
  ,.idx_in_prdy       (idx_in_prdy)             //|> o
  ,.mux_pvld          (mux_pvld)                //|> w
  );

assign  lut_uflow_in = ($signed(idx_data_reg[31:0]) <= $signed(cfg_lut_start_reg[31:0])); 

assign  {mon_index_sub_c,lut_index_sub_tmp[31:0]} = $signed(idx_data_reg[31:0])- $signed(cfg_lut_start_reg[31:0]);

//unsigned int
assign  lut_index_sub[31:0] = lut_uflow_in ? 0 : lut_index_sub_tmp[31:0];

NV_NVDLA_SDP_HLS_LUT_LINE_pipe_p2 pipe_p2 (
   .nvdla_core_clk    (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn   (nvdla_core_rstn)         //|< i
  ,.lut_index_sub     (lut_index_sub[31:0])     //|< w
  ,.lut_uflow_in      (lut_uflow_in)            //|< w
  ,.mux_pvld          (mux_pvld)                //|< w
  ,.sub_prdy          (sub_prdy)                //|< w
  ,.lut_index_sub_reg (lut_index_sub_reg[31:0]) //|> w
  ,.lut_uflow         (lut_uflow)               //|> w
  ,.mux_prdy          (mux_prdy)                //|> w
  ,.sub_pvld          (sub_pvld)                //|> w
  );

//saturation and truncate, but no rounding
NV_NVDLA_HLS_shiftrightusz #(.IN_WIDTH(32 ),.OUT_WIDTH(9 ),.FRAC_WIDTH(35 ),.SHIFT_WIDTH(8 )) lut_index_shiftright_usz (
   .data_in           (lut_index_sub_reg[31:0]) //|< w
  ,.shift_num         (cfg_lut_sel_reg[7:0])    //|< w
  ,.data_out          (lut_index_shift[8:0])    //|> w
  ,.frac_out          (lut_frac_shift[34:0])    //|> w
  );

assign  lut_oflow = (lut_index_shift[8:0] >= LUT_DEPTH -1); 

//index integar
always @(
  lut_oflow
  or lut_index_shift
  ) begin
   if (lut_oflow) 
       lut_index_final[8:0] = LUT_DEPTH - 1;
   else 
       lut_index_final[8:0] = lut_index_shift[8:0];
end

assign  lut_frac_final[34:0] = lut_frac_shift[34:0]; 

NV_NVDLA_SDP_HLS_LUT_LINE_pipe_p3 pipe_p3 (
   .nvdla_core_clk    (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn   (nvdla_core_rstn)         //|< i
  ,.idx_out_prdy      (idx_out_prdy)            //|< i
  ,.lut_frac_final    (lut_frac_final[34:0])    //|< w
  ,.lut_index_final   (lut_index_final[8:0])    //|< r
  ,.lut_oflow         (lut_oflow)               //|< w
  ,.lut_uflow         (lut_uflow)               //|< w
  ,.sub_pvld          (sub_pvld)                //|< w
  ,.idx_out_pvld      (idx_out_pvld)            //|> o
  ,.lut_frac_out      (lut_frac_out[34:0])      //|> o
  ,.lut_index_out     (lut_index_out[8:0])      //|> o
  ,.lut_oflow_out     (lut_oflow_out)           //|> o
  ,.lut_uflow_out     (lut_uflow_out)           //|> o
  ,.sub_prdy          (sub_prdy)                //|> w
  );

endmodule
