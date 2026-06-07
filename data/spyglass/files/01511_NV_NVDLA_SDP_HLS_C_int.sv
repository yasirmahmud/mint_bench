module NV_NVDLA_SDP_HLS_C_int (
   cfg_mode_eql      //|< i
  ,cfg_offset        //|< i
  ,cfg_out_precision //|< i
  ,cfg_scale         //|< i
  ,cfg_truncate      //|< i
  ,cvt_data_in       //|< i
  ,cvt_in_pvld       //|< i
  ,cvt_out_prdy      //|< i
  ,nvdla_core_clk    //|< i
  ,nvdla_core_rstn   //|< i
  ,cvt_data_out      //|> o
  ,cvt_in_prdy       //|> o
  ,cvt_out_pvld      //|> o
  ,cvt_sat_out       //|> o
  );

input         cfg_mode_eql;
input  [31:0] cfg_offset;
input   [1:0] cfg_out_precision;
input  [15:0] cfg_scale;
input   [5:0] cfg_truncate;
input  [31:0] cvt_data_in;
input         cvt_in_pvld;
input         cvt_out_prdy;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output [15:0] cvt_data_out;
output        cvt_in_prdy;
output        cvt_out_pvld;
output        cvt_sat_out;
/*
input                        nvdla_core_clk;
input                        nvdla_core_rstn;
input   [1:0]                cfg_out_precision;
input   [C_ALU_OP_WIDTH-1:0] cfg_offset;
input   [C_MUL_OP_WIDTH-1:0] cfg_scale;
input   [C_TRU_WIDTH-1:0]    cfg_truncate;
input   [C_IN_WIDTH-1:0]     cvt_data_in;
output  [C_OUT_WIDTH-1:0]    cvt_data_out;
input                        cvt_in_pvld;
output                       cvt_in_prdy;
input                        cvt_out_prdy;
output                       cvt_out_pvld;
*/

wire   [31:0] cfg_offset_mux;
wire   [15:0] cfg_scale_mux;
wire   [31:0] cvt_data_mux;
wire   [15:0] cvt_dout;
wire          cvt_sat;
wire   [15:0] dout_int16_sat;
wire    [7:0] dout_int8_sat;
wire          final_out_prdy;
wire          final_out_pvld;
wire   [48:0] mul_data_out;
wire   [48:0] mul_dout;
wire          mul_out_prdy;
wire          mul_out_pvld;
wire          sat_dout;
wire          sat_out;
wire   [32:0] sub_data_out;
wire   [32:0] sub_dout;
wire          sub_in_prdy;
wire          sub_in_pvld;
wire          sub_out_prdy;
wire          sub_out_pvld;
wire   [16:0] tru_dout;
wire   [16:0] tru_out;
wire          tru_out_prdy;
wire          tru_out_pvld;


// synoff nets

