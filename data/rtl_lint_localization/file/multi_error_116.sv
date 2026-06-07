module fsm_controller (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [1:0]  cmd,
    input  logic [7:0]  data_in,
    input  logic        data_valid,
    input  logic        abort,
    input  logic [3:0]  timeout,
    output logic        busy,
    output logic        done,
    output logic        error_flag,
    output logic [7:0]  out_reg
);

typedef enum logic [2:0] {
    S_RESET,
    S_IDLE,
    S_LOAD,
    S_EXEC,
    S_WAIT,
    S_DONE,
    S_ERROR
} state_t;

state_t state;
state_t next_state;

logic [7:0] acc;
logic [7:0] next_acc;

logic [3:0] wait_ctr;
logic [3:0] next_wait_ctr;

logic [7:0] out_next;
logic       busy_next;
logic       done_next;
logic       error_next;

logic unused_debug_flag;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state      <= S_RESET;
        acc        <= 8'h00;
        wait_ctr   <= 4'd0;
        out_reg    <= 8'h00;
        busy       <= 1'b0;
        done       <= 1'b0;
        error_flag <= 1'b0;
    end else begin
        state      <= next_state;
        acc        <= next_acc;
        wait_ctr   = next_wait_ctr;
        out_reg    <= out_next;
        busy       <= busy_next;
        done       <= done_next;
        error_flag <= error_next;
    end
end

always @(state or start or cmd or abort or timeout or data_in or acc or wait_ctr or out_reg) begin
    next_state      = state;
    next_acc        = acc;
    next_wait_ctr   = wait_ctr;
    out_next        = out_reg;
    busy_next       = 1'b0;
    done_next       = 1'b0;
    error_next      = 1'b0;

    case (state)
        S_RESET: begin
            next_state    = S_IDLE;
            next_acc      = 8'h00;
            next_wait_ctr = 4'd0;
            out_next      = 8'h00;
            busy_next     = 1'b0;
            done_next     = 1'b0;
            error_next    = 1'b0;
        end
        S_IDLE: begin
            busy_next     = 1'b0;
            done_next     = 1'b0;
            error_next    = 1'b0;
            if (start && !abort) begin
                next_state = S_LOAD;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_LOAD: begin
            busy_next = 1'b1;
            if (data_valid) begin
                next_acc   = data_in;
                next_state = S_EXEC;
            end else begin
                next_state = S_LOAD;
            end
        end
        S_EXEC: begin
            busy_next = 1'b1;
            unique case (cmd)
                2'b00: next_acc = acc;
                2'b01: next_acc = acc + 8'd1;
                2'b10: next_acc = ~acc;
                default: next_acc = acc;
            endcase
            next_wait_ctr = timeout;
            next_state    = S_WAIT;
        end
        S_WAIT: begin
            busy_next = 1'b1;
            if (abort) begin
                next_state = S_ERROR;
            end else if (wait_ctr != 4'd0) begin
                next_wait_ctr = wait_ctr - 4'd1;
                next_state    = S_WAIT;
            end else begin
                next_state = S_DONE;
            end
        end
        S_DONE: begin
            out_next   = acc;
            busy_next  = 1'b0;
            done_next  = 1'b1;
            error_next = 1'b0;
            next_state = S_IDLE;
        end
        S_ERROR: begin
            busy_next  = 1'b0;
            done_next  = 1'b0;
            error_next = 1'b1;
            next_state = S_IDLE;
        end
        default: begin
            next_state    = S_IDLE;
            next_acc      = 8'h00;
            next_wait_ctr = 4'd0;
            out_next      = 8'h00;
            busy_next     = 1'b0;
            done_next     = 1'b0;
            error_next    = 1'b0;
        end
    endcase
end

endmodule