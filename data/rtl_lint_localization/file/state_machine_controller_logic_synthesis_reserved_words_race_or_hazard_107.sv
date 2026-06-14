module fsm_controller #(parameter int WIDTH = 8, parameter int STEPS = 5) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   start,
    input  logic [WIDTH-1:0]       data_in,
    output logic                   done,
    output logic                   busy,
    output logic [WIDTH-1:0]       data_out,
    output logic                   heartbeat
);

    typedef enum logic [2:0] {S_RESET, S_IDLE, S_LOAD, S_EXEC, S_WAIT, S_DONE} state_t;

    state_t state, nxt_state;

    logic [WIDTH-1:0] acc, acc_next;
    logic [3:0]       step, step_next;
    logic [WIDTH-1:0] temp_calc;
    logic             toggle;

    logic \always_comb ;
    logic [7:0] debug_shadow;

    assign heartbeat = toggle;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= S_RESET;
            acc      <= '0;
            step     <= '0;
            data_out <= '0;
            toggle   <= 1'b0;
            \always_comb <= 1'b0;
        end else begin
            state    <= nxt_state;
            acc      <= acc_next;
            step     <= step_next;
            data_out <= acc_next;
            \always_comb <= start;
            toggle = ~toggle;
        end
    end

    always_comb begin
        nxt_state = state;
        acc_next  = acc;
        step_next = step;
        done      = 1'b0;
        temp_calc = (\always_comb ) ? (data_in ^ acc) : (data_in + acc);
        case (state)
            S_RESET: begin
                nxt_state = S_IDLE;
                acc_next  = '0;
                step_next = '0;
                done      = 1'b0;
                busy      = 1'b0;
            end
            S_IDLE: begin
                acc_next  = acc;
                step_next = '0;
                if (start) begin
                    nxt_state = S_LOAD;
                    busy      = 1'b1;
                    done      = 1'b0;
                end else begin
                    nxt_state = S_IDLE;
                    done      = 1'b0;
                end
            end
            S_LOAD: begin
                acc_next  = data_in;
                if (data_in[0]) begin
                    nxt_state = S_EXEC;
                end else begin
                    nxt_state = S_WAIT;
                end
                busy      = 1'b1;
            end
            S_EXEC: begin
                acc_next = temp_calc + step;
                if (step == STEPS[3:0]) begin
                    nxt_state = S_DONE;
                    step_next = '0;
                    busy      = 1'b1;
                end else begin
                    step_next = step + 1;
                    nxt_state = S_EXEC;
                    busy      = 1'b1;
                end
            end
            S_WAIT: begin
                nxt_state = S_DONE;
                busy      = 1'b1;
            end
            S_DONE: begin
                done      = 1'b1;
                busy      = 1'b0;
                nxt_state = S_IDLE;
            end
            default: begin
                nxt_state = S_RESET;
                busy      = 1'b0;
                done      = 1'b0;
            end
        endcase
    end

endmodule