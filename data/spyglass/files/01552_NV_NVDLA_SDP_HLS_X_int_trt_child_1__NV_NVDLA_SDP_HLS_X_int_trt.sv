module NV_NVDLA_SDP_HLS_X_int_trt (
   bypass_trt_in       //|< i
  ,cfg_mul_shift_value //|< i
  ,mul_data_out        //|< i
  ,mul_out_pvld        //|< i
  ,nvdla_core_clk      //|< i
  ,nvdla_core_rstn     //|< i
  ,trt_out_prdy        //|< i
  ,mul_out_prdy        //|> o
  ,trt_data_out        //|> o
  ,trt_out_pvld        //|> o
  );

//parameter  X_MUL_OUT_WIDTH = 49;
//parameter  X_OUT_WIDTH     = 32;

input                        nvdla_core_clk;
input                        nvdla_core_rstn;
input    [5:0]               cfg_mul_shift_value;
input                        bypass_trt_in;
input  [48:0] mul_data_out;
input                        mul_out_pvld;
output                       mul_out_prdy;
output [31:0]     trt_data_out;
output                       trt_out_pvld;
input                        trt_out_prdy;

wire   [31:0]      trt_dout; // Changed from reg to wire to correctly reflect combinational drive
wire   [31:0]      trt_data_final;



// synoff nets

// monitor nets

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    
NV_NVDLA_HLS_shiftrightsu #(.IN_WIDTH(49 ),.OUT_WIDTH(32 ),.SHIFT_WIDTH(6)) x_trt_shiftright_su (
   .data_in         ((bypass_trt_in ? 49'd0 : mul_data_out[48:0])) // Cast 0 to 49-bit for clarity
  ,.shift_num       (cfg_mul_shift_value[5:0])                 //|< i
  ,.data_out        (trt_data_final[31:0])                     //|> w
  );
//signed 
//unsigned 

always @(*) begin // Changed to always @(*) for combinational logic
   if (bypass_trt_in) 
      trt_dout[31:0] = mul_data_out[31:0];   //morework
   else 
      trt_dout[31:0] = trt_data_final[31:0]; 
end

NV_NVDLA_SDP_HLS_X_INT_TRT_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)                           //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)                          //|< i
  ,.mul_out_pvld    (mul_out_pvld)                             //|< i
  ,.trt_dout        (trt_dout[31:0])                           //|< r
  ,.trt_out_prdy    (trt_out_prdy)                             //|< i
  ,.mul_out_prdy    (mul_out_prdy)                             //|> o
  ,.trt_data_out    (trt_data_out[31:0])                       //|> o
  ,.trt_out_pvld    (trt_out_pvld)                             //|> o
  );

endmodule
