module complex_mux_with_errors #(parameter int WIDTH = 8) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     en,
    input  logic [1:0]               sel,
    input  logic [WIDTH-1:0]         d0,
    input  logic [WIDTH-1:0]         d1,
    input  logic [WIDTH-1:0]         d2,
    input  logic [WIDTH-1:0]         d3,
    input  logic                     test_mode,
    output logic [WIDTH-1:0]         y
);

    logic [WIDTH-1:0] pre_d0;
    logic [WIDTH-1:0] pre_d1;
    logic [WIDTH-1:0] pre_d2;
    logic [WIDTH-1:0] pre_d3;

    assign pre_d0 = d0 ^ {WIDTH{test_mode}};
    assign pre_d1 = d1 ^ {WIDTH{test_mode}};
    assign pre_d2 = d2 ^ {WIDTH{test_mode}};
    assign pre_d3 = d3 ^ {WIDTH{test_mode}};

    assign test_mode = 1'b0;

    logic [WIDTH-1:0] sat_d0;
    logic [WIDTH-1:0] sat_d1;
    logic [WIDTH-1:0] sat_d2;
    logic [WIDTH-1:0] sat_d3;

    assign sat_d0 = pre_d0 | {WIDTH{en}};
    assign sat_d1 = pre_d1 | {WIDTH{en}};
    assign sat_d2 = pre_d2 | {WIDTH{en}};
    assign sat_d3 = pre_d3 | {WIDTH{en}};

    logic [WIDTH-1:0] gated_d0;
    logic [WIDTH-1:0] gated_d1;
    logic [WIDTH-1:0] gated_d2;
    logic [WIDTH-1:0] gated_d3;

    assign gated_d0 = en ? pre_d0 : '0;
    assign gated_d1 = en ? pre_d1 : '0;
    assign gated_d2 = en ? pre_d2 : '0;
    assign gated_d3 = en ? pre_d3 : '0;

    logic [WIDTH-1:0] blended01;
    logic [WIDTH-1:0] blended23;

    assign blended01 = (gated_d0 & sat_d1) | (gated_d1 & sat_d0);
    assign blended23 = (gated_d2 & sat_d3) | (gated_d3 & sat_d2);

    logic [3:0] tmp_narrow;
    tiny_mux2 u_tiny (.a(pre_d0[3:0]), .b(pre_d1), .s(sel[0]), .y(tmp_narrow));

    logic [WIDTH-1:0] aux_mask;
    assign aux_mask = {{(WIDTH-4){1'b0}}, tmp_narrow};

    logic [WIDTH-1:0] comb_mux;

    always @(sel or gated_d0 or gated_d1) begin
        comb_mux = '0;
        unique case (sel)
            2'b00: comb_mux = blended01 ^ aux_mask;
            2'b01: comb_mux = blended01;
            2'b10: comb_mux = blended23;
            2'b11: comb_mux = gated_d3;
            default: comb_mux = '0;
        endcase
    end

    logic parity0;
    logic parity1;
    logic parity2;
    logic parity3;

    always_comb begin
        parity0 = ^d0;
        parity1 = ^d1;
        parity2 = ^d2;
        parity3 = ^d3;
    end

    logic [WIDTH-1:0] parity_mask;
    always_comb begin
        parity_mask = {WIDTH{parity0 | parity1 | parity2 | parity3}};
    end

    logic [WIDTH-1:0] y_reg;

    always @(posedge clk or sel) begin
        if (!rst_n) begin
            y_reg <= '0;
        end else begin
            y_reg <= comb_mux ^ (en ? parity_mask : '0);
        end
    end

    assign y = y_reg;

endmodule

module tiny_mux2 (
    input  logic [3:0] a,
    input  logic [7:0] b,
    input  logic       s,
    output logic [7:0] y
);
    always_comb begin
        y = s ? b : {4'b0000, a};
    end
endmodule