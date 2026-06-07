module b19(clock, reset, bs, na, hold, in1, in2, in3, ris);
//module b18(clock, reset, hold, na, bs, sel, din, dout, aux);

input clock;
input reset;
input bs;
input na;
input hold;
input [10:0] in1;
input [10:0] in2;
input [19:0] in3;

output reg [29:0] ris;



//for all: b18 use entity work.b18(BEHAV);
reg sel1; reg sel2;
wire [19:0] do1; wire [19:0] do2;
reg [31:0] di1; reg [31:0] di2;
wire [3:0] ax1; wire [3:0] ax2;

b18 P1(clock, reset, hold, na, bs, sel1, di1, do1, ax1);

b18 P2(clock, reset, hold, na, bs, sel2, di2, do2, ax2);

always @(posedge clock, posedge reset) begin
    if(reset == 1'b1) begin
		sel1 <= 1'b0;
		sel2 <= 1'b0;
		end else begin
		if(do1 == 39) begin
			sel2 <= 1'b1;
		end
		else if(do1 == 1735) begin
			sel2 <= 1'b0;
		end
		if(do2 == 398) begin
			sel1 <= 1'b1;
		end
		else if(do2 == 1013) begin
			sel1 <= 1'b0;
		end
	end
end

always @(sel1, sel2, in1, in2, in3, do1, do2, ax1, ax2) begin
    if(sel1 == 1'b0 && sel2 == 1'b1) begin
		di1 <= in1 / 2;
		di2 <= in2 / 16;
	end
    else begin
		di1 <= in1 / 2;
		di2 <= in2 / 8;
	end
    ris <= ((ax1 - ax2) * do1) - ((ax1 - ax2) * do2);
end


endmodule
