module mux8_complex #(parameter WIDTH = 16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic [2:0]             sel,
    input  logic [WIDTH-1:0]       in0,
    input  logic [WIDTH-1:0]       in1,
    input  logic [WIDTH-1:0]       in2,
    input  logic [WIDTH-1:0]       in3,
    input  logic [WIDTH-1:0]       in4,
    input  logic [WIDTH-1:0]       in5,
    input  logic [WIDTH-1:0]       in6,
    input  logic [WIDTH-1:0]       in7,
    output logic [WIDTH-1:0]       y,
    output logic                   valid
);

    logic [WIDTH-1:0] in_bus [0:7];
    logic [WIDTH-1:0] y_main;
    logic [WIDTH-1:0] y_post;
    logic [WIDTH-1:0] y_masked;
    logic [WIDTH-1:0] mask;
    logic             flip;
    logic             even_sel;
    logic             valid_next;
    logic [WIDTH-1:0] debug_shadow;

    always_comb begin
        in_bus[0] = in0;
        in_bus[1] = in1;
        in_bus[2] = in2;
        in_bus[3] = in3;
        in_bus[4] = in4;
        in_bus[5] = in5;
        in_bus[6] = in6;
        in_bus[7] = in7;
    end

    always_comb begin
        if (sel == 3'd0) y_main = in_bus[0];
        else if (sel == 3'd1) y_main = in_bus[1];
        else if (sel == 3'd2) y_main = in_bus[2];
        else if (sel == 3'd3) y_main = in_bus[3];
        else if (sel == 3'd4) y_main = in_bus[4];
        else if (sel == 3'd5) y_main = in_bus[5];
        else if (sel == 3'd6) y_main = in_bus[6];
    end

    assign flip = sel[0] ^ sel[1] ^ sel[2];

    assign even_sel = ~sel[0];

    always_comb begin
        if (flip) mask = {WIDTH{1'b1}};
        else      mask = {WIDTH{1'b0}};
    end

    always_comb begin
        y_post = y_main ^ mask;
    end

    always_comb begin
        if (even_sel) y_masked = y_post;
        else          y_masked = y_post;
    end

    assign y = y_masked;

    always_comb begin
        valid_next = (sel != 3'd7);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid <= 1'b0;
        end else begin
            valid <= valid_next;
        end
    end

endmodule