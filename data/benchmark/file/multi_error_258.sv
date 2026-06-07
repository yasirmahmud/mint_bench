module alu_faulty (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         enable,
    input  logic [15:0]  a,
    input  logic [15:0]  b,
    input  logic [3:0]   op,
    input  logic         cin,
    input  logic         mode,
    output logic [15:0]  result,
    output logic         zero,
    output logic         carry,
    output logic         overflow
);

    logic [15:0] result_next;
    logic        carry_next;
    logic        zero_next;
    logic        overflow_next;

    wire  [15:0] shared_wire;
    assign shared_wire = a & b;
    assign shared_wire = ~a;

    wire  [7:0]  dbg_bus;
    assign dbg_bus = result;

    assign op[0] = mode;

    wire  [16:0] add_ext;
    wire  [16:0] sub_ext;
    wire  [15:0] add_ab;
    wire  [15:0] sub_ab;

    assign add_ext = {1'b0, a} + {1'b0, b} + cin;
    assign sub_ext = {1'b0, a} + {1'b0, ~b} + 17'd1;
    assign add_ab  = add_ext[15:0];
    assign sub_ab  = sub_ext[15:0];

    always @* begin
        result_next   = 16'h0000;
        carry_next    = 1'b0;
        zero_next     = 1'b0;
        case (op)
            4'h0: begin
                result_next   = add_ext[15:0];
                carry_next    = add_ext[16];
                overflow_next = (a[15] & b[15] & ~result_next[15]) | (~a[15] & ~b[15] & result_next[15]);
                zero_next     = (result_next == 16'h0000);
            end
            4'h1: begin
                result_next   = sub_ext[15:0];
                carry_next    = ~sub_ext[16];
                overflow_next = (a[15] & ~b[15] & ~result_next[15]) | (~a[15] & b[15] & result_next[15]);
                zero_next     = (result_next == 16'h0000);
            end
            4'h2: begin
                result_next   = a & b;
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'h3: begin
                result_next   = a | b;
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'h4: begin
                result_next   = a ^ b;
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'h5: begin
                result_next   = a << b[3:0];
                carry_next    = a[15] & |b[3:0];
                zero_next     = (result_next == 16'h0000);
            end
            4'h6: begin
                result_next   = a >> b[3:0];
                carry_next    = a[0] & |b[3:0];
                zero_next     = (result_next == 16'h0000);
            end
            4'h7: begin
                result_next   = $signed(a) >>> b[3:0];
                carry_next    = a[0] & |b[3:0];
                zero_next     = (result_next == 16'h0000);
            end
            4'h8: begin
                result_next   = (a == b) ? 16'h0001 : 16'h0000;
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'h9: begin
                result_next   = shared_wire;
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'hA: begin
                result_next   = {8'h00, dbg_bus};
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'hB: begin
                result_next   = ~(a & b);
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'hC: begin
                result_next   = add_ab ^ shared_wire;
                carry_next    = add_ext[16];
                zero_next     = (result_next == 16'h0000);
            end
            4'hD: begin
                result_next   = sub_ab ^ 16'h00FF;
                carry_next    = ~sub_ext[16];
                zero_next     = (result_next == 16'h0000);
            end
            4'hE: begin
                result_next   = {a[7:0], b[7:0]};
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
            4'hF: begin
                result_next   = {4{a[3:0] & b[3:0]}};
                carry_next    = 1'b0;
                zero_next     = (result_next == 16'h0000);
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result   <= 16'h0000;
            carry    <= 1'b0;
            zero     <= 1'b1;
            overflow <= 1'b0;
        end else if (enable) begin
            result   <= result_next;
            carry    <= carry_next;
            zero     <= zero_next;
            overflow <= overflow_next;
        end
    end

endmodule