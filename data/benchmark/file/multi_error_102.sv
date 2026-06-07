module mux_fsm_complex #(parameter WIDTH = 8) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      req_valid,
    input  logic                      force_bypass,
    input  logic [1:0]                sel_req,
    input  logic [WIDTH-1:0]          a,
    input  logic [WIDTH-1:0]          b,
    input  logic [WIDTH-1:0]          c,
    input  logic [WIDTH-1:0]          d,
    output logic [WIDTH-1:0]          y,
    output logic                      y_valid
);

    typedef enum logic [2:0] {S_IDLE, S_LOAD, S_HOLD, S_BYPASS, S_UNUSED} state_t;

    state_t curr_state;
    state_t next_state;

    logic [1:0] sel_reg;
    logic [1:0] sel_next;
    logic [1:0] sel_effective;

    logic [15:0] wide_mux;
    logic [7:0]  selected8;
    logic [7:0]  mix8;
    logic [15:0] gating_data;

    logic idle_hold;

    function automatic [7:0] rotl8(input logic [7:0] x, input logic [2:0] sh);
        rotl8 = (x << sh) | (x >> (8 - sh));
    endfunction

    always_comb begin
        idle_hold = ~req_valid;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            curr_state <= S_IDLE;
            sel_reg    <= '0;
        end else begin
            curr_state <= next_state;
            sel_reg    <= sel_next;
        end
    end

    always_comb begin
        next_state = curr_state;
        sel_next   = sel_reg;
        case (curr_state)
            S_IDLE: begin
                if (req_valid) begin
                    next_state = S_LOAD;
                end
            end
            S_LOAD: begin
                sel_next = sel_req;
                if (force_bypass) begin
                    next_state = S_BYPASS;
                end else begin
                    next_state = S_HOLD;
                end
            end
            S_HOLD: begin
                if (idle_hold) begin
                    next_state = S_IDLE;
                end else if (force_bypass) begin
                    next_state = S_BYPASS;
                end else begin
                    next_state = S_HOLD;
                end
            end
            S_BYPASS: begin
                if (idle_hold) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_BYPASS;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_comb begin
        sel_effective = sel_reg;
        if (curr_state == S_BYPASS) begin
            sel_effective = 2'b11;
        end
        case (sel_effective)
            2'b00: wide_mux = {a, b};
            2'b01: wide_mux = {b, c};
            2'b10: wide_mux = {c, d};
            2'b11: wide_mux = {d, a};
            default: wide_mux = {a, a};
        endcase
    end

    always_comb begin
        if (curr_state == S_BYPASS) begin
            selected8 = wide_mux[15:8];
        end else begin
            selected8 = wide_mux[7:0];
        end
    end

    always_comb begin
        mix8 = rotl8(selected8 ^ {8{force_bypass}}, {1'b0, sel_effective});
    end

    always_comb begin
        gating_data = {mix8, selected8};
    end

    always_comb begin
        y_valid = req_valid & (curr_state != S_IDLE) & (|mix8 | |gating_data[7:0]);
    end

    assign y = wide_mux;

endmodule