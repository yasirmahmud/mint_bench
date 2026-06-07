module day19 #(
  parameter DEPTH   = 4,
  parameter DATA_W  = 1
)(
  input         wire              clk,
  input         wire              reset,
  input         wire              push_i,
  input         wire[DATA_W-1:0]  push_data_i,
  input         wire              pop_i,
  output reg    [DATA_W-1:0]      pop_data_o,
  output reg                      full_o,
  output reg                      empty_o
);

  // Calculate address width based on depth
  localparam ADDR_W = $clog2(DEPTH);

  // FIFO memory
  reg [DATA_W-1:0] fifo_mem[0:DEPTH-1];

  // Read and write pointers
  reg [ADDR_W-1:0] rd_ptr;
  reg [ADDR_W-1:0] wr_ptr;

  // FIFO count
  reg [ADDR_W:0] fifo_count;

  // Intermediate signals for next state logic (to avoid multiple assignments)
  reg [ADDR_W-1:0] next_rd_ptr;
  reg [ADDR_W-1:0] next_wr_ptr;
  reg [ADDR_W:0]   next_fifo_count;
  reg [DATA_W-1:0] next_pop_data_o;

  // Control signals derived combinatorially
  reg push_en;
  reg pop_en;

  // Combinational logic for full, empty, and enable signals
  always @(*) begin
    full_o  = (fifo_count == DEPTH);
    empty_o = (fifo_count == 0);

    push_en = push_i && !full_o;
    pop_en  = pop_i && !empty_o;
  end

  // Sequential logic for pointers, count, and pop_data_o (with asynchronous reset)
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      rd_ptr     <= {ADDR_W{1'b0}}; // Reset to 0
      wr_ptr     <= {ADDR_W{1'b0}}; // Reset to 0
      fifo_count <= {ADDR_W+1{1'b0}}; // Reset to 0
      pop_data_o <= {DATA_W{1'b0}}; // Reset to 0
    end
    else begin
      // Default next values to current values (no change if no operation)
      next_rd_ptr     = rd_ptr;
      next_wr_ptr     = wr_ptr;
      next_fifo_count = fifo_count;
      next_pop_data_o = pop_data_o; // Keep current output if no pop

      if (push_en && !pop_en) begin // Push only
        next_wr_ptr     = wr_ptr + 1;
        next_fifo_count = fifo_count + 1;
      end else if (!push_en && pop_en) begin // Pop only
        next_rd_ptr     = rd_ptr + 1;
        next_fifo_count = fifo_count - 1;
        next_pop_data_o = fifo_mem[rd_ptr]; // Read data from memory for output
      end else if (push_en && pop_en) begin // Push and Pop simultaneously
        next_wr_ptr     = wr_ptr + 1;
        next_rd_ptr     = rd_ptr + 1;
        // fifo_count remains unchanged in this case
        next_pop_data_o = fifo_mem[rd_ptr]; // Read data from memory for output
      end
      // else (neither push nor pop) next_ values remain current values as defaulted above

      // Apply updates to registers
      rd_ptr     <= next_rd_ptr;
      wr_ptr     <= next_wr_ptr;
      fifo_count <= next_fifo_count;
      pop_data_o <= next_pop_data_o;
    end
  end

  // Sequential logic for FIFO memory writes (purely synchronous)
  // This separate block resolves the asynchronous reset violation for fifo_mem.
  always @(posedge clk) begin
    if (push_en) begin
      fifo_mem[wr_ptr] <= push_data_i;
    end
  end

endmodule
