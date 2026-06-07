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

  // Combinational logic for full and empty signals
  always @(*) begin
    full_o  = (fifo_count == DEPTH);
    empty_o = (fifo_count == 0);
  end

  // Sequential logic for FIFO operations
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset pointers and count
      rd_ptr     <= 0;
      wr_ptr     <= 0;
      fifo_count <= 0;
      pop_data_o <= 0;
    end 
    else begin
      // Push data into the FIFO
      if (push_i && !full_o) begin
        fifo_mem[wr_ptr] <= push_data_i;
        wr_ptr           <= wr_ptr + 1;
        fifo_count       <= fifo_count + 1;
      end

      // Pop data from the FIFO
      if (pop_i && !empty_o) begin
        pop_data_o <= fifo_mem[rd_ptr];
        rd_ptr     <= rd_ptr + 1;
        fifo_count <= fifo_count - 1;
      end
    end
  end

endmodule
