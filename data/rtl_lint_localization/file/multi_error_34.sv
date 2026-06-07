module mux8_synth_test #(parameter int WIDTH = 16) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    async_clear,
    input  logic                    en,
    input  logic                    mode_inv,
    input  logic                    mode_hold,
    input  logic [2:0]              sel,
    input  logic [WIDTH-1:0]        in0,
    input  logic [WIDTH-1:0]        in1,
    input  logic [WIDTH-1:0]        in2,
    input  logic [WIDTH-1:0]        in3,
    input  logic [WIDTH-1:0]        in4,
    input  logic [WIDTH-1:0]        in5,
    input  logic [WIDTH-1:0]        in6,
    input  logic [WIDTH-1:0]        in7,
    output logic [WIDTH-1:0]        y,
    output logic [WIDTH-1:0]        dbg_shadow_o
);

    localparam int N = 8;

    logic [WIDTH-1:0] masked_in [0:N-1];
    logic [WIDTH-1:0] mux_out_comb;
    logic [WIDTH-1:0] next_y;
    logic [WIDTH-1:0] y_reg;
    logic [WIDTH-1:0] debug_shadow;
    logic [WIDTH-1:0] spare_decl

    function automatic logic parity_even(input logic [WIDTH-1:0] v);
        logic p;
        p = 1'b0;
        for (int i = 0; i < WIDTH; i++) begin
            p ^= v[i];
        end
        return p;
    endfunction

    assign masked_in[0] = en ? in0 : '0;
    assign masked_in[1] = en ? in1 : '0;
    assign masked_in[2] = en ? in2 : '0;
    assign masked_in[3] = en ? in3 : '0;
    assign masked_in[4] = en ? in4 : '0;
    assign masked_in[5] = en ? in5 : '0;
    assign masked_in[6] = en ? in6 : '0;
    assign masked_in[7] = en ? in7 : '0;

    always_comb begin
        case (sel)
            3'd0: mux_out_comb = masked_in[0];
            3'd1: mux_out_comb = masked_in[1];
            3'd2: mux_out_comb = masked_in[2];
            3'd3: mux_out_comb = masked_in[3];
            3'd4: mux_out_comb = masked_in[4];
            3'd5: mux_out_comb = masked_in[5];
            3'd6: mux_out_comb = masked_in[6];
        endcase
    end

    always_comb begin
        unique casez ({mode_inv, mode_hold})
            2'b1?: next_y = ~mux_out_comb;
            2'b01: next_y = y_reg;
            default: next_y = mux_out_comb;
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            y_reg <= '0;
        end else begin
            if (mode_hold) begin
                y_reg <= y_reg;
            end else begin
                y_reg <= next_y;
            end
        end
    end

    assign y = y_reg;

    logic [WIDTH-1:0] mix_vec;
    assign mix_vec = mux_out_comb ^ masked_in[7];

    always @(posedge clk or sel) begin
        if (async_clear) begin
            debug_shadow <= '0;
        end else begin
            debug_shadow <= y_reg ^ {WIDTH{parity_even(mix_vec)}};
        end
    end

    assign dbg_shadow_o = debug_shadow;

endmodule