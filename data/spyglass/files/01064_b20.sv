module b20(clock, reset, si, so, rd, wr);
//module b14(clock, reset, addr, datai, datao, rd, wr);
//module b14rev(clock, reset, addr, datai, datao, rd, wr);
input clock;
input reset;
input [31:0] si;
output reg [19:0] so;
output reg rd;
output reg wr;


wire [19:0] addr_1; wire [19:0] addr_2;
reg [31:0] datai_1; reg [31:0] datai_2;
wire [31:0] datao_1; wire [31:0] datao_2;
wire rd_1; wire rd_2; wire wr_1; wire wr_2;

b14 P1(clock, reset, addr_1, datai_1, datao_1, rd_1, wr_1);

b14rev P2(clock, reset, addr_2, datai_2, datao_2, rd_2, wr_2);

always @(addr_1, addr_2, rd_1, rd_2, wr_1, wr_2, datao_1, datao_2, si) begin
    // so <= addr_1 + addr_2;
    so <= (addr_1 + addr_2) % 2 ** 20;
    // removed (!)fs020699
    rd <= rd_1 ^  ~rd_2;
    wr <= wr_1 ^  ~wr_2;
    if((addr_1 < (2 ** 19) && addr_2 < (2 ** 19) && rd_1 == 1'b0) || (addr_1 > (2 ** 19 - 1) && addr_2 > (2 ** 19 - 1) && rd_2 == 1'b0)) begin
		datai_1 = datao_2 + si;
		datai_2 = datao_1;
	end
    else begin
		datai_1 <= datao_2;
		datai_2 <= datao_1 + si;
	end
end


endmodule
