module NV_NVDLA_SDP_HLS_Y_int_idx (
   cfg_lut_hybrid_priority //|< i
  ,cfg_lut_le_function     //|< i
  ,cfg_lut_le_index_offset //|< i
  ,cfg_lut_le_index_select //|< i
  ,cfg_lut_le_start        //|< i
  ,cfg_lut_lo_index_select //|< i
  ,cfg_lut_lo_start        //|< i
  ,cfg_lut_oflow_priority  //|< i
  ,cfg_lut_uflow_priority  //|< i
  ,lut_data_in             //|< i
  ,lut_in_pvld             //|< i
  ,lut_out_prdy            //|< i
  ,nvdla_core_clk          //|< i
  ,nvdla_core_rstn         //|< i
  ,lut_in_prdy             //|> o
  ,lut_out_frac            //|> o
  ,lut_out_le_hit          //|> o
  ,lut_out_lo_hit          //|> o
  ,lut_out_oflow           //|> o
  ,lut_out_pvld            //|> o
  ,lut_out_ram_addr        //|> o
  ,lut_out_ram_sel         //|> o
  ,lut_out_uflow           //|> o
  ,lut_out_x               //|> o
  );

input         cfg_lut_hybrid_priority;
input         cfg_lut_le_function;
input   [7:0] cfg_lut_le_index_offset;
input   [7:0] cfg_lut_le_index_select;
input  [31:0] cfg_lut_le_start;
input   [7:0] cfg_lut_lo_index_select;
input  [31:0] cfg_lut_lo_start;
input         cfg_lut_oflow_priority;
input         cfg_lut_uflow_priority;
input  [31:0] lut_data_in;
input         lut_in_pvld;
input         lut_out_prdy;
input         nvdla_core_clk;
input         nvdla_core_rstn;
output        lut_in_prdy;
output [34:0] lut_out_frac;
output        lut_out_le_hit;
output        lut_out_lo_hit;
output        lut_out_oflow;
output        lut_out_pvld;
output  [8:0] lut_out_ram_addr;
output        lut_out_ram_sel;
output        lut_out_uflow;
output [31:0] lut_out_x;


reg    [34:0] lut_final_frac;
reg           lut_final_oflow;
reg     [8:0] lut_final_ram_addr;
reg           lut_final_ram_sel;
reg           lut_final_uflow;
wire    [7:0] le_expn_cfg_offset;
wire   [31:0] le_expn_cfg_start;
wire   [31:0] le_expn_data_in;
wire   [34:0] le_expn_frac;
wire          le_expn_in_prdy;
wire          le_expn_in_pvld;
wire    [8:0] le_expn_index;
wire          le_expn_oflow;
wire          le_expn_out_prdy;
wire          le_expn_out_pvld;
wire          le_expn_uflow;
wire   [34:0] le_frac;
wire          le_hit;
wire    [8:0] le_index;
wire    [7:0] le_line_cfg_sel;
wire   [31:0] le_line_cfg_start;
wire   [31:0] le_line_data_in;
wire   [34:0] le_line_frac;
wire          le_line_in_prdy;
wire          le_line_in_pvld;
wire    [8:0] le_line_index;
wire          le_line_oflow;
wire          le_line_out_prdy;
wire          le_line_out_pvld;
wire          le_line_uflow;
wire          le_miss;
wire          le_oflow;
wire          le_uflow;
wire   [34:0] lo_frac;
wire          lo_hit;
wire    [8:0] lo_index;
wire   [34:0] lo_line_frac;
wire          lo_line_in_pvld;
wire          lo_line_in_prdy;
wire    [8:0] lo_line_index;
wire          lo_line_oflow;
wire          lo_line_out_pvld;
wire          lo_line_out_prdy;
wire          lo_line_uflow;
wire          lo_miss;
wire          lo_oflow;
wire          lo_uflow;
wire   [80:0] lut_final_pd;
wire          lut_final_prdy;
wire          lut_final_pvld;
wire   [31:0] lut_final_x;
wire          lut_x_in_pvld;
wire          lut_x_in_prdy;
wire          lut_x_out_pvld;
wire          lut_x_out_prdy;
wire          lut_pipe2_prdy;
wire          lut_pipe2_pvld;
wire   [31:0] lut_pipe2_x;
wire          lut_pipe_prdy;
wire          lut_pipe_pvld;
wire   [31:0] lut_pipe_x;
wire   [80:0] lut_out_pd;


    
//The same three stage pipe with lut_expn and lut_line
NV_NVDLA_SDP_HLS_Y_INT_IDX_pipe_p1 pipe_p1 (
   .nvdla_core_clk  (nvdla_core_clk)               //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)              //|< i
  ,.lut_data_in     (lut_data_in[31:0])            //|< i
  ,.lut_x_in_pvld   (lut_x_in_pvld)                //|< i
  ,.lut_pipe_prdy   (lut_pipe_prdy)                //|< w
  ,.lut_x_in_prdy   (lut_x_in_prdy)                //|> w 
  ,.lut_pipe_pvld   (lut_pipe_pvld)                //|> w
  ,.lut_pipe_x      (lut_pipe_x[31:0])             //|> w
  );
