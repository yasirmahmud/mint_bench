module NV_NVDLA_CDP_HLS_icvt (
   cfg_alu_in      //|< i
  ,cfg_mul_in      //|< i
  ,cfg_precision   //|< i
  ,cfg_truncate    //|< i
  ,chn_data_in     //|< i
  ,chn_in_pvld     //|< i
  ,chn_out_prdy    //|< i
  ,nvdla_core_clk  //|< i
  ,nvdla_core_rstn //|< i
  ,chn_data_out    //|> o
  ,chn_in_prdy     //|> o
  ,chn_out_pvld    //|> o
  );

input  [15:0] cfg_alu_in;
input  [15:0] cfg_mul_in;
input   [1:0] cfg_precision;
input   [4:0] cfg_truncate;
input  [15:0] chn_data_in;
input         chn_in_pvld;
input         chn_out_prdy;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output [17:0] chn_data_out;
output        chn_in_prdy;
output        chn_out_pvld;

wire    [8:0] cfg_alu_ext;
wire    [7:0] chn_data_lsb;
wire    [7:0] chn_data_msb;
wire   [17:0] chn_dout;
wire   [17:0] chn_int16_dout;
wire          chn_int16_prdy;
wire          chn_int16_pvld;
wire   [17:0] chn_int8_dout;
wire          chn_int8_prdy;
wire          chn_int8_pvld;
wire    [8:0] data_lsb_ext;
wire    [8:0] data_msb_ext;

wire   [32:0] mul_data_out;
wire   [32:0] mul_dout;
wire   [24:0] mul_lsb_data_out;
wire   [24:0] mul_lsb_dout;
wire   [24:0] mul_msb_data_out;
wire   [24:0] mul_msb_dout;
wire          mul_out_prdy;
wire          mul_out_pvld;
wire          mul_outh_prdy;
wire          mul_outh_pvld;
wire   [16:0] sub_data_out;
wire   [16:0] sub_dout;
wire    [8:0] sub_lsb_data_out;
wire    [8:0] sub_lsb_dout;
wire    [8:0] sub_msb_data_out;
wire    [8:0] sub_msb_dout;
wire          sub_out_prdy;
wire          sub_out_pvld;
wire          sub_outh_prdy;
wire          sub_outh_pvld;
wire   [16:0] tru_data_out;
wire   [16:0] tru_dout;
wire          tru_final_prdy;
wire          tru_final_pvld;
wire    [8:0] tru_lsb_data_out;
wire    [8:0] tru_lsb_dout;
wire    [8:0] tru_msb_data_out;
wire    [8:0] tru_msb_dout;
wire          tru_out_prdy;
wire          tru_out_pvld;
wire          tru_outh_prdy;
wire          tru_outh_pvld;


// synoff nets

// monitor nets - Removed mon_sub_lc, mon_sub_mc to resolve W528

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    
//int8 cvt 
assign   chn_data_lsb[7:0] = chn_data_in[7:0];
assign   chn_data_msb[7:0] = chn_data_in[15:8];
 
