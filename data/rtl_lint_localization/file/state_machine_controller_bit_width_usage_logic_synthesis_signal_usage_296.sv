module fsm_controller(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic        stop,
    input  logic        ack,
    input  logic [15:0] data_in,
    output logic        done,
    output logic        busy,
    output logic        alert,
    output logic [7:0]  data_out
);

    typedef enum logic [1:0] {S_IDLE, S_LOAD, S_RUN, S_WAIT} state_t;

    state_t state;
    state_t next_state;

    logic [7:0] small_reg;
    assign small_reg = data_in;

    logic [7:0] accum;
    logic [3:0] wait_cnt;
    logic       gate;
    logic       threshold_met;
    logic       reserved_flag;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= S_IDLE;
        end else begin
            state    <= next_state;
        end
    end

    always @(start or stop) begin
        if (stop) begin
            gate = 1'b0;
        end else begin
            gate = start & ack;
        end
    end

    always_comb begin
        threshold_met = 1'b0;
        if (accum > small_reg) begin
            threshold_met = 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            accum    <= 8'h00;
            wait_cnt <= 4'h0;
            data_out <= 8'h00;
        end else begin
            case (state)
                S_IDLE: begin
                    wait_cnt <= 4'h0;
                end
                S_LOAD: begin
                    accum    <= small_reg;
                    data_out <= small_reg;
                end
                S_RUN: begin
                    accum    <= accum + small_reg;
                    data_out <= accum;
                end
                S_WAIT: begin
                    wait_cnt <= wait_cnt + 1'b1;
                end
                default: begin
                    accum    <= accum;
                    wait_cnt <= wait_cnt;
                    data_out <= data_out;
                end
            endcase
        end
    end

    always_comb begin
        next_state = state;
        done       = 1'b0;
        busy       = 1'b0;
        case (state)
            S_IDLE: begin
                if (start || gate) begin
                    next_state = S_LOAD;
                    alert = 1'b1;
                end
            end
            S_LOAD: begin
                busy = 1'b1;
                if (ack) begin
                    next_state = S_RUN;
                end
            end
            S_RUN: begin
                busy = 1'b1;
                if (stop) begin
                    next_state = S_WAIT;
                end else if (threshold_met) begin
                    next_state = S_WAIT;
                end
            end
            S_WAIT: begin
                if (ack) begin
                    done       = 1'b1;
                    next_state = S_IDLE;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

endmodule