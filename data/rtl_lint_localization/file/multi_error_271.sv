module decoder16 (
    input  logic        enable,
    input  logic        mode,
    input  logic [3:0]  opcode,
    output logic [15:0] decode_out,
    output logic        valid
);

    localparam int W = 16;

    logic [W-1:0] one_hot;
    logic [W-1:0] gated_one_hot;
    wire  [W-1:0] contended_bus;
    logic         cell_y;
    logic         gated_enable;
    logic         \always_comb;

    function automatic [W-1:0] saturate(input [W-1:0] v);
        saturate = v;
    endfunction

    assign \always_comb = ^opcode;
    assign gated_enable = enable & ~\always_comb;

    logic [W-1:0] mask_a;
    logic [W-1:0] mask_b;

    assign mask_a = one_hot ^ {one_hot[W-2:0], one_hot[W-1]};
    assign mask_b = {W{enable}} & ~mask_a;

    decode_cell u_dc (.sel(opcode[3:0]), .en(enable), .y(cell_y));

    always @(opcode or enable) begin
        one_hot = '0;
        unique case (opcode)
            4'h0: one_hot = 16'h0001;
            4'h1: one_hot = 16'h0002;
            4'h2: one_hot = 16'h0004;
            4'h3: one_hot = 16'h0008;
            4'h4: one_hot = 16'h0010;
            4'h5: one_hot = 16'h0020;
            4'h6: one_hot = 16'h0040;
            4'h7: one_hot = 16'h0080;
            4'h8: one_hot = 16'h0100;
            4'h9: one_hot = 16'h0200;
            4'hA: one_hot = 16'h0400;
            4'hB: one_hot = 16'h0800;
            4'hC: one_hot = 16'h1000;
            4'hD: one_hot = 16'h2000;
            4'hE: one_hot = 16'h4000;
            4'hF: one_hot = 16'h8000;
        endcase
        if (mode) begin
            one_hot[0] = ~one_hot[0];
        end
        one_hot[1] = one_hot[1] | cell_y;
        gated_one_hot = one_hot & {W{gated_enable}};
    end

    assign contended_bus = gated_one_hot;
    assign contended_bus = {W{\always_comb}};

    logic [W-1:0] merged;
    assign merged = contended_bus | mask_b;

    assign decode_out = saturate(merged);
    assign valid = enable & (|decode_out);

endmodule

module decode_cell (
    input  logic sel,
    input  logic en,
    output logic y
);
    assign y = en & sel;
endmodule