NV_NVDLA_SDP_HLS_Y_INT_IDX_pipe_p2 pipe_p2 (
   .nvdla_core_clk  (nvdla_core_clk)               //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)              //|< i
  ,.lut_pipe2_prdy  (lut_pipe2_prdy)               //|< w
  ,.lut_pipe_pvld   (lut_pipe_pvld)                //|< w
  ,.lut_pipe_x      (lut_pipe_x[31:0])             //|< w
  ,.lut_pipe2_pvld  (lut_pipe2_pvld)               //|> w
  ,.lut_pipe2_x     (lut_pipe2_x[31:0])            //|> w
  ,.lut_pipe_prdy   (lut_pipe_prdy)                //|> w
  );
NV_NVDLA_SDP_HLS_Y_INT_IDX_pipe_p3 pipe_p3 (
   .nvdla_core_clk  (nvdla_core_clk)               //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)              //|< i
  ,.lut_pipe3_prdy  (lut_x_out_prdy)               //|< w
  ,.lut_pipe2_pvld  (lut_pipe2_pvld)               //|< w
  ,.lut_pipe2_x     (lut_pipe2_x[31:0])            //|< w
  ,.lut_pipe3_x     (lut_final_x[31:0])            //|> w
  ,.lut_pipe2_prdy  (lut_pipe2_prdy)               //|> w
  ,.lut_pipe3_pvld  (lut_x_out_pvld)               //|> w 
  );


NV_NVDLA_SDP_HLS_lut_expn #(.LUT_DEPTH(65 )) lut_le_expn (
   .cfg_lut_offset  (le_expn_cfg_offset[7:0])      //|< w
  ,.cfg_lut_start   (le_expn_cfg_start[31:0])      //|< w
  ,.idx_data_in     (le_expn_data_in[31:0])        //|< w
  ,.idx_in_pvld     (le_expn_in_pvld)              //|< w
  ,.idx_out_prdy    (le_expn_out_prdy)             //|< w
  ,.nvdla_core_clk  (nvdla_core_clk)               //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)              //|< i
  ,.idx_in_prdy     (le_expn_in_prdy)              //|> w
  ,.idx_out_pvld    (le_expn_out_pvld)             //|> w
  ,.lut_frac_out    (le_expn_frac[34:0])           //|> w
  ,.lut_index_out   (le_expn_index[8:0])           //|> w
  ,.lut_oflow_out   (le_expn_oflow)                //|> w
  ,.lut_uflow_out   (le_expn_uflow)                //|> w
  );

NV_NVDLA_SDP_HLS_lut_line #(.LUT_DEPTH(65 )) lut_le_line (
   .cfg_lut_sel     (le_line_cfg_sel[7:0])         //|< w
  ,.cfg_lut_start   (le_line_cfg_start[31:0])      //|< w
  ,.idx_data_in     (le_line_data_in[31:0])        //|< w
  ,.idx_in_pvld     (le_line_in_pvld)              //|< w
  ,.idx_out_prdy    (le_line_out_prdy)             //|< w
  ,.nvdla_core_clk  (nvdla_core_clk)               //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)              //|< i
  ,.idx_in_prdy     (le_line_in_prdy)              //|> w
  ,.idx_out_pvld    (le_line_out_pvld)             //|> w
  ,.lut_frac_out    (le_line_frac[34:0])           //|> w
  ,.lut_index_out   (le_line_index[8:0])           //|> w
  ,.lut_oflow_out   (le_line_oflow)                //|> w
  ,.lut_uflow_out   (le_line_uflow)                //|> w
  );

