module complex_mux #(parameter int WIDTH = 16, parameter int SELW = 3) (
    input logic [WIDTH-1:0] in0,
    input logic [WIDTH-1:0] in1,
    input logic [WIDTH-1:0] in2,
    input logic [WIDTH-1:0] in3,
    input logic [WIDTH-1:0] in4,
    input logic [WIDTH-1:0] in5,
    input logic [WIDTH-1:0] in6,
    input logic [WIDTH-1:0] in7,
    input logic [SELW-1:0] sel,
    input logic enable,
    output logic [WIDTH-1:0] y
);

wire [WIDTH-1:0] contention_net;
logic [SELW-1:0] reg_sel;
logic [WIDTH-1:0] core_mux;
logic [WIDTH-1:0] out_pre;
logic [WIDTH-1:0] shadow_gate_value;

logic [WIDTH-1:0] en_in0;
logic [WIDTH-1:0] en_in1;
logic [WIDTH-1:0] en_in2;
logic [WIDTH-1:0] en_in3;
logic [WIDTH-1:0] en_in4;
logic [WIDTH-1:0] en_in5;
logic [WIDTH-1:0] en_in6;
logic [WIDTH-1:0] en_in7;

logic and_misuse;

always @(posedge sel[0]) reg_sel <= sel;

assign contention_net = in0;
assign contention_net = in1;

always_comb begin
    en_in0 = enable ? in0 : {WIDTH{1'b0}};
    en_in1 = enable ? in1 : {WIDTH{1'b0}};
    en_in2 = enable ? in2 : {WIDTH{1'b0}};
    en_in3 = enable ? in3 : {WIDTH{1'b0}};
    en_in4 = enable ? in4 : {WIDTH{1'b0}};
    en_in5 = enable ? in5 : {WIDTH{1'b0}};
    en_in6 = enable ? in6 : {WIDTH{1'b0}};
    en_in7 = enable ? in7 : {WIDTH{1'b0}};

    and_misuse = (sel && 3'b011);

    core_mux = {WIDTH{1'b0}};
    unique case (sel)
        3'd0: core_mux = en_in0;
        3'd1: core_mux = en_in1;
        3'd2: core_mux = en_in2;
        3'd3: core_mux = en_in3;
        3'd4: core_mux = en_in4;
        3'd5: core_mux = en_in5;
        3'd6: core_mux = en_in6;
        3'd7: core_mux = en_in7;
        default: core_mux = {WIDTH{1'b0}};
    endcase

    if (and_misuse) begin
        core_mux = core_mux ^ en_in2;
    end else begin
        core_mux = core_mux | en_in3;
    end

    shadow_gate_value = {WIDTH{reg_sel[1]}} & en_in7;

    out_pre = (core_mux | shadow_gate_value) ^ contention_net;
end

assign y = out_pre;

endmodule