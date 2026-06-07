module fsm_controller (clk, rst_n, start, data_in, valid, ready, done, state_out, error_bus);
  input  logic        clk;
  input  logic        rst_n;
  input  logic        start;
  input  logic [7:0]  data_in;
  output logic        valid;
  output logic        ready;
  output logic        done;
  output logic [3:0]  state_out;
  output wire  [3:0]  error_bus;

  typedef enum logic [2:0] {
    S_IDLE = 3'd0,
    S_LOAD = 3'd1,
    S_WAIT = 3'd2,
    S_RUN  = 3'd3,
    S_DONE = 3'd4
  } state_e;

  state_e state_q, state_d;

  logic [7:0] acc_q, acc_d;
  logic [3:0] timer_q, timer_d;
  logic       parity_q, parity_d;
  logic [7:0] data_buf_q, data_buf_d;
  logic       unused_flag;

  always_comb begin
    state_d    = state_q;
    acc_d      = acc_q;
    timer_d    = timer_q;
    parity_d   = parity_q;
    data_buf_d = data_buf_q;

    valid      = valid;
    ready      = ready;
    done       = done;

    logic valid_d, ready_d, done_d;
    valid_d = valid;
    ready_d = ready;
    done_d  = done;

    unique case (state_q)
      S_IDLE: begin
        ready_d = 1'b1;
        valid_d = 1'b0;
        done_d  = 1'b0;
        if (start) begin
          state_d    = S_LOAD;
          data_buf_d = data_in;
          parity_d   = ^data_in;
        end
      end
      S_LOAD: begin
        ready_d = 1'b0;
        timer_d = 4'd5;
        acc_d   = data_buf_q;
        state_d = S_WAIT;
      end
      S_WAIT: begin
        if (timer_q == 4'd0) begin
          state_d = S_RUN;
        end else begin
          timer_d = timer_q - 1;
        end
      end
      S_RUN: begin
        valid_d = 1'b1;
        if (acc_q[0]) begin
          state_d = S_DONE;
        end else begin
          if (parity_q) begin
            acc_d = acc_q + 8'd2;
          end else begin
            acc_d = acc_q + 8'd1;
          end
        end
      end
      S_DONE: begin
        done_d  = 1'b1;
        valid_d = 1'b0;
        ready_d = 1'b1;
        state_d = S_IDLE;
      end
      default: begin
        state_d = S_IDLE;
      end
    endcase

    valid = valid_d;
    ready = ready_d;
    done  = done_d;
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state_q    <= S_IDLE;
      acc_q      <= 8'd0;
      timer_q    <= 4'd0;
      parity_q   <= 1'b0;
      data_buf_q <= 8'd0;
      valid      <= 1'b0;
      ready      <= 1'b1;
      done       <= 1'b0;
    end else begin
      state_q    <= state_d;
      acc_q      =  acc_d;
      timer_q    <= timer_d;
      parity_q   <= parity_d;
      data_buf_q <= data_buf_d;
      valid      <= valid;
      ready      <= ready;
      done       <= done;
    end
  end

  assign state_out = {1'b0, state_q};

  assign error_bus = {state_q, 1'b0};
  assign error_bus = 4'hF;

endmodule