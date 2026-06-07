module NV_NVDLA_SDP_HLS_Y_int_mul (
   cfg_mul_bypass   //|< i
  ,cfg_mul_op       //|< i
  ,cfg_mul_prelu    //|< i
  ,cfg_mul_src      //|< i
  ,cfg_mul_truncate //|< i
  ,chn_in_pvld      //|< i
  ,chn_mul_in       //|< i
  ,chn_mul_op       //|< i
  ,chn_mul_op_pvld  //|< i
  ,mul_out_prdy     //|< i
  ,nvdla_core_clk   //|< i
  ,nvdla_core_rstn  //|< i
  ,chn_in_prdy      //|> o
  ,chn_mul_op_prdy  //|> o
  ,mul_data_out     //|> o
  ,mul_out_pvld     //|> o
  );

input         cfg_mul_bypass;
input  [31:0] cfg_mul_op;
input         cfg_mul_prelu;
input         cfg_mul_src;
input   [9:0] cfg_mul_truncate;
input         chn_in_pvld;
input  [31:0] chn_mul_in;
input  [31:0] chn_mul_op;
input         chn_mul_op_pvld;
input         mul_out_prdy;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output        chn_in_prdy;
output        chn_mul_op_prdy;
output [31:0] mul_data_out;
output        mul_out_pvld;

reg    [31:0] mul_dout;
wire          chn_in_srdy;
wire   [31:0] mul_data_final;
wire   [31:0] mul_data_in;
wire   [31:0] mul_data_reg;
wire   [31:0] mul_data_sync;
wire          mul_final_prdy;
wire          mul_final_pvld;
wire   [31:0] mul_op_in;
wire   [31:0] mul_op_sync;
wire   [63:0] mul_prelu_dout;
wire   [63:0] mul_prelu_out;
wire          mul_prelu_prdy;
wire          mul_prelu_pvld;
wire          mul_sync_prdy;
wire          mul_sync_pvld;
wire   [31:0] mul_truncate_out;

    
NV_NVDLA_SDP_HLS_sync2data #(.DATA1_WIDTH(32 ),.DATA2_WIDTH(32 )) y_mul_sync2data (
   .chn1_en         (!cfg_mul_bypass & cfg_mul_src) //|< ?
  ,.chn2_en         (!cfg_mul_bypass)               //|< i
  ,.chn1_in_pvld    (chn_mul_op_pvld)               //|< i
  ,.chn1_in_prdy    (chn_mul_op_prdy)               //|> o
  ,.chn2_in_pvld    (chn_in_pvld)                   //|< i
  ,.chn2_in_prdy    (chn_in_srdy)                   //|> w
  ,.chn_out_pvld    (mul_sync_pvld)                 //|> w
  ,.chn_out_prdy    (mul_sync_prdy)                 //|< w
  ,.data1_in        (chn_mul_op[31:0])              //|< i
  ,.data2_in        (chn_mul_in[31:0])              //|< i
  ,.data1_out       (mul_op_sync[31:0])             //|> w
  ,.data2_out       (mul_data_sync[31:0])           //|> w
  );

assign  mul_data_in[31:0]   =  mul_data_sync[31:0];
assign  mul_op_in[31:0] = (cfg_mul_src == 0 ) ? cfg_mul_op[31:0] : mul_op_sync[31:0];

NV_NVDLA_SDP_HLS_prelu #(.IN_WIDTH(32 ),.OUT_WIDTH(32 + 32 ),.OP_WIDTH(32 )) y_mul_prelu (
   .cfg_prelu_en    (cfg_mul_prelu)                 //|< i
  ,.data_in         (mul_data_in[31:0])             //|< w
  ,.op_in           (mul_op_in[31:0])               //|< w
  ,.data_out        (mul_prelu_dout[63:0])          //|> w
  );

NV_NVDLA_SDP_HLS_Y_INT_MUL_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)                //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)               //|< i
  ,.mul_data_in     (mul_data_in[31:0])             //|< w
  ,.mul_prelu_dout  (mul_prelu_dout[63:0])          //|< w
  ,.mul_prelu_prdy  (mul_prelu_prdy)                //|< w
  ,.mul_sync_pvld   (mul_sync_pvld)                 //|< w
  ,.mul_data_reg    (mul_data_reg[31:0])            //|> w
  ,.mul_prelu_out   (mul_prelu_out[63:0])           //|> w
  ,.mul_prelu_pvld  (mul_prelu_pvld)                //|> w
  ,.mul_sync_prdy   (mul_sync_prdy)                 //|> w
  );

NV_NVDLA_HLS_shiftrightsu #(.IN_WIDTH(32 + 32 ),.OUT_WIDTH(32 ),.SHIFT_WIDTH(10 )) y_mul_shiftright_su (
   .data_in         (mul_prelu_out[63:0])           //|< w
  ,.shift_num       (cfg_mul_truncate[9:0])         //|< i
  ,.data_out        (mul_truncate_out[31:0])        //|> w
  );
//signed 
//unsigned 

always @(
  cfg_mul_prelu
  or mul_data_reg
  or mul_truncate_out
  ) begin
   if (cfg_mul_prelu & !mul_data_reg[32 -1]) 
      mul_dout[31:0] = mul_data_reg;
   else 
      mul_dout[31:0] = mul_truncate_out[31:0]; 
end

NV_NVDLA_SDP_HLS_Y_INT_MUL_pipe_p2 pipe_p2 (
   .nvdla_core_clk  (nvdla_core_clk)                //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)               //|< i
  ,.mul_dout        (mul_dout[31:0])                //|< r
  ,.mul_final_prdy  (mul_final_prdy)                //|< w
  ,.mul_prelu_pvld  (mul_prelu_pvld)                //|< w
  ,.mul_data_final  (mul_data_final[31:0])          //|> w
  ,.mul_final_pvld  (mul_final_pvld)                //|> w
  ,.mul_prelu_prdy  (mul_prelu_prdy)                //|> w
  );

assign  chn_in_prdy    = cfg_mul_bypass ? mul_out_prdy : chn_in_srdy;
assign  mul_final_prdy = cfg_mul_bypass ? 1'b1 : mul_out_prdy;
assign  mul_out_pvld   = cfg_mul_bypass ? chn_in_pvld : mul_final_pvld;
assign  mul_data_out[31:0] = cfg_mul_bypass ? chn_mul_in : mul_data_final[31:0];

endmodule
