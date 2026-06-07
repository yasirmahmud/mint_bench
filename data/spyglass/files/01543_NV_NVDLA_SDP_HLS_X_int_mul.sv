module NV_NVDLA_SDP_HLS_X_int_mul (
   alu_data_out    //|< i
  ,alu_out_pvld    //|< i
  ,cfg_mul_bypass  //|< i
  ,cfg_mul_op      //|< i
  ,cfg_mul_prelu   //|< i
  ,cfg_mul_src     //|< i
  ,chn_mul_op      //|< i
  ,mul_op_pvld     //|< i
  ,mul_out_prdy    //|< i
  ,nvdla_core_clk  //|< i
  ,nvdla_core_rstn //|< i
  ,alu_out_prdy    //|> o
  ,bypass_trt_out  //|> o
  ,mul_data_out    //|> o
  ,mul_op_prdy     //|> o
  ,mul_out_pvld    //|> o
  );


input  [32:0] alu_data_out;
input         alu_out_pvld;
input         cfg_mul_bypass;
input  [15:0] cfg_mul_op;
input         cfg_mul_prelu;
input         cfg_mul_src;
input  [15:0] chn_mul_op;
input         mul_op_pvld;
input         mul_out_prdy;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output        alu_out_prdy;
output        bypass_trt_out;
output [48:0] mul_data_out;
output        mul_op_prdy;
output        mul_out_pvld;
wire          alu_out_srdy;
wire          bypass_trt;
wire          bypass_trt_reg;
wire   [48:0] mul_data_final;
wire   [32:0] mul_data_in;
wire   [32:0] mul_data_sync;
wire          mul_final_prdy;
wire          mul_final_pvld;
wire   [15:0] mul_op_in;
wire   [15:0] mul_op_sync;
wire   [48:0] mul_prelu_out;
wire          mul_sync_prdy;
wire          mul_sync_pvld;

    
NV_NVDLA_SDP_HLS_sync2data #(.DATA1_WIDTH(16 ),.DATA2_WIDTH(33 )) x_mul_sync2data (
   .chn1_en         (!cfg_mul_bypass & cfg_mul_src) //|< ?
  ,.chn2_en         (!cfg_mul_bypass)               //|< i
  ,.chn1_in_pvld    (mul_op_pvld)                   //|< i
  ,.chn1_in_prdy    (mul_op_prdy)                   //|> o
  ,.chn2_in_pvld    (alu_out_pvld)                  //|< i
  ,.chn2_in_prdy    (alu_out_srdy)                  //|> w
  ,.chn_out_pvld    (mul_sync_pvld)                 //|> w
  ,.chn_out_prdy    (mul_sync_prdy)                 //|< w
  ,.data1_in        (chn_mul_op[15:0])              //|< i
  ,.data2_in        (alu_data_out[32:0])            //|< i
  ,.data1_out       (mul_op_sync[15:0])             //|> w
  ,.data2_out       (mul_data_sync[32:0])           //|> w
  );

assign  bypass_trt = cfg_mul_prelu & !mul_data_sync[33 -1]; 

assign  mul_op_in[15:0] = (cfg_mul_src == 0 ) ? cfg_mul_op[15:0] : mul_op_sync[15:0];
assign  mul_data_in[32:0] = mul_data_sync[32:0];

NV_NVDLA_SDP_HLS_prelu #(.IN_WIDTH(33 ),.OUT_WIDTH(49 ),.OP_WIDTH(16 )) x_mul_prelu (
   .cfg_prelu_en    (cfg_mul_prelu)                 //|< i
  ,.data_in         (mul_data_in[32:0])             //|< w
  ,.op_in           (mul_op_in[15:0])               //|< w
  ,.data_out        (mul_prelu_out[48:0])           //|> w
  );

NV_NVDLA_SDP_HLS_X_INT_MUL_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)                //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)               //|< i
  ,.bypass_trt      (bypass_trt)                    //|< w
  ,.mul_final_prdy  (mul_final_prdy)                //|< w
  ,.mul_prelu_out   (mul_prelu_out[48:0])           //|< w
  ,.mul_sync_pvld   (mul_sync_pvld)                 //|< w
  ,.bypass_trt_reg  (bypass_trt_reg)                //|> w
  ,.mul_data_final  (mul_data_final[48:0])          //|> w
  ,.mul_final_pvld  (mul_final_pvld)                //|> w
  ,.mul_sync_prdy   (mul_sync_prdy)                 //|> w
  );

assign  alu_out_prdy   = cfg_mul_bypass ? mul_out_prdy : alu_out_srdy;
assign  mul_final_prdy = cfg_mul_bypass ? 1'b1 : mul_out_prdy;
assign  mul_out_pvld   = cfg_mul_bypass ? alu_out_pvld : mul_final_pvld;
assign  bypass_trt_out = cfg_mul_bypass ? 1'b0 : bypass_trt_reg;
assign  mul_data_out[48:0] = cfg_mul_bypass ? {{16{alu_data_out[32]}}, alu_data_out[32:0]} : mul_data_final[48:0];

endmodule
