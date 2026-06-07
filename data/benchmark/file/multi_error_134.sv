module complex_mux #(parameter WIDTH = 8) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              enable,
    input  logic              lock,
    input  logic [2:0]        sel,
    input  logic [WIDTH-1:0]  d0,
    input  logic [WIDTH-1:0]  d1,
    input  logic [WIDTH-1:0]  d2,
    input  logic [WIDTH-1:0]  d3,
    input  logic [WIDTH-1:0]  d4,
    input  logic [WIDTH-1:0]  d5,
    input  logic [WIDTH-1:0]  d6,
    input  logic [WIDTH-1:0]  d7,
    input  logic [WIDTH-1:0]  override_data,
    output logic [WIDTH-1:0]  y
);

typedef enum logic [1:0] {
    S_IDLE   = 2'b00,
    S_ROUTE  = 2'b01,
    S_HOLD   = 2'b10,
    S_UNUSED = 2'b11
} state_e;

state_e state;
state_e next_state;

logic [WIDTH-1:0] comb_mux_out;
logic [WIDTH-1:0] y_int;
logic [15:0]      wide_source;
logic [WIDTH-1:0] latched_override;
logic             hold_en;

assign hold_en = (state == S_HOLD);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= S_IDLE;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    unique case (state)
        S_IDLE: begin
            if (enable) begin
                next_state = S_ROUTE;
            end
        end
        S_ROUTE: begin
            if (lock) begin
                next_state = S_HOLD;
            end else begin
                next_state = S_ROUTE;
            end
        end
        S_HOLD: begin
            if (!lock) begin
                next_state = S_ROUTE;
            end
        end
    endcase
end

always @(*) begin
    if (hold_en) latched_override = override_data;
end

always_comb begin
    comb_mux_out = '0;
    if (sel[2]) begin
        if (sel[1]) begin
            if (sel[0]) begin
                comb_mux_out = d7;
            end else begin
                comb_mux_out = d6;
            end
        end else begin
            if (sel[0]) begin
                comb_mux_out = d5;
            end else begin
                comb_mux_out = d4;
            end
        end
    end else begin
        if (sel[1]) begin
            if (sel[0]) begin
                comb_mux_out = d3;
            end else begin
                comb_mux_out = d2;
            end
        end else begin
            if (sel[0]) begin
                comb_mux_out = d1;
            end else begin
                comb_mux_out = d0;
            end
        end
    end
end

assign wide_source = {d7, d6};

assign y_int = wide_source;

always_comb begin
    logic [WIDTH-1:0] routed;
    routed = comb_mux_out;
    if (state == S_ROUTE) begin
        y = routed;
    end else if (state == S_HOLD) begin
        y = latched_override;
    end else begin
        y = y_int;
    end
end

endmodule