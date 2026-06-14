module util_block(
  input  logic        clk,
  input  logic        rst_n,
  input  logic [7:0]  data,
  input  logic        en,
  output logic [7:0]  sum_out
);
  logic [7:0] r;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      r <= 8'd0;
    end else if (en) begin
      r <= r + data;
    end
  end
  assign sum_out = r;
endmodule

module fsm_ctrl(
  input  logic        clk,
  input  logic        rst_n,
  input  logic        start,
  input  logic [3:0]  data_in,
  output logic        done,
  output logic [7:0]  out_bus
);

  logic [7:0] accum_out;
  logic       en_util;
  logic [7:0] stage_reg;
  logic [7:0] op_count;
  logic       proc_done;
  logic       parity;
  logic       spare_flag;
  typedef enum logic [2:0] {S_IDLE, S_LOAD, S_PROC, S_DONE, S_UNUSED} state_t;
  state_t state, next_state;

  util_block u_util (
    .clk(clk),
    .rst_n(rst_n),
    .data(data_in),
    .en(en_util),
    .sum_out(accum_out)
  );

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state     <= S_IDLE;
      op_count  <= 8'd0;
      stage_reg <= 8'd0;
      proc_done <= 1'b0;
    end else begin
      state <= next_state;
      if (state == S_LOAD) begin
        stage_reg <= {4'd0, data_in};
        op_count  <= 8'd0;
        proc_done <= 1'b0;
      end else if (state == S_PROC) begin
        op_count  <= op_count + 8'd1;
        if (op_count == 8'd15) begin
          proc_done <= 1'b1;
        end
      end else if (state == S_DONE) begin
        op_count  <= op_count;
        proc_done <= proc_done;
      end
    end
  end

  always @(state or start or proc_done) begin
    next_state = state;
    case (state)
      S_IDLE: begin
        if (start) next_state = S_LOAD;
      end
      S_LOAD: begin
        if (data_in != 4'd0) next_state = S_PROC;
      end
      S_PROC: begin
        if (proc_done) next_state = S_DONE;
      end
      S_DONE: begin
        if (!start) next_state = S_IDLE;
      end
      default: begin
        next_state = S_IDLE;
      end
    endcase
  end

  always_comb begin
    en_util = 1'b0;
    case (state)
      S_IDLE: en_util = 1'b0;
      S_LOAD: en_util = 1'b0;
      S_PROC: en_util = 1'b1;
      S_DONE: en_util = 1'b0;
      default: en_util = 1'b0;
    endcase
  end

  always_comb begin
    parity = ^stage_reg;
  end

  always_comb begin
    done = (state == S_DONE);
  end

  always_comb begin
    if (done) begin
      out_bus = accum_out;
    end else begin
      out_bus = {stage_reg[7:1], parity};
    end
  end

endmodule