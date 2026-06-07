module b20(clock, reset, si, so, rd, wr,
           addr_1_i, addr_2_i, rd_1_i, rd_2_i, wr_1_i, wr_2_i);
input clock;
input reset;
input [31:0] si;
output reg [19:0] so;
output reg rd;
output reg wr;

// Added new inputs to drive the previously undriven internal wires
input [19:0] addr_1_i;
input [19:0] addr_2_i;
input rd_1_i;
input rd_2_i;
input wr_1_i;
input wr_2_i;

wire [19:0] addr_1; wire [19:0] addr_2;
reg [31:0] datai_1; reg [31:0] datai_2;
wire [31:0] datao_1; wire [31:0] datao_2;
wire rd_1; wire rd_2; wire wr_1; wire wr_2;

// Connect the internal wires to the new top-level inputs to resolve 'UndrivenInTerm-ML' and 'W123' violations
assign addr_1 = addr_1_i;
assign addr_2 = addr_2_i;
assign rd_1 = rd_1_i;
assign rd_2 = rd_2_i;
assign wr_1 = wr_1_i;
assign wr_2 = wr_2_i;

b14 P1(clock, reset, addr_1, datai_1, datao_1, rd_1, wr_1);

b14rev P2(clock, reset, addr_2, datai_2, datao_2, rd_2, wr_2);

// Changed all assignments in this combinational block to blocking assignments (=)
// to resolve SYNTH_77, W505, and W414 violations.
always @(addr_1, addr_2, rd_1, rd_2, wr_1, wr_2, datao_1, datao_2, si) begin
    so = (addr_1 + addr_2) % (2 ** 20);
    rd = rd_1 ^  ~rd_2;
    wr = wr_1 ^  ~wr_2;
    if((addr_1 < (2 ** 19) && addr_2 < (2 ** 19) && rd_1 == 1'b0) || (addr_1 > (2 ** 19 - 1) && addr_2 > (2 ** 19 - 1) && rd_2 == 1'b0)) begin
		datai_1 = datao_2 + si;
		datai_2 = datao_1;
	end
    else begin
		datai_1 = datao_2;
		datai_2 = datao_1 + si;
	}
end


endmodule
