module decoder #(
    parameter INSTR_W = 16,
    parameter OPC_W   = 5
) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  wire                      enable,
    input  logic [INSTR_W-1:0]       instr,
    input  logic                     mode,
    output logic [3:0]               op_class,
    output logic [7:0]               ctrl,
    output logic                     valid
);

    logic [OPC_W-1:0] opcode;
    logic [2:0]       func3;
    logic             cond_match;
    logic [7:0]       ctrl_r;
    logic [7:0]       ctrl_next;
    logic [3:0]       op_class_r;
    logic [3:0]       op_class_next;
    logic             valid_r;
    logic             valid_next;
    logic             internal_enable;
    logic \always_comb ;

    always_comb begin
        opcode  = instr[INSTR_W-1 -: OPC_W];
        func3   = instr[14:12];
        cond_match = (func3[2] ^ func3[1]) & mode;
        \always_comb = enable & mode;
        internal_enable = \always_comb;
    end

    assign enable = internal_enable;

    always @(opcode or enable) begin
        ctrl_next      = 8'h00;
        op_class_next  = 4'h0;
        valid_next     = 1'b0;
        if (enable) begin
            unique case (opcode)
                5'b11000: begin
                    op_class_next = 4'hB;
                    ctrl_next     = {4'b1000, 3'b000, cond_match};
                    valid_next    = cond_match;
                end
                5'b00000: begin
                    op_class_next = 4'h2;
                    ctrl_next     = 8'hA4;
                    valid_next    = 1'b1;
                end
                5'b01000: begin
                    op_class_next = 4'h3;
                    ctrl_next     = 8'h58;
                    valid_next    = 1'b1;
                end
                5'b01100: begin
                    op_class_next = 4'h4;
                    ctrl_next     = 8'hC3;
                    valid_next    = 1'b1;
                end
                5'b00100: begin
                    op_class_next = 4'h5;
                    ctrl_next     = 8'h33;
                    valid_next    = 1'b1;
                end
                5'b11100: begin
                    op_class_next = 4'h6;
                    ctrl_next     = 8'h21;
                    valid_next    = 1'b1;
                end
                5'b10100: begin
                    op_class_next = 4'h7;
                    ctrl_next     = 8'h12;
                    valid_next    = 1'b1;
                end
                5'b10011: begin
                    op_class_next = 4'h8;
                    ctrl_next     = 8'h87;
                    valid_next    = 1'b1;
                end
                default: begin
                    op_class_next = 4'h0;
                    ctrl_next     = 8'h00;
                    valid_next    = 1'b0;
                end
            endcase
        end else begin
            op_class_next = 4'h0;
            ctrl_next     = 8'h00;
            valid_next    = 1'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ctrl_r      <= 8'h00;
            op_class_r  <= 4'h0;
            valid_r     <= 1'b0;
        end else begin
            ctrl_r      <= ctrl_next;
            op_class_r  <= op_class_next;
            valid_r     = valid_next;
        end
    end

    always_comb begin
        ctrl     = ctrl_r;
        op_class = op_class_r;
        valid    = valid_r;
    end

endmodule