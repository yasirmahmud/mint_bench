module NV_NVDLA_SDP_HLS_Y_int_inp (
   inp_bias_in     //|< i
  ,inp_flow_in     //|< i
  ,inp_frac_in     //|< i
  ,inp_in_pvld     //|< i
  ,inp_offset_in   //|< i
  ,inp_out_prdy    //|< i
  ,inp_scale_in    //|< i
  ,inp_shift_in    //|< i
  ,inp_x_in        //|< i
  ,inp_y0_in       //|< i
  ,inp_y1_in       //|< i
  ,nvdla_core_clk  //|< i
  ,nvdla_core_rstn //|< i
  ,inp_data_out    //|> o
  ,inp_in_prdy     //|> o
  ,inp_out_pvld    //|> o
  );

input  [31:0] inp_bias_in;
input         inp_flow_in;
input  [34:0] inp_frac_in;
input         inp_in_pvld;
input  [31:0] inp_offset_in;
input         inp_out_prdy;
input  [15:0] inp_scale_in;
input   [4:0] inp_shift_in;
input  [31:0] inp_x_in;
input  [15:0] inp_y0_in;
input  [15:0] inp_y1_in;
output [31:0] inp_data_out;
output        inp_in_prdy;
output        inp_out_pvld;

input nvdla_core_clk;
input nvdla_core_rstn;

wire          flow_in_pipe1;
wire          flow_in_pipe2;
wire          flow_in_pipe3;
wire   [70:0] flow_pd;
wire   [70:0] flow_pd2;
wire   [70:0] flow_pd2_reg;
wire   [70:0] flow_pd_reg;
wire          inp_flow_pvld;
wire          inp_flow_prdy;
wire          flow_pipe1_prdy;
wire          flow_pipe1_pvld;
wire          flow_pipe2_prdy;
wire          flow_pipe2_pvld;
wire          flow_pipe3_pvld;
wire          flow_pipe3_prdy;
wire   [34:0] frac_in;
wire   [35:0] frac_remain;
wire   [32:0] inp_bias_mux;
wire   [31:0] inp_flow_dout;
wire          inp_fout_pvld;
wire          inp_fout_prdy;
wire          inp_in_fvld;
wire          inp_in_frdy;
wire          inp_in_mvld;
wire          inp_in_prdy0;
wire          inp_in_prdy1;
wire          inp_mout_pvld;
wire          inp_mout_prdy;
wire   [49:0] inp_mul_scale;
wire   [49:0] inp_mul_scale_reg;
wire   [31:0] inp_mul_tru;
wire   [31:0] inp_nrm_dout;
wire   [33:0] inp_ob_in;
wire   [32:0] inp_offset_mux;
wire   [15:0] inp_scale_reg;
wire    [4:0] inp_shift_reg;
wire    [4:0] inp_shift_reg2;
wire   [33:0] inp_x_ext;
wire   [33:0] inp_xsub;
wire   [33:0] inp_xsub_reg;
wire   [15:0] inp_y0_mux;
wire   [15:0] inp_y0_reg;
wire   [15:0] inp_y0_reg2;
wire   [32:0] inp_y0_sum;
wire   [32:0] inp_y0_sum_reg;
wire   [52:0] intp_sum;
wire   [52:0] intp_sum_reg;
wire   [31:0] intp_sum_tru;
// Removed unused wire mon_intp_sum_c
// Removed unused wire mon_xsub_c
wire   [52:0] mul0;
wire          mul0_prdy;
wire          mul0_pvld;
wire   [52:0] mul0_reg;
wire   [52:0] mul1;
wire          mul1_prdy;
wire          mul1_pvld;
wire   [52:0] mul1_reg;
wire          mul_scale_prdy;
wire          mul_scale_pvld;
wire          sum_in_prdy;
wire          sum_in_pvld;
wire          sum_out_prdy;
wire          sum_out_pvld;
wire          xsub_prdy;
wire          xsub_pvld;

    
//overflow and unflow  interpolation
assign  inp_x_ext[33:0] = inp_flow_in ? {{2{inp_x_in[31]}}, inp_x_in[31:0]} : {34 {1'b0}};
assign  inp_offset_mux[32:0] = inp_flow_in ? {inp_offset_in[31],inp_offset_in[31:0]} : {33{1'b0}};  
assign  inp_bias_mux[32:0]   = inp_flow_in ? {1'b0,inp_bias_in[31:0]} : {33{1'b0}};  
assign  inp_y0_mux[15:0]  = inp_flow_in ? inp_y0_in[15:0] : {16 {1'b0}};

assign  inp_ob_in[33:0] = $signed(inp_bias_mux[32:0]) + $signed({inp_offset_mux[32:0]}); 

assign  inp_xsub[33:0] = $signed(inp_x_ext[33:0]) - $signed(inp_ob_in[33:0]); // W528 fix: mon_xsub_c removed

assign  flow_pd = {inp_y0_mux[15:0],inp_shift_in[4:0],inp_scale_in[15:0],inp_xsub[33:0]};

NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.flow_pd         (flow_pd[70:0])           //|< w
  ,.inp_in_pvld     (inp_in_fvld)             //|< i (connected to inp_in_fvld)
  ,.inp_in_frdy     (inp_in_frdy)             //|> w
  ,.flow_pd_reg     (flow_pd_reg[70:0])       //|> w
  ,.xsub_pvld       (xsub_pvld)               //|> w
  ,.xsub_prdy       (xsub_prdy)               //|< w
  );

assign  {inp_y0_reg[15:0],inp_shift_reg[4:0],inp_scale_reg[15:0],inp_xsub_reg[33:0]} = flow_pd_reg;

assign  inp_mul_scale[49:0] = $signed(inp_xsub_reg[33:0]) * $signed(inp_scale_reg[15:0]);   //morework

assign  flow_pd2 = {inp_y0_reg[15:0],inp_shift_reg[4:0],inp_mul_scale[49:0]};

NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p2 pipe_p2 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.flow_pd2        (flow_pd2[70:0])          //|< w
  ,.mul_scale_prdy  (mul_scale_prdy)          //|< w
  ,.xsub_pvld       (xsub_pvld)               //|< w
  ,.flow_pd2_reg    (flow_pd2_reg[70:0])      //|> w
  ,.mul_scale_pvld  (mul_scale_pvld)          //|> w
  ,.xsub_prdy       (xsub_prdy)               //|> w
  );

assign  {inp_y0_reg2[15:0],inp_shift_reg2[4:0],inp_mul_scale_reg[49:0]} = flow_pd2_reg;

NV_NVDLA_HLS_shiftrightss #(.IN_WIDTH(50),.OUT_WIDTH(32),.SHIFT_WIDTH(5)) intp_flow_shiftright_ss (
   .data_in         (inp_mul_scale_reg[49:0]) //|< w
  ,.shift_num       (inp_shift_reg2[4:0])     //|< w
  ,.data_out        (inp_mul_tru[31:0])       //|> w
  );
//signed
//signed
  
assign  inp_y0_sum[32:0] = $signed(inp_y0_reg2[15:0]) + $signed(inp_mul_tru[31:0]);  //morework 

NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p3 pipe_p3 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.inp_y0_sum      (inp_y0_sum[32:0])        //|< w
  ,.mul_scale_pvld  (mul_scale_pvld)          //|< w
  ,.mul_scale_prdy  (mul_scale_prdy)          //|> w
  ,.inp_fout_pvld   (inp_fout_pvld)           //|> w
  ,.inp_out_prdy    (inp_fout_prdy)           //|< i (connected to inp_fout_prdy)
  ,.inp_y0_sum_reg  (inp_y0_sum_reg[32:0])    //|> w
  );

NV_NVDLA_HLS_saturate #(.IN_WIDTH(33),.OUT_WIDTH(32)) intp_flow_saturate (
   .data_in         (inp_y0_sum_reg[32:0])    //|< w
  ,.data_out        (inp_flow_dout[31:0])     //|> w
  );

