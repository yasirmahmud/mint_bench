module NV_NVDLA_SDP_HLS_Y_int_cvt (
   cfg_cvt_bypass   //|< i
  ,cfg_cvt_offset   //|< i
  ,cfg_cvt_scale    //|< i
  ,cfg_cvt_truncate //|< i
  ,cvt_data_in      //|< i
  ,cvt_in_pvld      //|< i
  ,cvt_out_prdy     //|< i
  ,nvdla_core_clk   //|< i
  ,nvdla_core_rstn  //|< i
  ,cvt_data_out     //|> o
  ,cvt_in_prdy      //|> o
  ,cvt_out_pvld     //|> o
  );

input         cfg_cvt_bypass;
input  [31:0] cfg_cvt_offset;
input  [15:0] cfg_cvt_scale;
input   [5:0] cfg_cvt_truncate;
input  [15:0] cvt_data_in;
input         cvt_in_pvld;
input         cvt_out_prdy;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output [31:0] cvt_data_out;
output        cvt_in_prdy;
output        cvt_out_pvld;

wire   [32:0] cfg_offset_ext;
wire   [15:0] cfg_scale;
wire    [5:0] cfg_truncate;
wire   [32:0] cvt_data_ext;
wire   [31:0] cvt_dout;
wire          final_out_prdy;
wire          final_out_pvld;
wire          mon_sub_c;
wire   [48:0] mul_data_out;
wire   [48:0] mul_dout;
wire          mul_out_prdy;
wire          mul_out_pvld;
wire   [32:0] sub_data_out;
wire   [32:0] sub_dout;
wire          sub_in_prdy;
wire          sub_in_pvld;
wire          sub_out_prdy;
wire          sub_out_pvld;
wire   [31:0] tru_dout;


    
//sub
assign   cfg_scale[15:0]  = cfg_cvt_bypass ? {16 {1'b0}} : cfg_cvt_scale[15:0];
assign   cfg_truncate[5:0]  = cfg_cvt_bypass ? {6 {1'b0}}    : cfg_cvt_truncate[5:0];

assign   cfg_offset_ext[32:0] = cfg_cvt_bypass ? {33 {1'b0}} : ({{1{cfg_cvt_offset[31]}}, cfg_cvt_offset[31:0]});
assign   cvt_data_ext[32:0]   = cfg_cvt_bypass ? {33 {1'b0}} : ({{17{cvt_data_in[15]}}, cvt_data_in[15:0]});

assign   {mon_sub_c,sub_dout[32:0]} = $signed(cvt_data_ext[32:0]) -$signed(cfg_offset_ext[32:0]);


NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)     //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)    //|< i
  ,.sub_dout        (sub_dout[32:0])     //|< w
  ,.sub_in_pvld     (sub_in_pvld)        //|< w
  ,.sub_out_prdy    (sub_out_prdy)       //|< w
  ,.sub_data_out    (sub_data_out[32:0]) //|> w
  ,.sub_in_prdy     (sub_in_prdy)        //|> w
  ,.sub_out_pvld    (sub_out_pvld)       //|> w
  );

//mul 
assign   mul_dout[48:0] = $signed(sub_data_out[32:0]) * $signed(cfg_scale[15:0]);


NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p2 pipe_p2 (
   .nvdla_core_clk  (nvdla_core_clk)     //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)    //|< i
  ,.mul_dout        (mul_dout[48:0])     //|< w
  ,.mul_out_prdy    (mul_out_prdy)       //|< w
  ,.sub_out_pvld    (sub_out_pvld)       //|< w
  ,.mul_data_out    (mul_data_out[48:0]) //|> w
  ,.mul_out_pvld    (mul_out_pvld)       //|> w
  ,.sub_out_prdy    (sub_out_prdy)       //|> w
  );

//truncate
NV_NVDLA_HLS_shiftrightsu #(.IN_WIDTH(33 + 16 ),.OUT_WIDTH(32 ),.SHIFT_WIDTH(6 )) y_cvt_shiftright_su (
   .data_in         (mul_data_out[48:0]) //|< w
  ,.shift_num       (cfg_truncate[5:0])  //|< w
  ,.data_out        (tru_dout[31:0])     //|> w
  );
//signed 
//unsigned


assign  sub_in_pvld    = cfg_cvt_bypass ? 1'b0 : cvt_in_pvld;
assign  cvt_in_prdy    = cfg_cvt_bypass ? final_out_prdy : sub_in_prdy; 
assign  mul_out_prdy   = cfg_cvt_bypass ? 1'b1 : final_out_prdy;
assign  final_out_pvld = cfg_cvt_bypass ? cvt_in_pvld : mul_out_pvld;
assign  cvt_dout[31:0] = cfg_cvt_bypass ? {{16{cvt_data_in[15]}}, cvt_data_in[15:0]} : tru_dout[31:0];

NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p3 pipe_p3 (
   .nvdla_core_clk  (nvdla_core_clk)     //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)    //|< i
  ,.cvt_dout        (cvt_dout[31:0])     //|< w
  ,.cvt_out_prdy    (cvt_out_prdy)       //|< i
  ,.final_out_pvld  (final_out_pvld)     //|< w
  ,.cvt_data_out    (cvt_data_out[31:0]) //|> o
  ,.cvt_out_pvld    (cvt_out_pvld)       //|> o
  ,.final_out_prdy  (final_out_prdy)     //|> w
  );

endmodule
