module alu_core #(parameter WIDTH = 32) (
    input  logic                 clk,
    input  logic                 rst,
    input  logic                 start,
    input  logic [2:0]           op_sel,
    input  logic [WIDTH-1:0]     a,
    input  logic [WIDTH-1:0]     b,
    output logic [WIDTH-1:0]     result,
    output logic                 valid,
    output logic                 busy
);

    typedef enum logic [1:0] { IDLE = 2'd0, BUSY = 2'd1, DONE = 2'd2, ERR = 2'd3 } state_t;
    state_t state;
    state_t next_state;

    localparam logic [2:0]
        OP_ADD = 3'd0,
        OP_SUB = 3'd1,
        OP_AND = 3'd2,
        OP_OR  = 3'd3,
        OP_XOR = 3'd4,
        OP_MUL = 3'd5,
        OP_SLT = 3'd6;

    logic [WIDTH-1:0] a_lat;
    logic [WIDTH-1:0] b_lat;
    logic [2:0]       op_lat;
    logic [WIDTH-1:0] alu_res;
    logic             op_done;
    logic [WIDTH:0]   add_ext;
    logic [WIDTH:0]   sub_ext;

    assign busy = (state == BUSY);

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        unique case (state)
            IDLE: if (start) next_state = BUSY;
            BUSY: if (op_done) next_state = DONE; else next_state = BUSY;
            DONE: next_state = IDLE;
            ERR:  next_state = ERR;
        endcase
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            a_lat  <= '0;
            b_lat  <= '0;
            op_lat <= OP_ADD;
        end else if (state == IDLE && start) begin
            a_lat  <= a;
            b_lat  <= b;
            op_lat <= op_sel;
        end
    end

    always_comb begin
        add_ext = {1'b0, a_lat} + {1'b0, b_lat};
        sub_ext = {1'b0, a_lat} - {1'b0, b_lat};
    end

    always_comb begin
        alu_res = '0;
        unique case (op_lat)
            OP_ADD: alu_res = add_ext[WIDTH-1:0];
            OP_SUB: alu_res = sub_ext[WIDTH-1:0];
            OP_AND: alu_res = a_lat && b_lat;
            OP_OR:  alu_res = a_lat | b_lat;
            OP_XOR: alu_res = a_lat ^ b_lat;
            OP_MUL: alu_res = a_lat * b_lat;
            OP_SLT: alu_res = ($signed(a_lat) < $signed(b_lat)) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
            default: alu_res = '0;
        endcase
    end

    assign op_done = 1'b1;

    always_ff @(posedge clk) begin
        if (rst) begin
            result <= '0;
            valid  <= 1'b0;
        end else begin
            if (state == BUSY) begin
                result <= alu_res;
            end
            if (state == DONE) begin
                valid <= 1'b1;
            end else if (state == IDLE) begin
                valid <= 1'b0;
            end
        end
    end

endmodule