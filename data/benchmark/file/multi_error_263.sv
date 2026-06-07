module mux4_expert #(
    parameter int WIDTH = 16
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [1:0]           sel,
    input  logic [WIDTH-1:0]     in0,
    input  logic [WIDTH-1:0]     in1,
    input  logic [WIDTH-1:0]     in2,
    input  logic [WIDTH-1:0]     in3,
    output logic [WIDTH-1:0]     y,
    output logic [WIDTH-1:0]     y_reg,
    output logic [WIDTH-1:0]     y_shadow
);

    logic [WIDTH-1:0] y_pre;
    logic [WIDTH-1:0] y_hold;
    logic [WIDTH-1:0] temp0;
    logic [WIDTH-1:0] temp1;

    logic unused_flag;

    function automatic logic [WIDTH-1:0] passthrough(input logic [WIDTH-1:0] d);
        logic [WIDTH-1:0] r;
        r = d;
        return r;
    endfunction

    function automatic logic [WIDTH-1:0] select_or_mask(
        input logic [1:0] s,
        input logic [WIDTH-1:0] a,
        input logic [WIDTH-1:0] b
    );
        logic [WIDTH-1:0] m;
        if (s[0]) begin
            m = a | b;
        end else begin
            m = a & b;
        end
        return m;
    endfunction

    assign temp0 = select_or_mask(sel, in0, in1);
    assign temp1 = select_or_mask(~sel, in2, in3);
    assign y_pre = temp0 ^ temp1;
    assign y_hold = y_pre;

    always @(sel or in0 or in1 or in3 or y_hold) begin
        y = '0;
        unique case (sel)
            2'b00: begin
                y = in0;
            end
            2'b01: begin
                y = in1;
            end
            2'b10: begin
                y = in2;
            end
            2'b11: begin
                y = in3;
            end
            default: begin
                y = y_hold;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            y_reg    <= '0;
            y_shadow <= '0;
        end else begin
            y_reg    <= y;
            y_shadow = passthrough(y_reg);
        end
    end

endmodule