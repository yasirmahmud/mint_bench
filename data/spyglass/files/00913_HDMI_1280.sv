module HDMI_1280  (
	input pixclk,  // 74MHz
	input clk_TMDS2,  // 370MHz
	input wire [7:0] red, green, blue,
	output TMDS_bh,TMDS_bl,TMDS_gh,TMDS_gl,TMDS_rh,TMDS_rl,
	output reg [10:0] CounterX, CounterY
);


reg hSync, vSync, DrawArea;
always @(posedge pixclk) DrawArea <= (CounterX<1280) && (CounterY<720);
always @(posedge pixclk) CounterX <= (CounterX==1649) ? 0 : CounterX+1;
always @(posedge pixclk) if(CounterX==1649) CounterY <= (CounterY==749) ? 0 : CounterY+1;
always @(posedge pixclk) hSync <= (CounterX>=1390) && (CounterX<1430);
always @(posedge pixclk) vSync <= (CounterY>=725) && (CounterY<730);

wire [9:0] TMDS_red, TMDS_green, TMDS_blue;
TMDS_encoder encode_R(.clk(pixclk), .VD(red  ), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_red));
TMDS_encoder encode_G(.clk(pixclk), .VD(green), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_green));
TMDS_encoder encode_B(.clk(pixclk), .VD(blue ), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));

reg [2:0] TMDS_mod5=0;  // modulus 5 counter
reg [4:0] TMDS_shift_bh=0, TMDS_shift_bl=0;
reg [4:0] TMDS_shift_gh=0, TMDS_shift_gl=0;
reg [4:0] TMDS_shift_rh=0, TMDS_shift_rl=0;

wire [4:0] TMDS_blue_l = {TMDS_blue[9],TMDS_blue[7],TMDS_blue[5],TMDS_blue[3],TMDS_blue[1]};
wire [4:0] TMDS_blue_h= {TMDS_blue[8],TMDS_blue[6],TMDS_blue[4],TMDS_blue[2],TMDS_blue[0]};
wire [4:0] TMDS_green_l = {TMDS_green[9],TMDS_green[7],TMDS_green[5],TMDS_green[3],TMDS_green[1]};
wire [4:0] TMDS_green_h= {TMDS_green[8],TMDS_green[6],TMDS_green[4],TMDS_green[2],TMDS_green[0]};
wire [4:0] TMDS_red_l = {TMDS_red[9],TMDS_red[7],TMDS_red[5],TMDS_red[3],TMDS_red[1]};
wire [4:0] TMDS_red_h= {TMDS_red[8],TMDS_red[6],TMDS_red[4],TMDS_red[2],TMDS_red[0]};

always @(posedge clk_TMDS2)
begin
	TMDS_shift_bh  <= TMDS_mod5[2] ? TMDS_blue_h   : TMDS_shift_bh  [4:1];
	TMDS_shift_bl  <= TMDS_mod5[2] ? TMDS_blue_l   : TMDS_shift_bl  [4:1];
	TMDS_shift_gh  <= TMDS_mod5[2] ? TMDS_green_h   : TMDS_shift_gh  [4:1];
	TMDS_shift_gl  <= TMDS_mod5[2] ? TMDS_green_l   : TMDS_shift_gl  [4:1];
	TMDS_shift_rh  <= TMDS_mod5[2] ? TMDS_red_h   : TMDS_shift_rh  [4:1];
	TMDS_shift_rl  <= TMDS_mod5[2] ? TMDS_red_l   : TMDS_shift_rl  [4:1];
	TMDS_mod5 <= (TMDS_mod5[2]) ? 3'd0 : TMDS_mod5+3'd1;
end

assign TMDS_bh = TMDS_shift_bh[0];
assign TMDS_bl = TMDS_shift_bl[0];
assign TMDS_gh = TMDS_shift_gh[0];
assign TMDS_gl = TMDS_shift_gl[0];
assign TMDS_rh = TMDS_shift_rh[0];
assign TMDS_rl = TMDS_shift_rl[0];

endmodule