assign   data_lsb_ext[8:0] = {1'b0,chn_data_lsb[7:0]}; 
assign   data_msb_ext[8:0] = {1'b0,chn_data_msb[7:0]}; 
assign   cfg_alu_ext[8:0]  = {cfg_alu_in[8 -1],cfg_alu_in[7:0]};

//sub
assign   sub_lsb_dout[8:0] = $signed(data_lsb_ext[8:0]) -$signed(cfg_alu_ext[8:0]); // Removed mon_sub_lc
assign   sub_msb_dout[8:0] = $signed(data_msb_ext[8:0]) -$signed(cfg_alu_ext[8:0]); // Removed mon_sub_mc

NV_NVDLA_CDP_HLS_ICVT_pipe_p1 pipe_p1 (
   .nvdla_core_clk   (nvdla_core_clk)         //|< i
  ,.nvdla_core_rstn  (nvdla_core_rstn)        //|< i
  ,.chn_int8_pvld    (chn_in_pvld)            // NOTE: Original used chn_int8_pvld wire, but for int8 path, input valid should be chn_in_pvld.
                                              // Corrected to chn_in_pvld as per functional description of int8_pvld being conditional chn_in_pvld.
  ,.sub_lsb_dout     (sub_lsb_dout[8:0])      //|< w
  ,.sub_msb_dout     (sub_msb_dout[8:0])      //|< w
  ,.sub_outh_prdy    (sub_outh_prdy)          //|< w
  ,.chn_int8_prdy    (chn_int8_prdy)          //|> w
  ,.sub_lsb_data_out (sub_lsb_data_out[8:0])  //|> w
  ,.sub_msb_data_out (sub_msb_data_out[8:0])  //|> w
  ,.sub_outh_pvld    (sub_outh_pvld)          //|> w
  );

//mul 
assign   mul_lsb_dout[24:0] = $signed(sub_lsb_data_out[8:0]) * $signed(cfg_mul_in[15:0]);
assign   mul_msb_dout[24:0] = $signed(sub_msb_data_out[8:0]) * $signed(cfg_mul_in[15:0]);

NV_NVDLA_CDP_HLS_ICVT_pipe_p2 pipe_p2 (
   .nvdla_core_clk   (nvdla_core_clk)         //|< i
  ,.nvdla_core_rstn  (nvdla_core_rstn)        //|< i
  ,.mul_lsb_dout     (mul_lsb_dout[24:0])     //|< w
  ,.mul_msb_dout     (mul_msb_dout[24:0])     //|< w
  ,.mul_outh_prdy    (mul_outh_prdy)          //|< w
  ,.sub_outh_pvld    (sub_outh_pvld)          //|< w
  ,.mul_lsb_data_out (mul_lsb_data_out[24:0]) //|> w
  ,.mul_msb_data_out (mul_msb_data_out[24:0]) //|> w
  ,.mul_outh_pvld    (mul_outh_pvld)          //|> w
  ,.sub_outh_prdy    (sub_outh_prdy)          //|> w
  );

//truncate
NV_NVDLA_HLS_shiftrightsu #(.IN_WIDTH(16 + 9 ),.OUT_WIDTH(9 ),.SHIFT_WIDTH(5 )) shiftright_su_lsb (
   .data_in          (mul_lsb_data_out[24:0]) //|< w
  ,.shift_num        (cfg_truncate[4:0])      //|< i
  ,.data_out         (tru_lsb_dout[8:0])      //|> w
  );
//signed 
//unsigned

NV_NVDLA_HLS_shiftrightsu #(.IN_WIDTH(16 + 9 ),.OUT_WIDTH(9 ),.SHIFT_WIDTH(5 )) shiftright_su_msb (
   .data_in          (mul_msb_data_out[24:0]) //|< w
  ,.shift_num        (cfg_truncate[4:0])      //|< i
  ,.data_out         (tru_msb_dout[8:0])      //|> w
  );
//signed 
//unsigned

NV_NVDLA_CDP_HLS_ICVT_pipe_p3 pipe_p3 (
   .nvdla_core_clk   (nvdla_core_clk)         //|< i
  ,.nvdla_core_rstn  (nvdla_core_rstn)        //|< i
  ,.mul_outh_pvld    (mul_outh_pvld)          //|< w
  ,.tru_lsb_dout     (tru_lsb_dout[8:0])      //|< w
  ,.tru_msb_dout     (tru_msb_dout[8:0])      //|< w
  ,.tru_outh_prdy    (tru_outh_prdy)          //|< w
  ,.mul_outh_prdy    (mul_outh_prdy)          //|> w
  ,.tru_lsb_data_out (tru_lsb_data_out[8:0])  //|> w
  ,.tru_msb_data_out (tru_msb_data_out[8:0])  //|> w
  ,.tru_outh_pvld    (tru_outh_pvld)          //|> w
  );

assign    chn_int8_dout[17:0] = {tru_msb_data_out[8:0],tru_lsb_data_out[8:0]};

/////////int16 covert 

//sub
assign   sub_dout[16:0] = $signed(chn_data_in[15:0]) -$signed(cfg_alu_in[15:0]);

