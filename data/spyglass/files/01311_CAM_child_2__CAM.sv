module CAM #(
   parameter RAM_ADDR_BITS = 1,
   parameter WORD_SIZE = 8,
   parameter CELL_QUANT = 128 
) (
  input [clogb2(CELL_QUANT)-2:0] addr_in,
  input [CELL_QUANT-1:0] cell_wea_ctrl_ap,
  input internal_col_in,
  input cam_mode,
  input [WORD_SIZE-1:0] dina, 
  input direction,
  input [WORD_SIZE-1:0] key_v,
  input [WORD_SIZE-1:0] key_h,
  // input [WORD_SIZE-1:0] mask,
  
  input [WORD_SIZE-1:0] mask_v,
  input [WORD_SIZE-1:0] mask_h,
  input clock            ,
  input rst,
  input wea                  ,
  output [CELL_QUANT-1:0] tags,
  output [WORD_SIZE-1:0] doutb
);

wire [WORD_SIZE-1:0] cell_doutb_ctrl [CELL_QUANT-1:0];
wire [CELL_QUANT-1:0] wea_addr;
wire [CELL_QUANT-1:0] cell_wea_ctrl;
 
wire [WORD_SIZE-1:0] masked_key_odd;
wire [WORD_SIZE-1:0] masked_key_even;
wire [WORD_SIZE-1:0] masked_dina_odd;
wire [WORD_SIZE-1:0] masked_dina_even;
wire [WORD_SIZE-1:0] mask_d;
wire [WORD_SIZE-1:0] key_d;

assign mask_d = direction ? mask_h : mask_v;
assign key_d = direction ? key_h : key_v;

assign masked_key_even  = key_v & mask_v;
assign masked_dina_even = dina & mask_v;

assign masked_key_odd  = key_d & mask_d;
assign masked_dina_odd = dina & mask_d;

assign doutb = cell_doutb_ctrl[addr_in];

// Module_name #(.parameter_name(valor)) instance_name;
// RAM_WIDTH
genvar g;
generate
    for(g = 0; g < CELL_QUANT; g=g+2) begin : cell_gen_block
            CAM_CELL #(.RAM_WIDTH(WORD_SIZE)) _cam_cell_even(
            .in_internal_col(internal_col_in),
            .in_dina(masked_dina_even), 
            .in_key(masked_key_even),
            .in_mask(mask_v),
            .in_rst(rst), 
            .in_clock(clock), 
            .in_wea_ctrl(cell_wea_ctrl[g]), 
            .out_tag(tags[g]),
            .out_doutb(cell_doutb_ctrl[g])
            );
            
            CAM_CELL #(.RAM_WIDTH(WORD_SIZE)) _cam_cell_odd(
            .in_internal_col(internal_col_in),
            .in_dina(masked_dina_odd), 
            .in_key(masked_key_odd),
            .in_mask(mask_d),
            .in_rst(rst), 
            .in_clock(clock), 
            .in_wea_ctrl(cell_wea_ctrl[g+1]),
            .out_tag(tags[g+1]),
            .out_doutb(cell_doutb_ctrl[g+1])
            );
     end
endgenerate

assign wea_addr = wea ? 1 << addr_in : 0;
assign cell_wea_ctrl = cam_mode ? cell_wea_ctrl_ap : wea_addr;

function integer clogb2;
  input integer depth;
      for (clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
endfunction

endmodule
