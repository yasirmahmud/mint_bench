module synch_fifo  (clk_i,rst_i,wdata_i,rdata_o,wr_en_i,rd_en_i,full_o,empty_o,error_o);

parameter WIDTH=8;
parameter DEPTH=16;
parameter ADDR_WIDTH=$clog2(DEPTH);
input clk_i,rst_i,wr_en_i,rd_en_i;
input [WIDTH-1:0]wdata_i;
output reg [WIDTH-1:0]rdata_o;
output reg full_o,empty_o,error_o;
reg [ADDR_WIDTH-1:0]wr_ptr,rd_ptr;
reg wr_toggle_f,rd_toggle_f;
reg [WIDTH-1:0]mem[DEPTH-1:0];
integer i;

// Declare next-state intermediate variables at the module level
reg [ADDR_WIDTH-1:0] next_wr_ptr;
reg wr_toggle_f_next;
reg [ADDR_WIDTH-1:0] next_rd_ptr;
reg rd_toggle_f_next;

always @(posedge clk_i)begin
	if(rst_i==1)begin
		rdata_o <= 0;
		error_o <= 0;
		wr_ptr <= 0;
		rd_ptr <= 0;
		wr_toggle_f <= 0;
		rd_toggle_f <= 0;
		for(i=0;i<DEPTH;i=i+1)begin
			mem[i] <= 0;
		end
	end
	else begin
		// Initialize intermediate variables with current state for this cycle's calculations
		next_wr_ptr = wr_ptr;
		wr_toggle_f_next = wr_toggle_f;
		next_rd_ptr = rd_ptr;
		rd_toggle_f_next = rd_toggle_f;

		error_o <= 1'b0;

		if(wr_en_i==1)begin
			if(full_o==0)begin
				mem[wr_ptr] <= wdata_i;
				if(wr_ptr==DEPTH-1)begin
					next_wr_ptr = 0;
					wr_toggle_f_next = ~wr_toggle_f;
				end
				else begin
					next_wr_ptr = wr_ptr + 1;
				end
			end
			else begin
				error_o <= 1'b1;
			end
		end

		if(rd_en_i==1)begin
			if(empty_o==0)begin
				rdata_o <= mem[rd_ptr];
				if(rd_ptr==DEPTH-1)begin
					next_rd_ptr = 0;
					rd_toggle_f_next = ~rd_toggle_f;
				end
				else begin
					next_rd_ptr = rd_ptr + 1;
				end
			end
			else begin
				error_o <= 1'b1;
			end
		end

		// Apply calculated next states to registers at the end of the clock cycle
		wr_ptr <= next_wr_ptr;
		wr_toggle_f <= wr_toggle_f_next;
		rd_ptr <= next_rd_ptr;
		rd_toggle_f <= rd_toggle_f_next;
	end
end

always@(*)begin
	empty_o = 1'b0;
	full_o = 1'b0;

	if(wr_ptr==rd_ptr && wr_toggle_f==rd_toggle_f)begin
		empty_o = 1'b1;
	end
	if(wr_ptr==rd_ptr && wr_toggle_f!=rd_toggle_f)begin
		full_o = 1'b1;
	end
end

endmodule
