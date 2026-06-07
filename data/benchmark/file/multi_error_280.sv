module fsm_heavy #(parameter DATA_W = 16) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              start,
    input  logic [DATA_W-1:0] data_in,
    input  logic [15:0]       cfg_thresh,
    input  logic [7:0]        cfg_scale,
    output logic              busy,
    output logic              done,
    output logic [31:0]       result,
    output logic [2:0]        state_debug
);

typedef enum logic [2:0] {
    S_IDLE,
    S_LOAD,
    S_ACCUM,
    S_CALC,
    S_FINALIZE,
    S_ERR
} state_t;

state_t state, next_state;
logic [31:0] sum, next_sum;
logic [7:0]  count, next_count;
logic [31:0] next_result;
logic        next_done, next_busy;
logic [2:0]  shadow;
logic [31:0] data_ext;
logic [8:0]  safe_divisor;
logic        guard_saturated;

assign data_ext    = {16'b0, data_in};
assign safe_divisor = {1'b0, cfg_thresh[7:0]} + 9'd1;
assign guard_saturated = |sum[31:16];

always_comb begin
    next_state  = state;
    next_sum    = sum;
    next_count  = count;
    next_result = result;
    next_done   = 1'b0;
    next_busy   = busy;

    unique case (state)
        S_IDLE: begin
            next_busy = 1'b0;
            if (start) begin
                next_state = S_LOAD;
                next_done  = 1'b0;
            end
        end
        S_LOAD: begin
            next_busy   = 1'b1;
            next_sum    = data_ext;
            next_count  = 8'd1;
            next_state  = S_ACCUM;
        end
        S_ACCUM: begin
            next_busy = 1'b1;
            if (guard_saturated) begin
                next_state = S_ERR;
                next_result = sum;
            end else if (count < cfg_thresh[7:0]) begin
                next_sum   = sum + data_ext;
                next_count = count + 8'd1;
                next_state = S_ACCUM;
            end else begin
                next_state = S_CALC;
            end
        end
        S_CALC: begin
            next_busy   = 1'b1;
            next_result = (sum << cfg_scale[3:0]) / safe_divisor;
            next_state  = S_FINALIZE;
        end
        S_FINALIZE: begin
            next_busy  = 1'b0;
            next_done  = 1'b1;
            next_state = S_IDLE;
        end
        default: begin
            next_state = S_ERR;
            next_result = sum;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state       <= S_IDLE;
        sum         <= 32'd0;
        count       <= 8'd0;
        result      <= 32'd0;
        done        <= 1'b0;
        busy        <= 1'b0;
        shadow      <= 3'd0;
        state_debug <= 3'd0;
    end else begin
        state       <= next_state;
        sum         <= next_sum;
        count       <= next_count;
        result      <= next_result;
        done        <= next_done;
        busy        <= next_busy;
        shadow      = state;
        state_debug <= shadow;
    end
end

endmodule