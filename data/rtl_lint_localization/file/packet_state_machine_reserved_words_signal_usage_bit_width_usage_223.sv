module packet_fsm (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [7:0]  data_in,
    output logic [7:0]  data_out,
    output logic        done
);

typedef enum logic [2:0] {S_IDLE, S_LOAD, S_PROC, S_WAIT, S_DONE} state_t;

state_t state, next_state;

localparam logic [7:0] LIMIT = 8'd5;

logic [7:0]  count, next_count;
logic [15:0] accum, next_accum;
logic [7:0]  buffer, next_buffer;
logic        busy, next_busy;

logic [15:0] wide_sum;

logic \always_comb ;

logic unused_flag;

assign done = (state == S_DONE);

assign data_out = wide_sum;

always_ff @(posedge clk or negedge rst_n)
begin
    if (!rst_n) begin
        state  <= S_IDLE;
        count  <= '0;
        accum  <= '0;
        buffer <= '0;
        busy   <= 1'b0;
    end else begin
        state  <= next_state;
        count  <= next_count;
        accum  <= next_accum;
        buffer <= next_buffer;
        busy   <= next_busy;
    end
end

always_comb
begin
    next_state  = state;
    next_count  = count;
    next_accum  = accum;
    next_buffer = buffer;
    next_busy   = busy;
    wide_sum    = accum;
    \always_comb = 1'b0;

    case (state)
        S_IDLE: begin
            next_busy = 1'b0;
            if (start) begin
                next_state  = S_LOAD;
                next_count  = 8'd0;
                next_busy   = 1'b1;
            end
        end
        S_LOAD: begin
            next_buffer = data_in;
            next_state  = S_PROC;
        end
        S_PROC: begin
            if (busy) begin
                \always_comb = 1'b1;
                if (\always_comb) begin
                    next_accum = accum + {8'd0, buffer};
                end
                next_count = count + 8'd1;
                if (count[2:0] == 3'd3) begin
                    next_state = S_WAIT;
                end
            end else begin
                next_state = S_IDLE;
            end
        end
        S_WAIT: begin
            wide_sum = accum + {8'd0, buffer};
            if (count < LIMIT) begin
                next_count = count + 8'd1;
            end else begin
                next_state = S_DONE;
            end
        end
        S_DONE: begin
            next_busy = 1'b0;
            if (start) begin
                next_state  = S_LOAD;
                next_buffer = data_in;
                next_count  = 8'd0;
                next_busy   = 1'b1;
            end else begin
                next_state = S_IDLE;
            end
        end
        default: begin
            next_state = S_IDLE;
        end
    endcase
end

endmodule