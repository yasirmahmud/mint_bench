module fancy_counter #(parameter int WIDTH = 8) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic                     dir_up,
    input  logic                     load,
    input  logic [WIDTH-1:0]         load_value,
    input  logic [WIDTH-1:0]         high_limit,
    input  logic [WIDTH-1:0]         low_limit,
    input  logic [WIDTH-1:0]         step,
    output logic [WIDTH-1:0]         count_out,
    output logic [WIDTH-1:0]         shadow_out,
    output logic                     at_low,
    output logic                     at_high,
    output logic                     active,
    output logic [1:0]               state_bits
);

    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_RUN  = 2'b01,
        S_HOLD = 2'b10,
        S_ERR  = 2'b11
    } state_t;

    state_t state;
    state_t next_state;

    logic [WIDTH-1:0] count;
    logic [WIDTH-1:0] next_count;

    logic hit_high;
    logic hit_low;
    logic [WIDTH-1:0] up_step;
    logic [WIDTH-1:0] down_step;
    logic take_step;

    assign up_step   = step;
    assign down_step = step;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        take_step  = 1'b0;
        unique case (state)
            S_IDLE: begin
                if (enable) begin
                    next_state = S_RUN;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_RUN: begin
                take_step = 1'b1;
                if (!enable) begin
                    next_state = S_HOLD;
                end else begin
                    next_state = S_RUN;
                end
            end
            S_HOLD: begin
                if (load) begin
                    next_state = S_IDLE;
                end else if (enable) begin
                    next_state = S_RUN;
                end else begin
                    next_state = S_HOLD;
                end
            end
        endcase
    end

    always_comb begin
        next_count = count;
        hit_high   = (count >= high_limit);
        hit_low    = (count <= low_limit);
        if (load) begin
            next_count = load_value;
        end else begin
            case (state)
                S_IDLE: begin
                    next_count = count;
                end
                S_RUN: begin
                    if (take_step) begin
                        if (dir_up) begin
                            if (!hit_high) begin
                                next_count = count + up_step;
                            end else begin
                                next_count = high_limit;
                            end
                        end else begin
                            if (!hit_low) begin
                                next_count = count - down_step;
                            end else begin
                                next_count = low_limit;
                            end
                        end
                    end else begin
                        next_count = count;
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
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= '0;
        end else begin
            count <= next_count;
        end
    end

    logic [WIDTH-1:0] shadow_count;

    always @(posedge clk or negedge rst_n or posedge enable) begin
        if (!rst_n) begin
            shadow_count <= '0;
        end else if (enable) begin
            if (dir_up) begin
                shadow_count <= shadow_count + up_step;
            end else begin
                shadow_count <= shadow_count - down_step;
            end
        end
    end

    assign count_out  = count;
    assign shadow_out = shadow_count;
    assign at_high    = (count == high_limit);
    assign at_low     = (count == low_limit);
    assign active     = (state == S_RUN);
    assign state_bits = state;

endmodule