NV_NVDLA_SDP_HLS_lut_line #(.LUT_DEPTH(257 )) lut_lo_line (
   .cfg_lut_sel     (cfg_lut_lo_index_select[7:0]) //|< i
  ,.cfg_lut_start   (cfg_lut_lo_start[31:0])       //|< i
  ,.idx_data_in     (lut_data_in[31:0])            //|< i
  ,.idx_in_pvld     (lo_line_in_pvld)              //|< i
  ,.idx_out_prdy    (lo_line_out_prdy)             //|< w
  ,.nvdla_core_clk  (nvdla_core_clk)               //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)              //|< i
  ,.idx_in_prdy     (lo_line_in_prdy)              //|> w
  ,.idx_out_pvld    (lo_line_out_pvld)             //|> w
  ,.lut_frac_out    (lo_line_frac[34:0])           //|> w
  ,.lut_index_out   (lo_line_index[8:0])           //|> w
  ,.lut_oflow_out   (lo_line_oflow)                //|> w
  ,.lut_uflow_out   (lo_line_uflow)                //|> w
  );


//sync lut_x_in, le_in,lo_in 
assign  le_expn_in_pvld  = (cfg_lut_le_function == 0 ) & lut_in_pvld & lo_line_in_prdy & lut_x_in_prdy;
assign  le_line_in_pvld  = (cfg_lut_le_function != 0 ) & lut_in_pvld & lo_line_in_prdy & lut_x_in_prdy;
assign  lo_line_in_pvld  = ((cfg_lut_le_function == 0 ) ? le_expn_in_prdy  : le_line_in_prdy ) & lut_in_pvld & lut_x_in_prdy;
assign  lut_x_in_pvld    = ((cfg_lut_le_function == 0 ) ? le_expn_in_prdy  : le_line_in_prdy ) & lut_in_pvld & lo_line_in_prdy;
assign  lut_in_prdy      = ((cfg_lut_le_function == 0 ) ? le_expn_in_prdy  : le_line_in_prdy ) & lo_line_in_prdy & lut_x_in_prdy;

//sync lut_x_out, le_out,lo_out 
assign  le_expn_out_prdy = (cfg_lut_le_function == 0 ) & lut_final_prdy & lo_line_out_pvld & lut_x_out_pvld;
assign  le_line_out_prdy = (cfg_lut_le_function != 0 ) & lut_final_prdy & lo_line_out_pvld & lut_x_out_pvld;
assign  lo_line_out_prdy = ((cfg_lut_le_function == 0 ) ? le_expn_out_pvld : le_line_out_pvld) & lut_final_prdy & lut_x_out_pvld;
assign  lut_x_out_prdy   = ((cfg_lut_le_function == 0 ) ? le_expn_out_pvld : le_line_out_pvld) & lut_final_prdy & lo_line_out_pvld;
assign  lut_final_pvld   = ((cfg_lut_le_function == 0 ) ? le_expn_out_pvld : le_line_out_pvld) & lo_line_out_pvld & lut_x_out_pvld;