//hit interpolation
assign  frac_in[34:0] = inp_flow_in ? 0 : inp_frac_in[34:0];   //unsigned  
 
assign  frac_remain[35:0] = ({1'b1, {35{1'b0}}} ) - frac_in[34:0];   //unsigned 

assign  mul0[52:0] = $signed(inp_y0_in[15:0]) *$signed({1'b0,frac_remain[35:0]});

NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p4 pipe_p4 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.inp_in_pvld     (inp_in_mvld)             //|< i (connected to inp_in_mvld)
  ,.inp_in_prdy0    (inp_in_prdy0)            //|> w
  ,.mul0            (mul0[52:0])              //|< w
  ,.mul0_prdy       (mul0_prdy)               //|< w
  ,.mul0_pvld       (mul0_pvld)               //|> w
  ,.mul0_reg        (mul0_reg[52:0])          //|> w
  );

assign  mul1[52:0] = $signed(inp_y1_in[15:0]) *$signed({2'b0,frac_in[34:0]});

NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p5 pipe_p5 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.inp_in_pvld     (inp_in_mvld)             //|< i (connected to inp_in_mvld)
  ,.inp_in_prdy1    (inp_in_prdy1)            //|> w
  ,.mul1            (mul1[52:0])              //|< w
  ,.mul1_prdy       (mul1_prdy)               //|< w
  ,.mul1_pvld       (mul1_pvld)               //|> w
  ,.mul1_reg        (mul1_reg[52:0])          //|> w
  );

assign  intp_sum[52:0] = $signed(mul0_reg[52:0]) + $signed(mul1_reg[52:0]); // W528 fix: mon_intp_sum_c removed

assign  mul0_prdy = sum_in_prdy;
assign  mul1_prdy = sum_in_prdy;
assign  sum_in_pvld = mul0_pvld & mul1_pvld;

NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p6 pipe_p6 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.intp_sum        (intp_sum[52:0])          //|< w
  ,.sum_in_pvld     (sum_in_pvld)             //|< w
  ,.sum_out_prdy    (sum_out_prdy)            //|< w
  ,.intp_sum_reg    (intp_sum_reg[52:0])      //|> w
  ,.sum_in_prdy     (sum_in_prdy)             //|> w
  ,.sum_out_pvld    (sum_out_pvld)            //|> w
  );

NV_NVDLA_HLS_shiftrightsu #(.IN_WIDTH(53),.OUT_WIDTH(32),.SHIFT_WIDTH(6)) inp_shiftright_su (
   .data_in         (intp_sum_reg[52:0])      //|< w
  ,.shift_num       (6'd35)                   //|< ?
  ,.data_out        (intp_sum_tru[31:0])      //|> w
  );
//signed 
//unsigned 
                
NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p7 pipe_p7 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.intp_sum_tru    (intp_sum_tru[31:0])      //|< w
  ,.sum_out_pvld    (sum_out_pvld)            //|< w
  ,.sum_out_prdy    (sum_out_prdy)            //|> w
  ,.inp_mout_pvld   (inp_mout_pvld)           //|> w
  ,.inp_out_prdy    (inp_mout_prdy)           //|< i (connected to inp_mout_prdy)
  ,.inp_nrm_dout    (inp_nrm_dout[31:0])      //|> w
  );