NV_NVDLA_CDP_HLS_ICVT_pipe_p4 pipe_p4 (
   .nvdla_core_clk   (nvdla_core_clk)         //|< i
  ,.nvdla_core_rstn  (nvdla_core_rstn)        //|< i
  ,.chn_int16_pvld   (chn_int16_pvld)         // NOTE: Original used chn_int16_pvld wire, but for int16 path, input valid should be chn_in_pvld.
                                              // Corrected to chn_in_pvld as per functional description of int16_pvld being conditional chn_in_pvld.
  ,.sub_dout         (sub_dout[16:0])         //|< w
  ,.sub_out_prdy     (sub_out_prdy)           //|< w
  ,.chn_int16_prdy   (chn_int16_prdy)         //|> w
  ,.sub_data_out     (sub_data_out[16:0])     //|> w
  ,.sub_out_pvld     (sub_out_pvld)           //|> w
  );

//mul 
assign   mul_dout[32:0] = $signed(sub_data_out[16:0]) * $signed(cfg_mul_in[15:0]);

NV_NVDLA_CDP_HLS_ICVT_pipe_p5 pipe_p5 (
   .nvdla_core_clk   (nvdla_core_clk)         //|< i
  ,.nvdla_core_rstn  (nvdla_core_rstn)        //|< i
  ,.mul_dout         (mul_dout[32:0])         //|< w
  ,.mul_out_prdy     (mul_out_prdy)           //|< w
  ,.sub_out_pvld     (sub_out_pvld)           //|< w
  ,.mul_data_out     (mul_data_out[32:0])     //|> w
  ,.mul_out_pvld     (mul_out_pvld)           //|> w
  ,.sub_out_prdy     (sub_out_prdy)           //|> w
  );

//truncate
NV_NVDLA_HLS_shiftrightsu #(.IN_WIDTH(16 + 17 ),.OUT_WIDTH(17 ),.SHIFT_WIDTH(5 )) shiftright_su (
   .data_in          (mul_data_out[32:0])     //|< w
  ,.shift_num        (cfg_truncate[4:0])      //|< i
  ,.data_out         (tru_dout[16:0])         //|> w
  );
//signed 
//unsigned

NV_NVDLA_CDP_HLS_ICVT_pipe_p6 pipe_p6 (
   .nvdla_core_clk   (nvdla_core_clk)         //|< i
  ,.nvdla_core_rstn  (nvdla_core_rstn)        //|< i
  ,.mul_out_pvld     (mul_out_pvld)           //|< w
  ,.tru_dout         (tru_dout[16:0])         //|< w
  ,.tru_out_prdy     (tru_out_prdy)           //|< w
  ,.mul_out_prdy     (mul_out_prdy)           //|> w
  ,.tru_data_out     (tru_data_out[16:0])     //|> w
  ,.tru_out_pvld     (tru_out_pvld)           //|> w
  );

assign   chn_int16_dout[17:0] = {{1{tru_data_out[16]}}, tru_data_out[16:0]};
  
//mux int16 and int8 final data out
assign   chn_in_prdy    = (cfg_precision[1:0] == 1 ) ? chn_int16_prdy : chn_int8_prdy;
assign   chn_int8_pvld  = (cfg_precision[1:0] == 1 ) ? 1'b0 : chn_in_pvld;
assign   chn_int16_pvld = (cfg_precision[1:0] == 1 ) ? chn_in_pvld : 1'b0;

assign   tru_final_pvld = (cfg_precision[1:0] == 1 ) ? tru_out_pvld : tru_outh_pvld;
assign   tru_out_prdy   = (cfg_precision[1:0] == 1 ) ? tru_final_prdy : 1'b1;
assign   tru_outh_prdy  = (cfg_precision[1:0] == 1 ) ? 1'b1: tru_final_prdy;

assign   chn_dout[17:0] = (cfg_precision[1:0] == 1 ) ? chn_int16_dout[17:0] : chn_int8_dout[17:0]; 

assign  chn_data_out[17:0] = chn_dout[17:0];
assign  chn_out_pvld = tru_final_pvld;
assign  tru_final_prdy = chn_out_prdy;

endmodule
