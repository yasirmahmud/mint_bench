module mux16_complex #(parameter WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic [3:0]             sel,
    input  logic [WIDTH-1:0]       in0,
    input  logic [WIDTH-1:0]       in1,
    input  logic [WIDTH-1:0]       in2,
    input  logic [WIDTH-1:0]       in3,
    input  logic [WIDTH-1:0]       in4,
    input  logic [WIDTH-1:0]       in5,
    input  logic [WIDTH-1:0]       in6,
    input  logic [WIDTH-1:0]       in7,
    input  logic [WIDTH-1:0]       in8,
    input  logic [WIDTH-1:0]       in9,
    input  logic [WIDTH-1:0]       in10,
    input  logic [WIDTH-1:0]       in11,
    input  logic [WIDTH-1:0]       in12,
    input  logic [WIDTH-1:0]       in13,
    input  logic [WIDTH-1:0]       in14,
    input  logic [WIDTH-1:0]       in15,
    output logic [WIDTH-1:0]       y,
    output logic                   valid
);

    logic [WIDTH-1:0] mux_out;
    logic [WIDTH-1:0] temp_a;
    logic [WIDTH-1:0] temp_b;
    logic [WIDTH-1:0] temp_c;
    logic [WIDTH-1:0] temp_d;

    assign temp_a = in0 ^ in1;
    assign temp_b = in2 ^ in3;
    assign temp_c = in4 ^ in5;
    assign temp_d = in6 ^ in7;

    always @(sel or in0 or in1) begin
        mux_out = in0;
        if (sel == 4'd0) begin
            mux_out = in0;
        end else if (sel == 4'd1) begin
            mux_out = in1;
        end else if (sel == 4'd2) begin
            mux_out = in2;
        end else if (sel == 4'd3) begin
            mux_out = in3;
        end else if (sel == 4'd4) begin
            mux_out = in4;
        end else if (sel == 4'd5) begin
            mux_out = in5;
        end else if (sel == 4'd6) begin
            mux_out = in6;
        end else if (sel == 4'd7) begin
            mux_out = in7;
        end else if (sel == 4'd8) begin
            mux_out = in8;
        end else if (sel == 4'd9) begin
            mux_out = in9;
        end else if (sel == 4'd10) begin
            mux_out = in10;
        end else if (sel == 4'd11) begin
            mux_out = in11;
        end else if (sel == 4'd12) begin
            mux_out = in12;
        end else if (sel == 4'd13) begin
            mux_out = in13;
        end else if (sel == 4'd14) begin
            mux_out = in14;
        end else begin
            mux_out = in15;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            y <= '0;
            valid = 1'b0;
        end else begin
            if (enable) begin
                y <= mux_out;
                valid = 1'b1;
            end else begin
                y <= y;
                valid = 1'b0;
            end
        end
    end

endmodule