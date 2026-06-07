module instruction_buffer  (
	clk,
	rst,
	external_clk,
	interface_input,
	instr_to_controller,
	buffer_full
);

	input clk;
	input rst;
	input external_clk;
	input [63:0] interface_input;
	output reg [63:0] instr_to_controller;
	output reg buffer_full;

	parameter QUEUE_DEPTH = 64;
	parameter ADDR_WIDTH = 6; // log2(QUEUE_DEPTH) -> 0 to 63
	parameter PTR_WIDTH = ADDR_WIDTH + 1; // 7 bits for pointers to distinguish full/empty

	reg [63:0] queue [QUEUE_DEPTH - 1:0];

	// Write Pointer (external_clk domain)
	reg [PTR_WIDTH - 1:0] wr_ptr; // Current write pointer
	// Read Pointer (clk domain)
	reg [PTR_WIDTH - 1:0] rd_ptr; // Current read pointer

	// Synchronizers for pointers
	// wr_ptr_sync_r: wr_ptr synchronized to read clock domain
	reg [PTR_WIDTH - 1:0] wr_ptr_sync_r1, wr_ptr_sync_r2;
	// rd_ptr_sync_w: rd_ptr synchronized to write clock domain
	reg [PTR_WIDTH - 1:0] rd_ptr_sync_w1, rd_ptr_sync_w2;

	// Internal flag for dequeue logic (in read domain)
	reg buffer_empty_r;

	// Wires for next pointer values (combinational calculation)
	wire [PTR_WIDTH - 1:0] next_wr_ptr_val;
	wire [PTR_WIDTH - 1:0] next_rd_ptr_val;

	// Calculate next pointer values
	assign next_wr_ptr_val = wr_ptr + 1;
	assign next_rd_ptr_val = rd_ptr + 1;

	//----------------------------------------------------------------------
	// CDC: Synchronize wr_ptr from external_clk domain to clk domain
	//----------------------------------------------------------------------
	always @(posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			wr_ptr_sync_r1 <= 0;
			wr_ptr_sync_r2 <= 0;
		end else begin
			wr_ptr_sync_r1 <= wr_ptr;
			wr_ptr_sync_r2 <= wr_ptr_sync_r1;
		end
	end

	//----------------------------------------------------------------------
	// CDC: Synchronize rd_ptr from clk domain to external_clk domain
	//----------------------------------------------------------------------
	always @(posedge external_clk or posedge rst) begin
		if (rst == 1'b1) begin
			rd_ptr_sync_w1 <= 0;
			rd_ptr_sync_w2 <= 0;
		end else begin
			rd_ptr_sync_w1 <= rd_ptr;
			rd_ptr_sync_w2 <= rd_ptr_sync_w1;
		end
	end

	//----------------------------------------------------------------------
	// Enqueue Control Logic (external_clk domain)
	// Handles wr_ptr and the registered output buffer_full with asynchronous reset.
	//----------------------------------------------------------------------
	always @(posedge external_clk or posedge rst) begin
		if (rst == 1'b1) begin
			wr_ptr <= 0;
			buffer_full <= 0;
		end else begin
			// If not full in the previous cycle, increment pointer
			if (!buffer_full) begin // buffer_full here refers to its value before this clock edge
				wr_ptr <= next_wr_ptr_val;
			end
			// Update the registered buffer_full output for the next cycle's evaluation.
			// This flag indicates if the buffer would be full after the potential write.
			buffer_full <= (next_wr_ptr_val == rd_ptr_sync_w2);
		end
	end

	//----------------------------------------------------------------------
	// Enqueue Data Write Logic (external_clk domain)
	// This block is purely synchronous to prevent 'rst' from being inferred
	// as non-reset/synchronous-reset for the 'queue' memory elements.
	//----------------------------------------------------------------------	always @(posedge external_clk) begin
		// The queue write is conditional on 'rst' being deasserted and the buffer not being full.
		if (rst == 1'b0) begin
			if (!buffer_full) begin // buffer_full here refers to its value before this clock edge
				queue[wr_ptr[ADDR_WIDTH - 1:0]] <= interface_input;
			end
		end
	end

	//----------------------------------------------------------------------
	// Dequeue Logic (clk domain)
	//----------------------------------------------------------------------
	always @(posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			rd_ptr <= 0;
			instr_to_controller <= 64'b0;
			buffer_empty_r <= 1; // Initially empty
		end else begin
			// Empty condition: If synchronized wr_ptr equals current rd_ptr
			buffer_empty_r <= (wr_ptr_sync_r2 == rd_ptr);

			if (!buffer_empty_r) begin // Only read if not empty
				instr_to_controller <= queue[rd_ptr[ADDR_WIDTH - 1:0]]; // Use lower ADDR_WIDTH bits for memory access
				rd_ptr <= next_rd_ptr_val; // Update pointer
			end else begin
				instr_to_controller <= 64'b0; // Default output when empty
			end
		end
	end
endmodule
