module mux8_reg #(parameter WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   en,
    input  logic [2:0]             sel,
    input  logic [WIDTH-1:0]       d0,
    input  logic [WIDTH-1:0]       d1,
    input  logic [WIDTH-1:0]       d2,
    input  logic [WIDTH-1:0]       d3,
    input  logic [WIDTH-1:0]       d4,
    input  logic [WIDTH-1:0]       d5,
    input  logic [WIDTH-1:0]       d6,
    input  logic [WIDTH-1:0]       d7,
    output logic [WIDTH-1:0]       y
);

logic [WIDTH-1:0] y_next;
logic [WIDTH-1:0] selected_a;
logic [WIDTH-1:0] routed;
logic [7:0]       sel_onehot;
logic [WIDTH-1:0] shadow;
logic             hold;
logic [WIDTH-1:0] en_mask;
logic [WIDTH-1:0] shaped;
logic             select_parity;

function automatic logic [7:0] onehot(input logic [2:0] s);
    logic [7:0] oh;
    oh = 8'b0000_0000;
    oh[s] = 1'b1;
    onehot = oh;
endfunction

function automatic logic [WIDTH-1:0] reverse_bits(input logic [WIDTH-1:0] v);
    logic [WIDTH-1:0] r;
    for (int i = 0; i < WIDTH; i++) begin
        r[i] = v[WIDTH-1-i];
    end
    reverse_bits = r;
endfunction

always_comb begin
    sel_onehot = onehot(sel);
    selected_a = '0;
    case (sel)
        3'd0: selected_a = d0;
        3'd1: selected_a = d1;
        3'd2: selected_a = d2;
        3'd3: selected_a = d3;
        3'd4: selected_a = d4;
        3'd5: selected_a = d5;
        3'd6: selected_a = d6;
        3'd7: selected_a = d7;
        default: selected_a = '0;
    endcase
    select_parity = ^sel_onehot;
    shaped = select_parity ? reverse_bits(selected_a) : selected_a;
    en_mask = {WIDTH{en}};
    routed = hold ? shaped : (selected_a & en_mask);
    y_next = '0;
    if (en === 1'b1) begin
        y_next = routed;
    end else begin
        y_next = shadow;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        y <= '0;
        shadow <= '0;
        hold <= 1'b0;
    end else begin
        y <= y_next;
        shadow = y;
        hold <= en;
    end
end

endmodule