// monitor nets

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    
assign   cvt_data_mux[31:0] = cfg_mode_eql ? {32 {1'b0}} : cvt_data_in[31:0];
assign   cfg_offset_mux[31:0] = cfg_mode_eql ? {32 {1'b0}} : cfg_offset[31:0];
assign   cfg_scale_mux[15:0]  = cfg_mode_eql ? {16 {1'b0}} : cfg_scale[15:0]; 

//sub
assign   sub_dout[32:0] = $signed(cvt_data_mux[31:0]) -$signed(cfg_offset_mux[31:0]);

//assign   sub_mux[::range(C_ALU_OUT_WIDTH)] = cfg_mode_eql ? {{(C_ALU_OUT_WIDTH-C_IN_WIDTH){1'b0}},cvt_data_in[::range(C_IN_WIDTH)]} : sub_dout[::range(C_ALU_OUT_WIDTH)];

NV_NVDLA_SDP_HLS_C_INT_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)       //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)      //|< i
  ,.sub_dout        (sub_dout[32:0])       //|< w
  ,.sub_in_pvld     (sub_in_pvld)          //|< w
  ,.sub_out_prdy    (sub_out_prdy)         //|< w
  ,.sub_data_out    (sub_data_out[32:0])   //|> w
  ,.sub_in_prdy     (sub_in_prdy)          //|> w
  ,.sub_out_pvld    (sub_out_pvld)         //|> w
  );

//mul 
assign   mul_dout[48:0] = $signed(sub_data_out[32:0]) * $signed(cfg_scale_mux[15:0]);

//assign   mul_mux[::range(C_MUL_OUT_WIDTH)] = cfg_mode_eql ? {{(C_MUL_OUT_WIDTH-C_IN_WIDTH){1'b0}},sub_data_out[::range(C_IN_WIDTH)]} : mul_dout[::range(C_MUL_OUT_WIDTH)];

NV_NVDLA_SDP_HLS_C_INT_pipe_p2 pipe_p2 (
   .nvdla_core_clk  (nvdla_core_clk)       //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)      //|< i
  ,.mul_dout        (mul_dout[48:0])       //|< w
  ,.mul_out_prdy    (mul_out_prdy)         //|< w
  ,.sub_out_pvld    (sub_out_pvld)         //|< w
  ,.mul_data_out    (mul_data_out[48:0])   //|> w
  ,.mul_out_pvld    (mul_out_pvld)         //|> w
  ,.sub_out_prdy    (sub_out_prdy)         //|> w
  );

//truncate
NV_NVDLA_HLS_shiftrightsatsu #(.IN_WIDTH(49 ),.OUT_WIDTH(17 ),.SHIFT_WIDTH(6 )) c_shiftrightsat_su (
   .data_in         (mul_data_out[48:0])   //|< w
  ,.shift_num       (cfg_truncate[5:0])    //|< i
  ,.data_out        (tru_dout[16:0])       //|> w
  ,.sat_out         (sat_dout)             //|> w
  );
//signed 
//unsigned

NV_NVDLA_SDP_HLS_C_INT_pipe_p3 pipe_p3 (
   .nvdla_core_clk  (nvdla_core_clk)       //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)      //|< i
  ,.mul_out_pvld    (mul_out_pvld)         //|< w
  ,.sat_dout        (sat_dout)             //|< w
  ,.tru_dout        (tru_dout[16:0])       //|< w
  ,.tru_out_prdy    (tru_out_prdy)         //|< w
  ,.mul_out_prdy    (mul_out_prdy)         //|> w
  ,.sat_out         (sat_out)              //|> w
  ,.tru_out         (tru_out[16:0])        //|> w
  ,.tru_out_pvld    (tru_out_pvld)         //|> w
  );

NV_NVDLA_HLS_saturate #(.IN_WIDTH(17 ),.OUT_WIDTH(16 )) c_saturate_int16 (
   .data_in         (tru_out[16:0])        //|< w
  ,.data_out        (dout_int16_sat[15:0]) //|> w
  );

NV_NVDLA_HLS_saturate #(.IN_WIDTH(17 ),.OUT_WIDTH(8 )) c_saturate_int8 (
   .data_in         (tru_out[16:0])        //|< w
  ,.data_out        (dout_int8_sat[7:0])   //|> w
  );

assign   sub_in_pvld    = cfg_mode_eql ? 1'b0 : cvt_in_pvld;
assign   cvt_in_prdy    = cfg_mode_eql ? final_out_prdy : sub_in_prdy;
assign   tru_out_prdy   = cfg_mode_eql ? 1'b1 : final_out_prdy;
assign   final_out_pvld = cfg_mode_eql ? cvt_in_pvld : tru_out_pvld;

assign   cvt_dout = cfg_mode_eql ? cvt_data_in[15:0] : 
                   (cfg_out_precision[1:0] == 1 ) ? dout_int16_sat[15:0] : {{(16 - 8 ){dout_int8_sat[8 -1]}},dout_int8_sat[7:0]}; 

assign   cvt_sat  = cfg_mode_eql ? 1'b0 : sat_out;

NV_NVDLA_SDP_HLS_C_INT_pipe_p4 pipe_p4 (
   .nvdla_core_clk  (nvdla_core_clk)       //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)      //|< i
  ,.cvt_dout        (cvt_dout[15:0])       //|< w
  ,.cvt_out_prdy    (cvt_out_prdy)         //|< i
  ,.cvt_sat         (cvt_sat)              //|< w
  ,.final_out_pvld  (final_out_pvld)       //|< w
  ,.cvt_data_out    (cvt_data_out[15:0])   //|> o
  ,.cvt_out_pvld    (cvt_out_pvld)         //|> o
  ,.cvt_sat_out     (cvt_sat_out)          //|> o
  ,.final_out_prdy  (final_out_prdy)       //|> w
  );

endmodule
