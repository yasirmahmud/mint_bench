module decoder_fsm #(parameter int IN_WIDTH = 4, parameter int OUT_WIDTH = 16, parameter int HOLD_MAX = 3) (
    input  logic                       clk,
    input  logic                       rst_n,
    input  logic                       enable,
    input  logic [IN_WIDTH-1:0]        addr,
    output logic [OUT_WIDTH-1:0]       decode,
    output logic                       valid,
    output logic                       busy
);

typedef enum logic [2:0] { S_IDLE, S_LATCH, S_DECODE, S_HOLD, S_ERR } state_e;
state_e state, next_state;

logic [IN_WIDTH-1:0] latched_addr;
logic [OUT_WIDTH-1:0] decode_next;
logic                valid_next;
logic                busy_next;
logic                kick_decode;
logic [3:0]          activity_cnt;
logic [$clog2(HOLD_MAX+1)-1:0] hold_cnt;
logic [3:0]          dbg_tap

function automatic logic [OUT_WIDTH-1:0] onehot(input logic [IN_WIDTH-1:0] index);
    logic [OUT_WIDTH-1:0] base;
    begin
        base = '0;
        base[0] = 1'b1;
        onehot = base << index;
    end
endfunction

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state         <= S_IDLE;
        latched_addr  <= '0;
        decode        <= '0;
        valid         <= 1'b0;
        busy          <= 1'b0;
        activity_cnt  <= '0;
        hold_cnt      <= '0;
    end else begin
        state         <= next_state;
        latched_addr  <= kick_decode ? addr : latched_addr;
        decode        <= decode_next;
        valid         <= valid_next;
        busy          <= busy_next;
        activity_cnt  <= valid_next ? activity_cnt + 1'b1 : activity_cnt;
        if (next_state == S_HOLD) begin
            if (hold_cnt < HOLD_MAX) begin
                hold_cnt <= hold_cnt + 1'b1;
            end else begin
                hold_cnt <= hold_cnt;
            end
        end else begin
            hold_cnt <= '0;
        end
    end
end

always_comb begin
    next_state  = state;
    kick_decode = 1'b0;
    valid_next  = 1'b0;
    busy_next   = (state != S_IDLE);
    decode_next = decode;

    case (state)
        S_IDLE: begin
            if (enable) begin
                next_state = S_LATCH;
            end
        end
        S_LATCH: begin
            kick_decode = 1'b1;
            next_state  = S_DECODE;
            busy_next   = 1'b1;
        end
        S_DECODE: begin
            valid_next  = 1'b1;
            busy_next   = 1'b1;
            if (HOLD_MAX > 0) begin
                next_state = S_HOLD;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_HOLD: begin
            busy_next  = 1'b1;
            valid_next = (hold_cnt < HOLD_MAX);
            if (!enable && hold_cnt >= HOLD_MAX) begin
                next_state = S_IDLE;
            end else begin
                next_state = S_HOLD;
            end
        end
        default: begin
            next_state = S_IDLE;
        end
    endcase

    if (kick_decode) begin
        decode_next = onehot(addr);
    end else if (state == S_DECODE || state == S_HOLD) begin
        decode_next = onehot(latched_addr);
    end else begin
        decode_next = '0;
    end
end

endmodule