assign  le_expn_data_in[31:0]         = (cfg_lut_le_function == 0 ) ? lut_data_in[31:0] : {32  {1'b0}};
assign  le_expn_cfg_start[31:0]      = (cfg_lut_le_function == 0 ) ? cfg_lut_le_start[31:0] : {32 {1'b0}};
assign  le_expn_cfg_offset[7:0] = (cfg_lut_le_function == 0 ) ? cfg_lut_le_index_offset[7:0] : {8 {1'b0}};

assign  le_line_data_in[31:0]      = (cfg_lut_le_function != 0 ) ? lut_data_in[31:0] : {32  {1'b0}};
assign  le_line_cfg_start[31:0]   = (cfg_lut_le_function != 0 ) ? cfg_lut_le_start[31:0] : {32 {1'b0}};
assign  le_line_cfg_sel[7:0] = (cfg_lut_le_function != 0 ) ? cfg_lut_le_index_select[7:0] : {8 {1'b0}};


assign  le_oflow = (cfg_lut_le_function == 0 ) ? le_expn_oflow : le_line_oflow; 
assign  le_uflow = (cfg_lut_le_function == 0 ) ? le_expn_uflow : le_line_uflow; 

assign  le_index[8:0] = (cfg_lut_le_function == 0 ) ? le_expn_index[8:0] : le_line_index[8:0]; 
assign  le_frac[34:0] = (cfg_lut_le_function == 0 ) ? le_expn_frac[34:0] : le_line_frac[34:0]; 

assign  lo_oflow = lo_line_oflow; 
assign  lo_uflow = lo_line_uflow; 
assign  lo_index[8:0] = lo_line_index[8:0]; 
assign  lo_frac[34:0] = lo_line_frac[34:0]; 

//hit miss
assign  le_miss = (le_uflow | le_oflow);
assign  le_hit = !le_miss;
assign  lo_miss = (lo_uflow | lo_oflow);
assign  lo_hit = !lo_miss;
        

always @(
  le_uflow
  or lo_uflow
  or cfg_lut_uflow_priority
  or lo_index
  or le_index
  or lo_frac
  or le_frac
  or le_oflow
  or lo_oflow
  or cfg_lut_oflow_priority
  or le_hit
  or lo_hit
  or cfg_lut_hybrid_priority
  or le_miss
  or lo_miss
  ) begin
   if (le_uflow & lo_uflow) begin
        lut_final_uflow   = cfg_lut_uflow_priority ? lo_uflow  : le_uflow;
        lut_final_oflow   = 0;
        lut_final_ram_sel = cfg_lut_uflow_priority ? 1  : 0 ;
        lut_final_ram_addr= cfg_lut_uflow_priority ? lo_index  : le_index;
        lut_final_frac    = cfg_lut_uflow_priority ? lo_frac   : le_frac;
    end 
    else if (le_oflow & lo_oflow) begin
        lut_final_uflow   = 0;
        lut_final_oflow   = cfg_lut_oflow_priority ? lo_oflow  : le_oflow;
        lut_final_ram_sel = cfg_lut_oflow_priority ? 1  : 0 ;
        lut_final_ram_addr= cfg_lut_oflow_priority ? lo_index  : le_index;
        lut_final_frac    = cfg_lut_oflow_priority ? lo_frac   : le_frac;
    end 
    else if (le_hit & lo_hit) begin
        lut_final_ram_addr= cfg_lut_hybrid_priority ? lo_index : le_index;
        lut_final_frac    = cfg_lut_hybrid_priority ? lo_frac  : le_frac;
        lut_final_ram_sel = cfg_lut_hybrid_priority ? 1 : 0 ;
        lut_final_uflow   = 0;
        lut_final_oflow   = 0;
    end 
    else if (le_miss & lo_miss) begin
        lut_final_ram_addr= cfg_lut_hybrid_priority ? lo_index : le_index;
        lut_final_frac    = cfg_lut_hybrid_priority ? lo_frac  : le_frac;
        lut_final_ram_sel = cfg_lut_hybrid_priority ? 1 : 0 ;
        lut_final_uflow   = cfg_lut_hybrid_priority ? lo_uflow : le_uflow;
        lut_final_oflow   = cfg_lut_hybrid_priority ? lo_oflow : le_oflow;
    end 
    else if (le_hit) begin
        lut_final_ram_addr= le_index;
        lut_final_frac    = le_frac;
        lut_final_ram_sel = 0 ;
        lut_final_uflow   = 0;
        lut_final_oflow   = 0;
    end 
    else begin // if (lo_hit) begin
        lut_final_ram_addr= lo_index;
        lut_final_frac    = lo_frac;
        lut_final_ram_sel = 1 ;
        lut_final_uflow   = 0;
        lut_final_oflow   = 0;
    end
end


assign lut_final_pd = {lo_hit,le_hit,lut_final_oflow,lut_final_uflow,lut_final_frac[34:0],lut_final_ram_addr[8:0],lut_final_ram_sel,lut_final_x[31:0]};
assign {lut_out_lo_hit,lut_out_le_hit,lut_out_oflow,lut_out_uflow,lut_out_frac[34:0],lut_out_ram_addr[8:0],lut_out_ram_sel,lut_out_x[31:0]} = lut_out_pd;

NV_NVDLA_SDP_HLS_Y_INT_IDX_pipe_p4 pipe_p4 (
   .nvdla_core_clk  (nvdla_core_clk)               //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn)              //|< i
  ,.lut_final_pd    (lut_final_pd[80:0])           //|< w
  ,.lut_final_pvld  (lut_final_pvld)               //|< w
  ,.lut_out_prdy    (lut_out_prdy)                 //|< i
  ,.lut_final_prdy  (lut_final_prdy)               //|> w
  ,.lut_out_pd      (lut_out_pd[80:0])             //|> w
  ,.lut_out_pvld    (lut_out_pvld)                 //|> o
  );


endmodule
