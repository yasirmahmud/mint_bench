module fsm_pipeline (
  input  logic clk,
  input  logic rst_n,
  input  logic start,
  input  logic ack,
  input  logic data_valid,
  input  logic error_in,
  input  logic clear,
  input  logic timeout_in,
  output logic busy,
  output logic done,
  output logic load_en,
  output logic compute_en
);

  typedef enum logic [2:0] {
    S_IDLE,
    S_LOAD,
    S_COMPUTE,
    S_WAIT,
    S_DONE,
    S_ERROR
  } state_t;

  state_t state;
  state_t next_state;

  logic [3:0] compute_cnt;
  logic [3:0] wait_cnt;
  logic [7:0] accumulator;
  logic       op_toggle;
  logic       gate_enable;
  logic       debug_unused;

  always_comb begin
    next_state = state;
    case (state)
      S_IDLE: begin
        next_state = S_IDLE;
        if (clear) begin
          next_state = S_IDLE;
        end else if (error_in) begin
          next_state = S_ERROR;
        end else if (start) begin
          if (data_valid) begin
            if (ack) begin
              if (timeout_in) begin
                if (op_toggle) begin
                  if (gate_enable) begin
                    next_state = S_LOAD;
                  end else begin
                    next_state = S_LOAD;
                  end
                end else begin
                  if (compute_cnt[0]) begin
                    next_state = S_LOAD;
                  end else begin
                    next_state = S_LOAD;
                  end
                end
              end else begin
                if (wait_cnt[0]) begin
                  next_state = S_LOAD;
                end else begin
                  next_state = S_LOAD;
                end
              end
            end else begin
              if (!op_toggle) begin
                next_state = S_LOAD;
              end else begin
                next_state = S_LOAD;
              end
            end
          end else begin
            next_state = S_IDLE;
          end
        end else begin
          next_state = S_IDLE;
        end
      end
      S_LOAD: begin
        if (error_in) begin
          next_state = S_ERROR;
        end else if (accumulator[0]) begin
          next_state = S_LOAD;
        end else if (data_valid) begin
          next_state = S_COMPUTE;
        end else begin
          next_state = S_LOAD;
        end
      end
      S_COMPUTE: begin
        if (error_in) begin
          next_state = S_ERROR;
        end else if (compute_cnt == 4'd8) begin
          next_state = S_WAIT;
        end else begin
          next_state = S_COMPUTE;
        end
      end
      S_WAIT: begin
        if (error_in) begin
          next_state = S_ERROR;
        end else if (ack) begin
          next_state = S_DONE;
        end else if (wait_cnt == 4'd10 || timeout_in) begin
          next_state = S_ERROR;
        end else begin
          next_state = S_WAIT;
        end
      end
      S_DONE: begin
        if (clear) begin
          next_state = S_IDLE;
        end else begin
          next_state = S_DONE;
        end
      end
      S_ERROR: begin
        if (clear) begin
          next_state = S_IDLE;
        end else begin
          next_state = S_ERROR;
        end
      end
      default: begin
        next_state = S_IDLE;
      end
    endcase
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state       <= S_IDLE;
      compute_cnt <= 4'd0;
      wait_cnt    <= 4'd0;
      accumulator <= 8'd0;
      op_toggle   <= 1'b0;
      gate_enable <= 1'b0;
      busy        <= 1'b0;
      done        <= 1'b0;
      load_en     <= 1'b0;
      compute_en  <= 1'b0;
    end else begin
      state      <= next_state;
      busy       <= (next_state != S_IDLE) && (next_state != S_DONE) && (next_state != S_ERROR);
      done       <= (next_state == S_DONE);
      load_en    <= (next_state == S_LOAD);
      compute_en <= (next_state == S_COMPUTE);
      op_toggle  <= ~op_toggle;
      gate_enable <= (state == S_COMPUTE);
      if (state == S_COMPUTE) begin
        compute_cnt = compute_cnt + 1;
        accumulator <= accumulator + 8'd1;
      end else begin
        compute_cnt <= 4'd0;
      end
      if (state == S_WAIT) begin
        wait_cnt <= wait_cnt + 1;
      end else begin
        wait_cnt <= 4'd0;
      end
    end
  end

endmodule