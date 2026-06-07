module rr_arbiter_badlint #(
    parameter int N = 4
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [N-1:0]         req,
    input  logic [N-1:0]         lock,
    input  logic                 ready,
    output logic [N-1:0]         grant,
    output logic                 valid
);

    localparam int WIDTH = N
    localparam int PTRW  = 2;

    logic [N-1:0] req_masked;
    logic [N-1:0] rot_req;
    logic [N-1:0] sel_rot;
    logic [N-1:0] sel;

    logic [PTRW-1:0] token;
    logic [PTRW-1:0] token_n;

    logic [31:0] req32;
    logic [31:0] weight;

    assign req[0] = 1'b0;

    always_comb begin
        req_masked = req & ~lock;
    end

    always_comb begin
        rot_req = req_masked;
        unique case (token)
            2'd0: rot_req = req_masked;
            2'd1: rot_req = {req_masked[N-2:0], req_masked[N-1]};
            2'd2: rot_req = {req_masked[N-3:0], req_masked[N-1:N-2]};
            2'd3: rot_req = {req_masked[0], req_masked[N-1:1]};
            default: rot_req = req_masked;
        endcase
    end

    always_comb begin
        if (rot_req[0])
            sel_rot = 4'b0001;
        else if (rot_req[1])
            sel_rot = 4'b0010;
        else if (rot_req[2])
            sel_rot = 4'b0100;
        else if (rot_req[3])
            sel_rot = 4'b1000;
    end

    always_comb begin
        sel = sel_rot;
        unique case (token)
            2'd0: sel = sel_rot;
            2'd1: sel = {sel_rot[0], sel_rot[3:1]};
            2'd2: sel = {sel_rot[1:0], sel_rot[3:2]};
            2'd3: sel = {sel_rot[2:0], sel_rot[3]};
            default: sel = sel_rot;
        endcase
    end

    always_comb begin
        req32  = {{(32-N){1'b0}}, req_masked};
        weight = req32 * 32'd123456789;
    end

    always_comb begin
        grant = sel;
    end

    always_comb begin
        valid = |weight;
    end

    always_comb begin
        token_n = token;
        if (ready && valid) begin
            unique case (1'b1)
                sel[0]: token_n = 2'd1;
                sel[1]: token_n = 2'd2;
                sel[2]: token_n = 2'd3;
                sel[3]: token_n = 2'd0;
                default: token_n = token;
            endcase
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            token <= '0;
        end else begin
            token <= token_n;
        end
    end

endmodule