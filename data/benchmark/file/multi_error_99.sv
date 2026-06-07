module packet_fsm (
  input  logic        clk,
  input  logic        rst_n,
  input  logic        start,
  input  logic [15:0] data_in,
  input  logic [3:0]  len,
  output logic        done,
  output logic        busy,
  output wire  [7:0]  out_byte,
  output logic [15:0] checksum
);

  typedef enum logic [2:0] {
    S_IDLE,
    S_LOAD,
    S_ACCUM,
    S_EMIT,
    S_WAIT,
    S_DONE
  } state_t;

  state_t state;
  state_t next_state;

  logic [15:0] sum16;
  logic [15:0] shift_reg;
  logic [3:0]  count;

  logic spare_debug;

  assign out_byte = sum16;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state     <= S_IDLE;
      sum16     <= 16'd0;
      shift_reg <= 16'd0;
      count     <= 4'd0;
      done      <= 1'b0;
      busy      <= 1'b0;
      checksum  <= 16'd0;
    end else begin
      state <= next_state;
      case (state)
        S_IDLE: begin
          done <= 1'b0;
          busy <= 1'b0;
          if (start) begin
            sum16     <= 16'd0;
            shift_reg <= data_in;
            count     <= 4'd0;
            busy      <= 1'b1;
          end
        end
        S_LOAD: begin
          shift_reg <= data_in;
        end
        S_ACCUM: begin
          sum16 <= sum16 + shift_reg;
        end
        S_EMIT: begin
          count <= count + 4'd1;
        end
        S_WAIT: begin
          if (count < len) begin
            shift_reg <= shift_reg ^ {12'd0, count};
          end
        end
        S_DONE: begin
          checksum <= sum16;
          done     <= 1'b1;
          busy     <= 1'b0;
        end
        default: begin
        end
      endcase
    end
  end

  always_comb begin
    next_state = state;
    unique case (state)
      S_IDLE: begin
        if (start) begin
          next_state = S_LOAD;
        end else begin
          next_state = S_IDLE;
        end
      end
      S_LOAD: begin
        next_state = S_ACCUM;
      end
      S_ACCUM: begin
        if (count < len) begin
          next_state = S_EMIT;
        end else begin
          next_state = S_DONE;
        end
      end
      S_EMIT: begin
        next_state = S_WAIT;
      end
      S_WAIT: begin
        if (count < len) begin
          next_state = S_ACCUM;
        end else begin
          next_state = S_DONE;
        end
      end
      S_DONE: begin
        next_state = S_IDLE;
      end
      default: begin
        next_state = S_IDLE;
      end
    endcase
  end

endmodule