module NV_NVDLA_SDP_CORE_pack (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,inp_pvld
  ,inp_data
  ,inp_prdy
  ,out_pvld
  ,out_data
  ,out_prdy
);

parameter   IW = 512;
parameter   OW = 128;
parameter   RATIO = IW/OW;

input nvdla_core_clk;
input nvdla_core_rstn;

input  inp_pvld;
output inp_prdy;
input  [IW-1:0] inp_data;

output out_pvld;
input  out_prdy;
output [OW-1:0] out_data;

reg  [IW-1:0] pack_data;
reg           pack_pvld;
wire          pack_prdy;
wire          inp_acc;
wire          out_acc;
wire          is_pack_last;
reg  [OW-1:0] mux_data;


assign out_data  = mux_data;

assign pack_prdy = out_prdy;
assign out_pvld  = pack_pvld;
assign inp_prdy = (!pack_pvld) | (pack_prdy & is_pack_last);

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) 
    pack_pvld <= 1'b0;
  else if (inp_prdy) 
    pack_pvld <= inp_pvld;
end


assign inp_acc = inp_pvld & inp_prdy;
assign out_acc = out_pvld & out_prdy;

always @(posedge nvdla_core_clk) begin
  if (inp_acc) 
    pack_data <= inp_data;
end

wire [OW*16-1:0] pack_data_ext = {{(OW*16-IW){1'b0}},pack_data};

reg  [3:0]  pack_cnt;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) 
    pack_cnt <= 4'h0;
  else if (out_acc) begin
    if (is_pack_last) 
        pack_cnt <= 4'h0;
    else 
        pack_cnt <= pack_cnt + 1;
  end
end

assign is_pack_last = (pack_cnt==RATIO-1);

// --- Start of changes to resolve W528 violations ---
// Declare segments as an array, sized dynamically by RATIO
wire [OW-1:0] pack_seg [RATIO-1:0];

// Generate assignments for each segment within the array
generate
    genvar i;
    for (i=0; i<RATIO; i=i+1) begin : gen_pack_seg_assign
        assign pack_seg[i] = pack_data_ext[((OW*i) + OW - 1):(OW*i)];
    end
endgenerate

// Use a single always block to select from the segment array based on pack_cnt
always @(pack_cnt or pack_seg) begin
    mux_data = pack_seg[pack_cnt];
end
// --- End of changes ---


endmodule
