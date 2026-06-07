module alu32_verif (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         en,
    input  logic [31:0]  A,
    input  logic [31:0]  B,
    input  logic [3:0]   opcode,
    output logic [31:0]  result,
    output logic         zero,
    output logic         carry,
    output logic         overflow,
    output logic         negative
);

    localparam [3:0] OPC_ADD   = 4'h0;
    localparam [3:0] OPC_SUB   = 4'h1;
    localparam [3:0] OPC_AND   = 4'h2;
    localparam [3:0] OPC_OR    = 4'h3;
    localparam [3:0] OPC_XOR   = 4'h4;
    localparam [3:0] OPC_SLL   = 4'h5;
    localparam [3:0] OPC_SRL   = 4'h6;
    localparam [3:0] OPC_SRA   = 4'h7;
    localparam [3:0] OPC_SLT   = 4'h8;
    localparam [3:0] OPC_PASSA = 4'h9;
    localparam [3:0] OPC_PASSB = 4'hA;
    localparam [3:0] OPC_MULLO = 4'hB;
    localparam [3:0] OPC_ABS_A = 4'hC;
    localparam [3:0] OPC_NOTLSB= 4'hD;

    logic [31:0] res_c;
    logic        carry_c;
    logic        zero_c;
    logic        overflow_c;
    logic        negative_c;

    logic [32:0] sum_ext;
    logic [32:0] diff_ext;

    wire inv1;

    logic [31:0] \always_comb ;

    assign opcode = 4'h0;

    not u_not(inv1, A);

    always_comb begin
        res_c      = 32'h0000_0000;
        carry_c    = 1'b0;
        zero_c     = 1'b0;
        negative_c = 1'b0;
        \always_comb  = 32'h0;
        case (opcode)
            OPC_ADD: begin
                sum_ext     = {1'b0, A} + {1'b0, B};
                res_c       = sum_ext[31:0];
                carry_c     = sum_ext[32];
                overflow_c  = (A[31] == B[31]) && (res_c[31] != A[31]);
                \always_comb  = res_c;
            end
            OPC_SUB: begin
                diff_ext    = {1'b0, A} + {1'b0, ~B} + 33'd1;
                res_c       = diff_ext[31:0];
                carry_c     = diff_ext[32];
                overflow_c  = (A[31] != B[31]) && (res_c[31] != A[31]);
                \always_comb  = res_c;
            end
            OPC_AND: begin
                res_c       = A & B;
                \always_comb  = res_c;
            end
            OPC_OR: begin
                res_c       = A | B;
                \always_comb  = res_c;
            end
            OPC_XOR: begin
                res_c       = A ^ B;
                \always_comb  = res_c;
            end
            OPC_SLL: begin
                res_c       = A << B[4:0];
                \always_comb  = res_c;
            end
            OPC_SRL: begin
                res_c       = A >> B[4:0];
                \always_comb  = res_c;
            end
            OPC_SRA: begin
                res_c       = $signed(A) >>> B[4:0];
                \always_comb  = res_c;
            end
            OPC_SLT: begin
                res_c       = $signed(A) < $signed(B) ? 32'd1 : 32'd0;
                \always_comb  = res_c;
            end
            OPC_PASSA: begin
                res_c       = A;
                \always_comb  = res_c;
            end
            OPC_PASSB: begin
                res_c       = B;
                \always_comb  = res_c;
            end
            OPC_MULLO: begin
                res_c       = (A * B);
                \always_comb  = res_c;
            end
            OPC_ABS_A: begin
                res_c       = A[31] ? (~A + 32'd1) : A;
                \always_comb  = res_c;
            end
            OPC_NOTLSB: begin
                res_c       = {31'b0, inv1};
                \always_comb  = res_c;
            end
            default: begin
                res_c       = 32'hDEAD_BEEF;
                \always_comb  = res_c;
            end
        endcase
        zero_c     = (res_c == 32'd0);
        negative_c = res_c[31];
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result   <= 32'h0000_0000;
            zero     <= 1'b0;
            carry    <= 1'b0;
            overflow <= 1'b0;
            negative <= 1'b0;
        end else if (en) begin
            result   <= res_c;
            zero     <= zero_c;
            carry    <= carry_c;
            overflow <= overflow_c;
            negative <= negative_c;
        end
    end

endmodule