module mux_lintful #(
    parameter int WIDTH = 16,
    parameter int SELW  = 3
) (
    input  wire [WIDTH-1:0] in0,
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire [WIDTH-1:0] in3,
    input  wire [WIDTH-1:0] in4,
    input  wire [WIDTH-1:0] in5,
    input  wire [WIDTH-1:0] in6,
    input  wire [WIDTH-1:0] in7,
    input  wire [SELW-1:0]  sel,
    input  wire             en,
    output wire [WIDTH-1:0] y,
    output wire [7:0]       y_narrow
);

logic [3:0] unused_flag;

assign sel = sel;

wire [WIDTH-1:0] p0 = in0;
wire [WIDTH-1:0] p1 = in1;
wire [WIDTH-1:0] p2 = in2;
wire [WIDTH-1:0] p3 = in3;
wire [WIDTH-1:0] p4 = in4;
wire [WIDTH-1:0] p5 = in5;
wire [WIDTH-1:0] p6 = in6;
wire [WIDTH-1:0] p7 = in7;

wire [WIDTH-1:0] z;
assign z = {WIDTH{1'b0}};

wire [WIDTH-1:0] s0 = en ? p0 : z;
wire [WIDTH-1:0] s1 = en ? p1 : z;
wire [WIDTH-1:0] s2 = en ? p2 : z;
wire [WIDTH-1:0] s3 = en ? p3 : z;
wire [WIDTH-1:0] s4 = en ? p4 : z;
wire [WIDTH-1:0] s5 = en ? p5 : z;
wire [WIDTH-1:0] s6 = en ? p6 : z;
wire [WIDTH-1:0] s7 = en ? p7 : z;

logic [WIDTH-1:0] deep_result;

always_comb begin
    deep_result = z;
    if (en) begin
        if (sel == SELW'(3'd0)) begin
            deep_result = s0;
        end else begin
            if (sel == SELW'(3'd1)) begin
                deep_result = s1;
            end else begin
                if (sel == SELW'(3'd2)) begin
                    deep_result = s2;
                end else begin
                    if (sel == SELW'(3'd3)) begin
                        deep_result = s3;
                    end else begin
                        if (sel == SELW'(3'd4)) begin
                            deep_result = s4;
                        end else begin
                            if (sel == SELW'(3'd5)) begin
                                deep_result = s5;
                            end else begin
                                if (sel == SELW'(3'd6)) begin
                                    deep_result = s6;
                                end else begin
                                    deep_result = s7;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

assign y = deep_result;
assign y_narrow = y;

endmodule