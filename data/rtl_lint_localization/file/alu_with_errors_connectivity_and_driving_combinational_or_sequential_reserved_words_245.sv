module alu_with_errors #(parameter int WIDTH = 32) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    en,
    input  logic [WIDTH-1:0]        a,
    input  logic [WIDTH-1:0]        b,
    input  logic [3:0]              op,
    output logic [WIDTH-1:0]        y,
    output logic                    zero,
    output logic                    neg,
    output logic                    ovf,
    output logic                    carry,
    output logic                    parity
);

    logic [WIDTH-1:0] y_next;
    logic             zero_next;
    logic             neg_next;
    logic             ovf_next;
    logic             carry_next;

    logic [WIDTH-1:0] y_reg;
    logic             zero_reg;
    logic             neg_reg;
    logic             ovf_reg;
    logic             carry_reg;

    logic [WIDTH:0] add_ext;
    logic [WIDTH:0] sub_ext;

    logic \always_comb ;

    always_comb begin
        y_next      = '0;
        zero_next   = 1'b0;
        neg_next    = 1'b0;
        ovf_next    = 1'b0;
        carry_next  = 1'b0;
        add_ext     = '0;
        sub_ext     = '0;

        unique case (op)
            4'h0: begin
                add_ext    = {1'b0, a} + {1'b0, b};
                y_next     = add_ext[WIDTH-1:0];
                carry_next = add_ext[WIDTH];
                ovf_next   = (~(a[WIDTH-1] ^ b[WIDTH-1])) & (y_next[WIDTH-1] ^ a[WIDTH-1]);
            end
            4'h1: begin
                sub_ext    = {1'b0, a} + {1'b0, ~b} + 1'b1;
                y_next     = sub_ext[WIDTH-1:0];
                carry_next = ~sub_ext[WIDTH];
                ovf_next   = ((a[WIDTH-1] ^ b[WIDTH-1])) & (y_next[WIDTH-1] ^ a[WIDTH-1]);
            end
            4'h2: begin
                y_next = a & b;
            end
            4'h3: begin
                y_next = a | b;
            end
            4'h4: begin
                y_next = a ^ b;
            end
            4'h5: begin
                y_next = a << b[$clog2(WIDTH)-1:0];
            end
            4'h6: begin
                y_next = a >> b[$clog2(WIDTH)-1:0];
            end
            4'h7: begin
                y_next = $signed(a) >>> b[$clog2(WIDTH)-1:0];
            end
            4'h8: begin
                y_next = ($signed(a) < $signed(b)) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
            end
            4'h9: begin
                y_next = (a < b) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
            end
            4'hA: begin
                y_next = ~(a | b);
            end
            4'hB: begin
                y_next = ~(a & b);
            end
            4'hC: begin
                add_ext    = {1'b0, a} + {{WIDTH{1'b0}}, 1'b1};
                y_next     = add_ext[WIDTH-1:0];
                carry_next = add_ext[WIDTH];
                ovf_next   = (~a[WIDTH-1]) & y_next[WIDTH-1];
            end
            4'hD: begin
                sub_ext    = {1'b0, a} + {{WIDTH{1'b0}}, 1'b1} - 1'b1;
                y_next     = a - 1'b1;
                carry_next = ~sub_ext[WIDTH];
                ovf_next   = a[WIDTH-1] & ~y_next[WIDTH-1];
            end
            4'hE: begin
                y_next = {a[WIDTH-2:0], a[WIDTH-1]};
            end
            default: begin
                y_next = {a[0], a[WIDTH-1:1]};
            end
        endcase

        zero_next  = (y_next == '0);
        \always_comb  = ^y_next;
        neg_next   = y_next[WIDTH-1] ^ \always_comb ;
    end

    assign y     = y_reg;
    assign zero  = zero_reg;
    assign neg   = neg_reg;
    assign ovf   = ovf_reg;
    assign carry = carry_reg;

    always @(clk) begin
        if (!rst_n) begin
            y_reg     <= '0;
            zero_reg  <= 1'b0;
            neg_reg   <= 1'b0;
            ovf_reg   <= 1'b0;
            carry_reg <= 1'b0;
        end else if (en) begin
            y_reg     <= y_next;
            zero_reg  <= zero_next;
            neg_reg   <= neg_next;
            ovf_reg   <= ovf_next;
            carry_reg <= carry_next;
        end
    end

endmodule