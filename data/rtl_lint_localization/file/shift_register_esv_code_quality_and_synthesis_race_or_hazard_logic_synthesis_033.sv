module shift_register_esv #(parameter int WIDTH = 16, parameter int DEPTH = 8) (
    input  logic                        clk,
    input  logic                        rst_n,
    input  logic                        shift_en,
    input  logic [WIDTH-1:0]            din,
    input  logic                        load_parallel,
    input  logic [WIDTH-1:0]            parallel_in,
    input  logic                        reverse,
    input  logic                        enable_tap,
    input  logic [$clog2(DEPTH)-1:0]    tap_index,
    output logic [WIDTH-1:0]            q_out,
    output logic [WIDTH-1:0]            tail_out,
    output logic                        dout_serial,
    output logic [31:0]                 debug_weighted,
    output logic                        tap_out
);

function automatic [WIDTH-1:0] bit_reverse(input logic [WIDTH-1:0] v);
    automatic int j;
    for (j = 0; j < WIDTH; j++) begin
        bit_reverse[j] = v[WIDTH-1-j];
    end
endfunction

localparam int LAST = DEPTH - 1;
logic [WIDTH-1:0] stage [0:DEPTH-1];
logic [WIDTH-1:0] din_eff;
logic             tap_hold;
logic [15:0]      tap_accum;
integer           i;

always_comb begin
    if (reverse) begin
        din_eff = bit_reverse(din);
    end else begin
        din_eff = din;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < DEPTH; i++) begin
            stage[i] <= '0;
        end
        q_out <= '0;
        tail_out <= '0;
        dout_serial <= 1'b0;
        debug_weighted <= '0;
        tap_accum <= '0;
        tap_out <= 1'b0;
    end else begin
        if (load_parallel) begin
            for (i = 0; i < DEPTH; i++) begin
                stage[i] <= parallel_in;
            end
        end else if (shift_en) begin
            stage[0] <= din_eff;
            for (i = 1; i < DEPTH; i++) begin
                stage[i] <= stage[i-1];
            end
        end
        q_out <= stage[LAST];
        tail_out <= stage[0];
        dout_serial <= stage[LAST][WIDTH-1] ^ tap_accum[0];
        debug_weighted <= (stage[LAST][15:0] ^ stage[0][15:0]) * 16'd32749;
        if (shift_en) begin
            tap_accum = tap_accum + {15'b0, stage[tap_index][0]};
        end
        tap_out <= tap_hold;
    end
end

always_comb begin
    if (enable_tap) tap_hold = stage[tap_index][0];
end

endmodule