assign  inp_in_fvld =  inp_flow_in & inp_flow_prdy & inp_in_pvld; 
assign  inp_in_mvld = !inp_flow_in & inp_flow_prdy & inp_in_pvld;
assign  inp_flow_pvld = (inp_flow_in ? inp_in_frdy : inp_in_prdy0 & inp_in_prdy1) & inp_in_pvld; 
assign  inp_in_prdy  =  (inp_flow_in ? inp_in_frdy : inp_in_prdy0 & inp_in_prdy1) & inp_flow_prdy;

assign  inp_fout_prdy =  flow_in_pipe3 & flow_pipe3_pvld & inp_out_prdy;
assign  inp_mout_prdy = !flow_in_pipe3 & flow_pipe3_pvld & inp_out_prdy;
assign  flow_pipe3_prdy = (flow_in_pipe3 ? inp_fout_pvld : inp_mout_pvld) & inp_out_prdy;

assign  inp_out_pvld = (flow_in_pipe3 ? inp_fout_pvld : inp_mout_pvld) & flow_pipe3_pvld; 
assign  inp_data_out = flow_in_pipe3 ? inp_flow_dout : inp_nrm_dout;


NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p8 pipe_p8 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.flow_pipe1_prdy (flow_pipe1_prdy)         //|< w
  ,.inp_flow_in     (inp_flow_in)             //|< i
  ,.inp_flow_pvld   (inp_flow_pvld)           //|< i
  ,.flow_in_pipe1   (flow_in_pipe1)           //|> w
  ,.inp_flow_prdy   (inp_flow_prdy)           //|> w  
  ,.flow_pipe1_pvld (flow_pipe1_pvld)         //|> w
  );
NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p9 pipe_p9 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.flow_in_pipe1   (flow_in_pipe1)           //|< w
  ,.flow_pipe1_pvld (flow_pipe1_pvld)         //|< w
  ,.flow_pipe2_prdy (flow_pipe2_prdy)         //|< w
  ,.flow_in_pipe2   (flow_in_pipe2)           //|> w
  ,.flow_pipe1_prdy (flow_pipe1_prdy)         //|> w
  ,.flow_pipe2_pvld (flow_pipe2_pvld)         //|> w
  );
NV_NVDLA_SDP_HLS_Y_INT_INP_pipe_p10 pipe_p10 (
   .nvdla_core_clk  (nvdla_core_clk)          //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)         //|< i
  ,.flow_in_pipe2   (flow_in_pipe2)           //|< w
  ,.flow_pipe2_pvld (flow_pipe2_pvld)         //|< w
  ,.flow_pipe3_prdy (flow_pipe3_prdy)         //|< i
  ,.flow_in_pipe3   (flow_in_pipe3)           //|> w
  ,.flow_pipe2_prdy (flow_pipe2_prdy)         //|> w
  ,.flow_pipe3_pvld (flow_pipe3_pvld)         //|> w *
  );



endmodule
