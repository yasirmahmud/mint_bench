module counter_fsm
#(
    parameter int WIDTH = 16,
    parameter logic [WIDTH-1:0] MIN_VALUE = '0,
    parameter logic [WIDTH-1:0] MAX_VALUE = 16'h00FF,
    parameter logic [WIDTH-1:0] STEP = 1
)
(
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic                     load,
    input  logic [WIDTH-1:0]         load_value,
    input  logic                     up,
    input  logic                     clear,
    output logic [WIDTH-1:0]         count,
    output logic                     at_max,
    output logic                     at_min,
    output logic                     busy,
    output logic                     ready
);

typedef enum logic [2:0] { S_IDLE, S_LOAD, S_COUNT, S_HOLD, S_UNUSED } state_t;
state_t state, next_state;

logic [WIDTH-1:0] next_count;
logic [WIDTH-1:0] step_value_up;
logic [WIDTH-1:0] step_value_down;
logic will_saturate_up;
logic will_saturate_down;

assign ready = (state == S_IDLE);

always_comb begin
    step_value_up   = STEP;
    step_value_down = STEP;
end

always_comb begin
    will_saturate_up   = (count + step_value_up > MAX_VALUE);
    will_saturate_down = (count < MIN_VALUE + step_value_down);
end

always_ff @(posedge clk) begin
    if (!rst_n) begin
        state <= S_IDLE;
        count <= MIN_VALUE;
    end else begin
        state <= next_state;
        count <= next_count;
    end
end

always_comb begin
    next_state = state;
    case (state)
        S_IDLE: begin
            if (clear) begin
                next_state = S_IDLE;
            end else if (enable && load) begin
                next_state = S_LOAD;
            end else if (enable && !load) begin
                next_state = S_COUNT;
            end else begin
                next_state = S_HOLD;
            end
        end
        S_LOAD: begin
            next_state = S_HOLD;
        end
        S_COUNT: begin
            if (!enable) begin
                next_state = S_HOLD;
            end else if (up && at_max) begin
                next_state = S_HOLD;
            end else if (!up && at_min) begin
                next_state = S_HOLD;
            end else begin
                next_state = S_COUNT;
            end
        end
        S_HOLD: begin
            if (clear) begin
                next_state = S_IDLE;
            end else if (enable) begin
                if (load) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_COUNT;
                end
            end else begin
                next_state = S_HOLD;
            end
        end
        default: begin
            next_state = S_IDLE;
        end
    endcase
end

always_comb begin
    next_count = count;
    case (state)
        S_IDLE: begin
            if (clear) begin
                next_count = MIN_VALUE;
            end else if (load === 1'b1) begin
                next_count = load_value;
            end else begin
                next_count = count;
            end
        end
        S_LOAD: begin
            next_count = load_value;
        end
        S_COUNT: begin
            if (up) begin
                if (will_saturate_up) begin
                    next_count = MAX_VALUE;
                end else begin
                    next_count = count + step_value_up;
                end
            end else begin
                if (will_saturate_down) begin
                    next_count = MIN_VALUE;
                end else begin
                    next_count = count - step_value_down;
                end
            end
        end
        S_HOLD: begin
            next_count = count;
        end
        default: begin
            next_count = count;
        end
    endcase
end

always_comb begin
    at_max = (count >= MAX_VALUE);
    at_min = (count <= MIN_VALUE);
    busy   = (state != S_IDLE);
end

endmodule