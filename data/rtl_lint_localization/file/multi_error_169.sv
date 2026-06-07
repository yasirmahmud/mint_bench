module fsm_ctrl #(parameter WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   start,
    input  logic                   data_valid,
    input  logic                   timeout,
    input  logic                   abort,
    input  logic [WIDTH-1:0]       in_count,
    output logic                   ready,
    output logic                   busy,
    output logic                   done,
    output logic                   error_flag,
    output logic                   grant
);

    typedef enum logic [2:0] {
        S_IDLE  = 3'd0,
        S_LOAD  = 3'd1,
        S_EXEC  = 3'd2,
        S_WAIT  = 3'd3,
        S_DONE  = 3'd4,
        S_ERROR = 3'd5
    } state_t;

    state_t state;
    state_t next_state;

    logic [WIDTH-1:0] count;
    logic [WIDTH-1:0] thresh;

    logic [7:0] unused_debug;

    wire drive_a;
    wire drive_b;
    wire status_bus;

    assign drive_a = (state == S_IDLE) & start;
    assign drive_b = (state == S_EXEC) & data_valid;
    assign status_bus = drive_a;
    assign status_bus = drive_b;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state  <= S_IDLE;
            count  <= '0;
            thresh <= '0;
        end else begin
            state <= next_state;
            if (state == S_IDLE) begin
                if (start) begin
                    thresh <= in_count;
                end
                count <= '0;
            end else if (state == S_EXEC) begin
                if (data_valid) begin
                    count <= count + 1'b1;
                end
            end else if (state == S_DONE || state == S_ERROR) begin
                count <= '0;
            end
        end
    end

    always_comb begin
        next_state = state;
        ready      = 1'b0;
        busy       = 1'b0;
        done       = 1'b0;
        grant      = status_bus;
        case (state)
            S_IDLE: begin
                ready = 1'b1;
                if (start) begin
                    next_state = S_LOAD;
                end
            end
            S_LOAD: begin
                busy = 1'b1;
                if (abort) begin
                    next_state = S_ERROR;
                end else if (in_count == '0) begin
                    next_state = S_DONE;
                end else begin
                    next_state = S_EXEC;
                end
            end
            S_EXEC: begin
                busy = 1'b1;
                if (timeout) begin
                    next_state = S_WAIT;
                end else if (data_valid && (count + 1'b1 >= thresh)) begin
                    next_state = S_DONE;
                end
            end
            S_WAIT: begin
                busy = 1'b1;
                if (abort) begin
                    next_state = S_ERROR;
                end else if (timeout) begin
                    next_state = S_ERROR;
                end else if (data_valid) begin
                    next_state = S_EXEC;
                end
            end
            S_DONE: begin
                done  = 1'b1;
                ready = 1'b1;
                error_flag = 1'b0;
                next_state = S_IDLE;
            end
            S_ERROR: begin
                busy = 1'b0;
                error_flag = 1'b1;
                if (!start) begin
                    next_state = S_IDLE;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

endmodule