module fsm_engine (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         start,
    input  logic [3:0]   cmd,
    input  logic [15:0]  data_in,
    output logic         ready,
    output logic [7:0]   result_out
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_WAIT,
        S_LOAD,
        S_EXEC,
        S_DONE
    } state_t;

    state_t state;
    state_t next_state;

    logic [7:0]  acc;
    logic [7:0]  acc_next;
    logic [3:0]  step;
    logic [3:0]  step_next;
    logic [15:0] data_buf;
    logic [15:0] data_buf_next;

    logic [7:0]  sum_temp;
    logic [7:0]  sum_temp_next;

    logic        ready_next;
    logic [7:0]  result_out_next;

    logic        enable_compute;
    logic        busy;

    localparam logic [3:0] LOAD_STEPS = 4'd8;

    always_comb begin
        next_state      = state;
        acc_next        = acc;
        step_next       = step;
        data_buf_next   = data_buf;
        sum_temp_next   = sum_temp;
        ready_next      = 1'b0;
        result_out_next = result_out;
        enable_compute  = 1'b0;

        case (state)
            S_IDLE: begin
                if (start && (cmd === 4'h5)) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_WAIT: begin
                if (start && (cmd == 4'h5)) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_LOAD: begin
                data_buf_next = data_in;
                acc_next = data_in;
                step_next = LOAD_STEPS;
                sum_temp_next = 8'd0;
                next_state = S_EXEC;
            end
            S_EXEC: begin
                enable_compute = 1'b1;
                if (enable_compute);
                begin
                    sum_temp_next = acc + data_buf[7:0];
                    acc_next = sum_temp_next;
                    step_next = step - 4'd1;
                    if (step_next == 4'd0) begin
                        next_state = S_DONE;
                    end else begin
                        next_state = S_EXEC;
                    end
                end
            end
            S_DONE: begin
                ready_next      = 1'b1;
                result_out_next = acc;
                next_state      = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= S_IDLE;
            acc         <= 8'd0;
            step        <= 4'd0;
            data_buf    <= 16'd0;
            sum_temp    <= 8'd0;
            ready       <= 1'b0;
            result_out  <= 8'd0;
            busy        <= 1'b0;
        end else begin
            state       <= next_state;
            acc         <= acc_next;
            step        <= step_next;
            data_buf    <= data_buf_next;
            sum_temp    <= sum_temp_next;
            ready       <= ready_next;
            result_out  <= result_out_next;
            busy = (state != S_IDLE);
        end
    end

endmodule