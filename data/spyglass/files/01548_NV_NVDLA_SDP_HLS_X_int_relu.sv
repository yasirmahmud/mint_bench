module NV_NVDLA_SDP_HLS_X_int_relu (
   cfg_relu_bypass //|< i
  ,nvdla_core_clk  //|< i
  ,nvdla_core_rstn //|< i
  ,relu_out_prdy   //|< i
  ,trt_data_out    //|< i
  ,trt_out_pvld    //|< i
  ,relu_data_out   //|> o
  ,relu_out_pvld   //|> o
  ,trt_out_prdy    //|> o
  );
 
//parameter  X_OUT_WIDTH = 32;

input                    nvdla_core_clk;
input                    nvdla_core_rstn;
input                    cfg_relu_bypass;
input                    trt_out_pvld;
output                   trt_out_prdy;
input  [31:0] trt_data_out;
output [31:0] relu_data_out;
output                   relu_out_pvld;
input                    relu_out_prdy;

wire   [31:0] relu_dout;
wire   [31:0] relu_out;



// synoff nets

// monitor nets

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    
NV_NVDLA_SDP_HLS_relu #(.DATA_WIDTH(32 )) u_x_relu (
   .data_in         (trt_data_out[31:0])  //|< i
  ,.data_out        (relu_out[31:0])      //|> w
  );

assign  relu_dout[31:0] = cfg_relu_bypass ? trt_data_out[31:0] : relu_out[31:0];

NV_NVDLA_SDP_HLS_X_INT_RELU_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)      //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)     //|< i
  ,.relu_dout       (relu_dout[31:0])     //|< w
  ,.relu_out_prdy   (relu_out_prdy)       //|< i
  ,.trt_out_pvld    (trt_out_pvld)        //|< i
  ,.relu_data_out   (relu_data_out[31:0]) //|> o
  ,.relu_out_pvld   (relu_out_pvld)       //|> o
  ,.trt_out_prdy    (trt_out_prdy)        //|> o
  );

endmodule
