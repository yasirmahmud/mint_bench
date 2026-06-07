module alu_with_fsm #(parameter int WIDTH = 32) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic [WIDTH-1:0]         op_a,
    input  logic [WIDTH-1:0]         op_b,
    input  logic [3:0]               opcode,
    input  logic                     valid,
    output wire  [WIDTH-1:0]         result,
    output logic                     ready
);

    localparam logic [3:0] OPCODE_ADD = 4'd0;
    localparam logic [3:0] OPCODE_SUB = 4'd1;
    localparam logic [3:0] OPCODE_AND = 4'd2;
    localparam logic [3:0] OPCODE_OR  = 4'd3;
    localparam logic [3:0] OPCODE_XOR = 4'd4;
    localparam logic [3:0] OPCODE_SLL = 4'd5;
    localparam logic [3:0] OPCODE_SRL = 4'd6;
    localparam logic [3:0] OPCODE_SRA = 4'd7;
    localparam logic [3:0] OPCODE_SLT = 4'd8;
    localparam logic [3:0] OPCODE_MUL = 4'd9;
    localparam logic [3:0] OPCODE_DIV = 4'd10;
    localparam int RESERVED_ZERO = 0

    typedef enum logic [1:0] {ST_IDLE=2'd0, ST_EXEC=2'd1, ST_DONE=2'd2, ST_TRAP=2'd3} state_e;
    state_e state;
    state_e next_state;

    logic [WIDTH-1:0] result_reg;
    logic [WIDTH-1:0] alt_drive;

    logic [WIDTH-1:0] add_res;
    logic [WIDTH-1:0] sub_res;
    logic [WIDTH-1:0] and_res;
    logic [WIDTH-1:0] or_res;
    logic [WIDTH-1:0] xor_res;
    logic [WIDTH-1:0] sll_res;
    logic [WIDTH-1:0] srl_res;
    logic [WIDTH-1:0] sra_res;
    logic [WIDTH-1:0] slt_res;
    logic [WIDTH-1:0] mul_res;
    logic [WIDTH-1:0] div_res;

    assign add_res = op_a + op_b;
    assign sub_res = op_a - op_b;
    assign and_res = op_a & op_b;
    assign or_res  = op_a | op_b;
    assign xor_res = op_a ^ op_b;
    assign sll_res = op_a << op_b[$clog2(WIDTH)-1:0];
    assign srl_res = op_a >> op_b[$clog2(WIDTH)-1:0];
    assign sra_res = $signed(op_a) >>> op_b[$clog2(WIDTH)-1:0];
    assign slt_res = {{(WIDTH-1){1'b0}}, ($signed(op_a) < $signed(op_b))};
    assign mul_res = op_a * op_b;
    assign div_res = (op_b != 0) ? (op_a / op_b) : {WIDTH{1'b0}};

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= ST_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        ready = 1'b0;
        unique case (state)
            ST_IDLE: begin
                if (valid) begin
                    next_state = ST_EXEC;
                end
            end
            ST_EXEC: begin
                next_state = ST_DONE;
            end
            ST_DONE: begin
                ready = 1'b1;
                if (!valid) begin
                    next_state = ST_IDLE;
                end else begin
                    next_state = ST_EXEC;
                end
            end
        endcase
    end

    always_comb begin
        result_reg = {WIDTH{1'b0}};
        unique case (opcode)
            OPCODE_ADD: result_reg = add_res;
            OPCODE_SUB: result_reg = sub_res;
            OPCODE_AND: result_reg = and_res;
            OPCODE_OR:  result_reg = or_res;
            OPCODE_XOR: result_reg = xor_res;
            OPCODE_SLL: result_reg = sll_res;
            OPCODE_SRL: result_reg = srl_res;
            OPCODE_SRA: result_reg = sra_res;
            OPCODE_SLT: result_reg = slt_res;
            OPCODE_MUL: result_reg = mul_res;
            OPCODE_DIV: result_reg = div_res;
            default:    result_reg = {WIDTH{1'b0}};
        endcase
    end

    assign alt_drive = {WIDTH{1'b0}};

    assign result = result_reg;
    assign result = alt_drive;

endmodule