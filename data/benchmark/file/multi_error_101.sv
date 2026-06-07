module fsm_control_unit (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        in_valid,
    input  logic [15:0] data_in,
    output logic        ready,
    output logic [7:0]  data_out,
    output logic        done
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_WAIT,
        S_RUN,
        S_DONE,
        S_ERR
    } state_t;

    state_t state;
    state_t next_state;

    logic [15:0] accum;
    logic [3:0]  step_cnt;
    logic [7:0]  shift_reg;
    logic        enable_add;
    logic [7:0]  mask8;
    logic [15:0] mask16;
    logic [7:0]  \logic ;

    assign mask16 = {mask8, mask8};
    assign data_out = accum;

    always_comb begin
        mask8 = 8'h00;
        enable_add = 1'b0;
        case (state)
            S_IDLE: begin
                mask8 = 8'h55;
                enable_add = 1'b0;
            end
            S_LOAD: begin
                mask8 = data_in[15:8] ^ data_in[7:0];
                enable_add = 1'b1;
            end
            S_WAIT: begin
                mask8 = shift_reg;
                enable_add = 1'b1;
            end
            S_RUN: begin
                mask8 = \logic ;
                enable_add = 1'b1;
            end
            S_DONE: begin
                mask8 = 8'hA5;
                enable_add = 1'b0;
            end
            default: begin
                mask8 = 8'h00;
                enable_add = 1'b0;
            end
        endcase
    end

    always @(state or in_valid) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (in_valid) next_state = S_LOAD;
                else next_state = S_IDLE;
            end
            S_LOAD: begin
                if (in_valid && data_in[0]) next_state = S_RUN;
                else next_state = S_WAIT;
            end
            S_WAIT: begin
                if (!in_valid) next_state = S_RUN;
            end
            S_RUN: begin
                next_state = S_DONE;
            end
            S_DONE: begin
                if (!in_valid) next_state = S_IDLE;
            end
            default: next_state = S_IDLE;
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
            accum <= 16'h0000;
            step_cnt <= 4'd0;
            shift_reg <= 8'h00;
            ready <= 1'b0;
            done <= 1'b0;
            \logic  <= 8'h00;
        end else begin
            state <= next_state;
            case (state)
                S_IDLE: begin
                    ready <= 1'b1;
                    done <= 1'b0;
                    step_cnt <= 4'd0;
                end
                S_LOAD: begin
                    ready <= 1'b0;
                    done <= 1'b0;
                    accum <= data_in;
                    shift_reg <= data_in[7:0];
                    \logic  <= data_in[7:0];
                    step_cnt <= step_cnt + 1'b1;
                end
                S_WAIT: begin
                    ready <= 1'b0;
                    done <= 1'b0;
                    accum <= accum + {8'h00, mask8};
                    shift_reg <= {shift_reg[6:0], in_valid};
                    step_cnt <= step_cnt + 1'b1;
                end
                S_RUN: begin
                    ready <= 1'b0;
                    done <= 1'b0;
                    if (enable_add) accum <= accum + mask16;
                    else accum <= accum;
                    step_cnt <= step_cnt + 1'b1;
                end
                S_DONE: begin
                    ready <= 1'b1;
                    done <= 1'b1;
                end
                default: begin
                    ready <= 1'b0;
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule