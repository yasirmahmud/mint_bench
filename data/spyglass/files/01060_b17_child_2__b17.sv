module b17(clock, reset, datai, datao, hold, na, bs16, address1, address2, wr, dc, mio, ast1,ast2, ready1, ready2);

	input clock;
	input reset;
	input [31:0] datai;
	output reg [31:0] datao;
	input hold;
	input na;
	input bs16;
	output reg [30:0]address1;
	output reg [30:0]address2;
	output reg wr;
	output reg dc;
	output reg mio;
	output reg ast1;
	output reg ast2;
	input ready1;
	input ready2;


reg [31:0] buf1; reg [31:0] buf2;
wire [3:0] be1; wire [3:0] be2; wire [3:0] be3;
wire [31:0] addr1; wire [31:0] addr2; wire [31:0] addr3;
wire wr1; wire wr2; wire wr3;
wire dc1; wire dc2; wire dc3;
wire mio1, mio2, mio3;
wire ads1; wire ads2; wire ads3;
reg [31:0] di1; reg [31:0] di2; reg [31:0] di3;
wire [31:0] do1; wire [31:0] do2; wire [31:0] do3;
reg rdy1; reg rdy2; reg rdy3;
reg ready11; reg ready12; reg ready21; reg ready22;

b15 P1(be1, addr1, wr1, dc1, mio1, ads1, di1, do1, clock, na, bs16, rdy1, hold, reset);

b15 P2(be2, addr2, wr2, dc2, mio2, ads2, di2, do2, clock, na, bs16, rdy2, hold, reset);

b15 P3(be3, addr3, wr3, dc3, mio3, ads3, di3, do3, clock, na, bs16, rdy3, hold, reset);

always @(posedge clock, posedge reset) begin
    if(reset == 1'b1) begin
		buf1 <= 0;
		ready11 <= 1'b0;
		ready12 <= 1'b0;
		end else begin
		if(addr1 > (2 ** 29) && ads1 == 1'b0 && mio1 == 1'b1 && dc1 == 1'b0 && wr1 == 1'b1 && be1 == 4'b0000) begin
			buf1 <= do1;
			ready11 <= 1'b0;
			ready12 <= 1'b1;
		end
		else if(addr2 > (2 ** 29) && ads2 == 1'b0 && mio2 == 1'b1 && dc2 == 1'b0 && wr2 == 1'b1 && be2 == 4'b0000) begin
			buf1 <= do2;
			ready11 <= 1'b1;
			ready12 <= 1'b0;
		end
		else begin
			buf1 <= buf1; // Preserve current value if no update condition is met
			ready11 <= 1'b1;
			ready12 <= 1'b1;
		end
	end
end

always @(posedge clock, posedge reset) begin
    if(reset == 1'b1) begin
		buf2 <= 0;
		ready21 <= 1'b0;
		ready22 <= 1'b0;
		end else begin
		if(addr2 < (2 ** 29) && ads2 == 1'b0 && mio2 == 1'b1 && dc2 == 1'b0 && wr2 == 1'b1 && be2 == 4'b0000) begin
			buf2 <= do2;
			ready21 <= 1'b0;
			ready22 <= 1'b1;
		end
		else if(ads3 == 1'b0 && mio3 == 1'b1 && dc3 == 1'b0 && wr3 == 1'b0 && be3 == 4'b0000) begin
			buf2 <= buf2; // Preserve current value if no update condition is met
			ready21 <= 1'b1;
			ready22 <= 1'b0;
		end
		else begin
			buf2 <= buf2; // Preserve current value if no update condition is met
			ready21 <= 1'b1;
			ready22 <= 1'b1;
		end
	end
end

always @(addr1, buf1, datai) begin
    if(addr1 > (2 ** 29)) begin
		di1 <= buf1;
	}
    else begin
		di1 <= datai;
	end
end

always @(addr2, buf1, buf2) begin
    if(addr2 > (2 ** 29)) begin
		di2 <= buf1;
	}
    else begin
		di2 <= buf2;
	}
end

always @(addr2, addr3, do1, do2, do3) begin
    if((do1 < (2 ** 30)) && (do2 < (2 ** 30)) && (do3 < (2 ** 30))) begin
		address2 <= addr3;
	}
    else begin
		address2 <= addr2;
	}


end

always @(buf2, do3, addr1, wr3, dc3, mio3, ads1, ads3, ready1, ready2, ready11, ready12, ready21, ready22) begin
    di3 <= buf2;
    datao <= do3;
    address1 <= addr1;
    wr <= wr3;
    dc <= dc3;
    mio <= mio3;
    ast1 <= ads1;
    ast2 <= ads3;
    rdy1 <= ready11 & ready1;
    rdy2 <= ready12 & ready21;
    rdy3 <= ready22 & ready2;
end





endmodule
