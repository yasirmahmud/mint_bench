module child_mux2 #(parameter int W = 8) (
    input  logic [W-1:0] a,
    input  logic [W-1:0] b,
    input  logic         s,
    output logic [W-1:0] y
);
    always_comb begin
        y = s ? b : a;
    end
endmodule

module complex_mux8 #(parameter int WIDTH = 16) (
    input  logic                 enable,
    input  logic [2:0]           sel,
    input  logic [WIDTH-1:0]     in0,
    input  logic [WIDTH-1:0]     in1,
    input  logic [WIDTH-1:0]     in2,
    input  logic [WIDTH-1:0]     in3,
    input  logic [WIDTH-1:0]     in4,
    input  logic [WIDTH-1:0]     in5,
    input  logic [WIDTH-1:0]     in6,
    input  logic [WIDTH-1:0]     in7,
    output logic [WIDTH-1:0]     y
);
    logic [WIDTH-1:0] y_mux_core;
    logic [7:0]       y_low;
    logic [WIDTH-1:0] stage1_bus;
    logic [7:0]       stage2_lower;
    logic [WIDTH-1:0] gated_upper_concat;
    logic [WIDTH-1:0] lower_insert_concat;
    logic [WIDTH-1:0] y_combined;

    always @(sel or in0 or in1) begin
        y_mux_core = '0;
        if (sel[2]) begin
            if (sel[1]) begin
                if (sel[0]) begin
                    y_mux_core = in7;
                end else begin
                    y_mux_core = in6;
                end
            end else begin
                if (sel[0]) begin
                    y_mux_core = in5;
                end else begin
                    y_mux_core = in4;
                end
            end
        end else begin
            if (sel[1]) begin
                if (sel[0]) begin
                    y_mux_core = in3;
                end else begin
                    y_mux_core = in2;
                end
            end else begin
                if (sel[0]) begin
                    y_mux_core = in1;
                end else begin
                    y_mux_core = in0;
                end
            end
        end
    end

    child_mux2 #(.W(8)) u_low (.a(in3), .b(in5), .s(sel[0]), .y(y_low));

    assign stage1_bus = y_mux_core;

    assign stage2_lower = y_low & {8{enable}};

    assign gated_upper_concat = { (stage1_bus[WIDTH-1:8] & { (WIDTH-8){enable} }), 8'b0 };

    assign lower_insert_concat = { {(WIDTH-8){1'b0}}, stage2_lower };

    assign y_combined = gated_upper_concat | lower_insert_concat;

    assign y = y_combined;

endmodule