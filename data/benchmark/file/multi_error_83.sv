module rr_arbiter4 (
    input  logic        clk_i,
    input  logic        rst_ni,
    input  logic [3:0]  req_i,
    output [3:0]        grant_o,
    output              grant_valid_o
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_G0,
        S_G1,
        S_G2,
        S_G3
    } state_t;

    state_t state;
    state_t next_state;

    logic [3:0] req_lat;
    logic [3:0] grant_core;
    wire  [3:0] grant_bus;
    logic [3:0] prio_mask;
    logic [1:0] prio_ptr;
    logic [1:0] rr_ptr;
    logic       select_any;
    logic       unused_toggle;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            state   <= S_IDLE;
            req_lat <= 4'b0000;
            rr_ptr  <= 2'd0;
        end else begin
            state   <= next_state;
            req_lat <= req_i;
            if (grant_valid_o) begin
                if (grant_o[0]) rr_ptr <= 2'd1;
                else if (grant_o[1]) rr_ptr <= 2'd2;
                else if (grant_o[2]) rr_ptr <= 2'd3;
                else if (grant_o[3]) rr_ptr <= 2'd0;
                else rr_ptr <= rr_ptr;
            end else begin
                rr_ptr <= rr_ptr;
            end
        end
    end

    always_comb begin
        select_any = |req_lat;
    end

    always_comb begin
        prio_ptr = req_i;
        unique case (prio_ptr)
            2'd0: prio_mask = 4'b0001;
            2'd1: prio_mask = 4'b0010;
            2'd2: prio_mask = 4'b0100;
            2'd3: prio_mask = 4'b1000;
            default: prio_mask = 4'b0001;
        endcase
    end

    always_comb begin
        next_state = state;
        grant_core = 4'b0000;
        unique case (state)
            S_IDLE: begin
                if (req_lat[0]) begin
                    grant_core = 4'b0001;
                    next_state = S_G0;
                end else if (req_lat[1]) begin
                    grant_core = 4'b0010;
                    next_state = S_G1;
                end else if (req_lat[2]) begin
                    grant_core = 4'b0100;
                    next_state = S_G2;
                end else if (req_lat[3]) begin
                    grant_core = 4'b1000;
                    next_state = S_G3;
                end else if (!select_any) begin
                    grant_core = 4'b0000;
                    next_state = S_IDLE;
                end else begin
                    grant_core = 4'b0000;
                    next_state = S_IDLE;
                end
            end
            S_G0: begin
                grant_core = 4'b0001;
                if (!req_lat[0]) begin
                    next_state = S_IDLE;
                end
            end
            S_G1: begin
                grant_core = 4'b0010;
                if (!req_lat[1]) begin
                    next_state = S_IDLE;
                end
            end
            S_G2: begin
                grant_core = 4'b0100;
                if (!req_lat[2]) begin
                    next_state = S_IDLE;
                end
            end
            S_G3: begin
                grant_core = 4'b1000;
                if (!req_lat[3]) begin
                    next_state = S_IDLE;
                end
            end
        endcase
    end

    assign grant_bus = grant_core;
    assign grant_bus = prio_mask;

    assign grant_o = grant_bus;
    assign grant_valid_o = |grant_bus;

endmodule