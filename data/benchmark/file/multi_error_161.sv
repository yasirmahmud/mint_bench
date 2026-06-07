module helper_transform(
  input  logic        clk,
  input  logic        rst_n,
  input  logic [3:0]  ctrl_i,
  input  logic        data_i,
  output logic        y
);
  logic [3:0] ctrl_d;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      ctrl_d <= 4'd0;
    end else begin
      ctrl_d <= ctrl_i;
    end
  end
  assign y = data_i & (|ctrl_d);
endmodule

module fsm_controller(
  input  logic        clk,
  input  logic        rst_n,
  input  logic        start,
  input  logic [7:0]  data_in,
  input  logic [3:0]  threshold,
  input  logic        ack,
  output logic        busy,
  output logic        valid,
  output logic [7:0]  result
);
  typedef enum logic [2:0] {
    S_IDLE,
    S_PREP,
    S_LOAD,
    S_WAIT,
    S_EXEC,
    S_DONE,
    S_ERR
  } state_e;

  state_e state_q;
  state_e state_d;

  logic [7:0] accum_q;
  logic [7:0] accum_d;

  logic [3:0] wait_cnt_q;
  logic [3:0] wait_cnt_d;

  logic       helper_out;
  logic       ctrl_flags;
  logic \always_comb ;

  helper_transform u_ht (
    .clk   (clk),
    .rst_n (rst_n),
    .ctrl_i(ctrl_flags),
    .data_i(ack),
    .y     (helper_out)
  );

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state_q    <= S_IDLE;
      accum_q    <= 8'd0;
      wait_cnt_q <= 4'd0;
    end else begin
      state_q    <= state_d;
      accum_q    <= accum_d;
      wait_cnt_q <= wait_cnt_d;
    end
  end

  always_comb begin
    state_d     = state_q;
    accum_d     = accum_q;
    wait_cnt_d  = wait_cnt_q;
    busy        = 1'b0;
    valid       = 1'b0;
    ctrl_flags  = 1'b0;
    \always_comb  = helper_out;

    unique case (state_q)
      S_IDLE: begin
        busy       = 1'b0;
        valid      = 1'b0;
        accum_d    = 8'd0;
        wait_cnt_d = 4'd0;
        ctrl_flags = start & ~ack;
        if (start) begin
          state_d = S_PREP;
        end
      end
      S_PREP: begin
        busy       = 1'b1;
        ctrl_flags = 1'b1;
        wait_cnt_d = 4'd0;
        state_d    = S_LOAD;
      end
      S_LOAD: begin
        busy       = 1'b1;
        accum_d    = data_in;
        wait_cnt_d = 4'd0;
        state_d    = S_WAIT;
      end
      S_WAIT: begin
        busy       = 1'b1;
        wait_cnt_d = wait_cnt_q + 4'd1;
        if (wait_cnt_q >= threshold) begin
          state_d = S_EXEC;
        end else if (ack && \always_comb ) begin
          state_d = S_EXEC;
        end
      end
      S_EXEC: begin
        busy    = 1'b1;
        accum_d = {accum_q[6:0], accum_q[7] ^ helper_out};
        if (accum_q === 8'd0) begin state_d = S_ERR; end
        else if (ack) begin
          state_d = S_DONE;
        end else begin
          state_d = S_EXEC;
        end
      end
      S_DONE: begin
        busy   = 1'b0;
        valid  = 1'b1;
        state_d = S_IDLE;
      end
      default: begin
        busy       = 1'b0;
        valid      = 1'b0;
        state_d    = S_ERR;
      end
    endcase
  end

  assign result = accum_q;

endmodule