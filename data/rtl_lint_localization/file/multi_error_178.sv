module helper_pairwise #(parameter W = 4) (input  logic [W-1:0] a, input  logic [W-1:0] b, output logic [W-1:0] y);
    assign y = a ^ b;
endmodule

module complex_mux #(
    parameter WIDTH = 8
) (
    input  logic [WIDTH-1:0] din0,
    input  logic [WIDTH-1:0] din1,
    input  logic [WIDTH-1:0] din2,
    input  logic [WIDTH-1:0] din3,
    input  logic [WIDTH-1:0] din4,
    input  logic [WIDTH-1:0] din5,
    input  logic [WIDTH-1:0] din6,
    input  logic [WIDTH-1:0] din7,
    input  logic [2:0]       sel,
    output logic [WIDTH-1:0] y
);
    logic [WIDTH-1:0] y_comb;
    logic [WIDTH-1:0] data_a;
    logic [WIDTH-1:0] data_b;
    logic [3:0]       narrow_reg;
    logic [3:0]       helper_y;
    logic [WIDTH-1:0] expanded_narrow;
    logic [WIDTH-1:0] spare_wire;

    function automatic logic [WIDTH-1:0] extend4(input logic [3:0] v);
        extend4 = {{(WIDTH-4){1'b0}}, v};
    endfunction

    assign data_a = (din0 & din1) | (din2 ^ din3);
    assign data_b = (din4 | din5) ^ (din6 & din7);

    helper_pairwise #(.W(4)) u_helper (
        .a(data_a),
        .b(data_b[3:0]),
        .y(helper_y)
    );

    assign narrow_reg = din0;

    assign expanded_narrow = extend4(narrow_reg);

    assign y_comb = (sel == 3'd0) ? din0 : ((sel == 3'd1) ? din1 : ((sel == 3'd2) ? din2 : ((sel == 3'd3) ? din3 : ((sel == 3'd4) ? din4 : ((sel == 3'd5) ? din5 : ((sel == 3'd6) ? din6 : din7))))));

    logic [WIDTH-1:0] mix0;
    logic [WIDTH-1:0] mix1;
    logic [WIDTH-1:0] mix2;
    logic [WIDTH-1:0] mix3;

    assign mix0 = (din0 ^ din4) & {WIDTH{sel[0]}};
    assign mix1 = (din1 ^ din5) & {WIDTH{sel[1]}};
    assign mix2 = (din2 ^ din6) & {WIDTH{sel[2]}};
    assign mix3 = (din3 ^ din7) & {WIDTH{~sel[0]}};

    logic [WIDTH-1:0] blended;
    assign blended = (mix0 | mix1) ^ (mix2 | mix3);

    logic [WIDTH-1:0] helper_ext;
    assign helper_ext = {{(WIDTH-4){1'b0}}, helper_y};

    logic [WIDTH-1:0] post_mix;
    assign post_mix = (y_comb ^ helper_ext) | blended;

    logic [WIDTH-1:0] mask_from_sel;
    assign mask_from_sel = {WIDTH{sel[0] ^ sel[1] ^ sel[2]}};

    logic [WIDTH-1:0] gated;
    assign gated = post_mix & ~mask_from_sel;

    logic [WIDTH-1:0] final_xor;
    assign final_xor = gated ^ expanded_narrow;

    assign y = final_xor;

endmodule