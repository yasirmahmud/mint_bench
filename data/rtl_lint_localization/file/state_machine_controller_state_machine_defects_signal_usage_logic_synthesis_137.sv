module fsm_controller #(
    parameter int WIDTH = 16
) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  start,
    input  logic                  thresh_en,
    input  logic [3:0]            wait_threshold,
    input  logic [WIDTH-1:0]      data_in,
    output logic                  valid,
    output logic                  busy,
    output logic [WIDTH-1:0]      result
);

typedef enum logic [2:0] {S_IDLE, S_LOAD, S_WAIT, S_EXEC, S_DONE, S_ERROR, S_RECOVER} state_e;
state_e state;
state_e next_state;

logic [WIDTH-1:0] acc;
logic [WIDTH-1:0] next_acc;
logic [WIDTH-1:0] data_q;
logic [3:0]       wait_cnt;
logic [3:0]       next_wait_cnt;

logic dbg_unused_flag;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state      <= S_IDLE;
        acc        <= '0;
        data_q     <= '0;
        wait_cnt   <= '0;
    end else begin
        state      <= next_state;
        acc        <= next_acc;
        wait_cnt   <= next_wait_cnt;
        if (start && state == S_IDLE) begin
            data_q <= data_in;
        end
    end
end

always_comb begin
    next_state     = state;
    next_acc       = acc;
    next_wait_cnt  = wait_cnt;

    case (state)
        S_IDLE: begin
            if (start) begin
                next_state    = S_LOAD;
                next_acc      = '0;
                next_wait_cnt = '0;
            end
        end
        S_LOAD: begin
            next_state    = S_WAIT;
            next_acc      = data_q;
            next_wait_cnt = '0;
        end
        S_WAIT: begin
            if (thresh_en) begin
                if (wait_cnt >= wait_threshold) begin
                    next_state = S_EXEC;
                end else begin
                    next_wait_cnt = wait_cnt + 4'd1;
                end
            end else begin
                next_state = S_EXEC;
            end
        end
        S_EXEC: begin
            next_acc   = acc + data_q;
            next_state = S_DONE;
        end
        S_DONE: begin
            next_state = S_IDLE;
        end
        S_ERROR: begin
            next_state = S_IDLE;
        end
        S_RECOVER: begin
            next_state = S_IDLE;
        end
        default: begin
            next_state = S_IDLE;
        end
    endcase
end

always_comb begin
    valid  = 1'b0;
    result = '0;
    if (state == S_DONE) begin
        valid  = 1'b1;
        result = acc;
    end
    if (state == S_EXEC) busy = 1'b1;
end

endmodule