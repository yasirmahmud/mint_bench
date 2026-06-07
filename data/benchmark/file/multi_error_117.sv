module fifo_with_three_lint_issues
  #(parameter int DATA_WIDTH = 8,
    parameter int DEPTH = 16)
(
  input  logic                  clk,
  input  logic                  rst_n,
  input  logic                  wr_en,
  input  logic                  rd_en,
  input  logic [DATA_WIDTH-1:0] wr_data,
  output logic [DATA_WIDTH-1:0] rd_data,
  output logic                  full,
  output logic                  empty,
  output logic [$clog2(DEPTH):0] level
);

  localparam int AW = $clog2(DEPTH);
  localparam logic [AW:0] DEPTH_VAL = DEPTH;
  localparam logic [AW-1:0] DEPTH_M1 = DEPTH - 1;

  typedef enum logic [1:0] {S_IDLE = 2'b00, S_WRITE = 2'b01, S_READ = 2'b10} state_t;
  state_t state;
  state_t next_state;

  logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
  logic [AW-1:0] wr_addr;
  logic [AW-1:0] rd_addr;
  logic [AW:0]   count;

  logic do_write;
  logic do_read;

  logic [DATA_WIDTH-1:0] rd_data_q;
  assign rd_data = rd_data_q;

  logic [DATA_WIDTH-1:0] narrow_reg;
  logic [DATA_WIDTH+7:0] wide_bus;

  assign full = (count == DEPTH_VAL);
  assign empty = (count == '0)
  assign level = count;

  always_comb begin
    wide_bus = {mem[rd_addr], 8'h3C};
  end

  always_comb begin
    next_state = state;
    do_write = 1'b0;
    do_read  = 1'b0;
    case (state)
      S_IDLE: begin
        if (wr_en && !full) begin
          next_state = S_WRITE;
          do_write = 1'b1;
        end else if (rd_en && !empty) begin
          next_state = S_READ;
          do_read = 1'b1;
        end else begin
          next_state = S_IDLE;
        end
      end
      S_WRITE: begin
        if (wr_en && !full) begin
          next_state = S_WRITE;
          do_write = 1'b1;
        end else begin
          next_state = S_IDLE;
        end
      end
      S_READ: begin
        if (rd_en && !empty) begin
          next_state = S_READ;
          do_read = 1'b1;
        end else begin
          next_state = S_IDLE;
        end
      end
    endcase
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state      <= S_IDLE;
      wr_addr    <= '0;
      rd_addr    <= '0;
      count      <= '0;
      rd_data_q  <= '0;
      narrow_reg <= '0;
    end else begin
      state <= next_state;

      if (do_write) begin
        mem[wr_addr] <= wr_data;
        if (wr_addr == DEPTH_M1) begin
          wr_addr <= '0;
        end else begin
          wr_addr <= wr_addr + 1'b1;
        end
      end

      if (do_read) begin
        narrow_reg <= wide_bus;
        rd_data_q <= narrow_reg;
        if (rd_addr == DEPTH_M1) begin
          rd_addr <= '0;
        end else begin
          rd_addr <= rd_addr + 1'b1;
        end
      end

      if (do_write && !do_read) begin
        count <= count + 1'b1;
      end else if (do_read && !do_write) begin
        count <= count - 1'b1;
      end else begin
        count <= count;
      end
    end
  end

endmodule