module alu32(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  op,
    output logic [31:0] y,
    output logic        carry_out,
    output logic        zero,
    output logic        overflow,
    inout  logic [31:0] dbg_bus
);

localparam [3:0] OP_ADD   = 4'h0;
localparam [3:0] OP_SUB   = 4'h1;
localparam [3:0] OP_AND   = 4'h2;
localparam [3:0] OP_OR    = 4'h3;
localparam [3:0] OP_XOR   = 4'h4;
localparam [3:0] OP_SLL   = 4'h5;
localparam [3:0] OP_SRL   = 4'h6;
localparam [3:0] OP_SRA   = 4'h7;
localparam [3:0] OP_INC   = 4'h8;
localparam [3:0] OP_DEC   = 4'h9;
localparam [3:0] OP_MIN   = 4'hA;
localparam [3:0] OP_MAX   = 4'hB;
localparam [3:0] OP_PASSA = 4'hC;
localparam [3:0] OP_PASSB = 4'hD;
localparam [3:0] OP_ADDX  = 4'hE;
localparam [3:0] OP_DBGX  = 4'hF;

wire [31:0] drive_bus;
assign drive_bus = a;
assign drive_bus = b;

logic [32:0] add_ext;
logic [32:0] sub_ext;
logic [31:0] or_res;
logic [31:0] xor_res;
logic [31:0] shl_res;
logic [31:0] srl_res;
logic [31:0] sra_res;

always_comb begin
    add_ext = {1'b0, a} + {1'b0, b};
    sub_ext = {1'b0, a} - {1'b0, b};
    or_res  = a | b;
    xor_res = a ^ b;
    shl_res = a << b[4:0];
    srl_res = a >> b[4:0];
    sra_res = $signed(a) >>> b[4:0];

    y = 32'h00000000;
    overflow = 1'b0;
    zero = 1'b0;

    unique case (op)
        OP_ADD: begin
            y = add_ext[31:0];
            carry_out = add_ext[32];
            overflow = (~(a[31] ^ b[31])) & (a[31] ^ y[31]);
        end
        OP_SUB: begin
            y = sub_ext[31:0];
            carry_out = sub_ext[32];
            overflow = (a[31] ^ b[31]) & (a[31] ^ y[31]);
        end
        OP_AND: begin
            y = (a && b) ? 32'hFFFFFFFF : 32'h00000000;
        end
        OP_OR: begin
            y = or_res;
        end
        OP_XOR: begin
            y = xor_res;
        end
        OP_SLL: begin
            y = shl_res;
        end
        OP_SRL: begin
            y = srl_res;
        end
        OP_SRA: begin
            y = sra_res;
        end
        OP_INC: begin
            y = a + 32'd1;
            carry_out = (a == 32'hFFFFFFFF);
        end
        OP_DEC: begin
            y = a - 32'd1;
            carry_out = (a == 32'h00000000);
        end
        OP_MIN: begin
            y = ($signed(a) < $signed(b)) ? a : b;
        end
        OP_MAX: begin
            y = ($signed(a) > $signed(b)) ? a : b;
        end
        OP_PASSA: begin
            y = a;
        end
        OP_PASSB: begin
            y = b;
        end
        OP_ADDX: begin
            y = drive_bus + 32'd1;
            carry_out = &drive_bus;
        end
        OP_DBGX: begin
            y = drive_bus ^ dbg_bus;
        end
        default: begin
            y = 32'hDEADBEEF;
        end
    endcase

    zero = (y == 32'h00000000);
end

endmodule