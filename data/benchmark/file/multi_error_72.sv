module arbiter4 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  req,
    input  logic [3:0]  lock,
    input  logic [3:0]  mask,
    input  logic        accept,
    output logic [3:0]  grant,
    output logic        valid,
    output logic [1:0]  grant_idx
);

    logic [1:0] token_r;
    logic [1:0] token_n;
    logic [1:0] next_token;

    logic [3:0] req_eff;
    logic [3:0] req_rot;
    logic [3:0] grant_rot;
    logic [3:0] grant_cmb;

    logic [3:0] grant_r;
    logic       valid_r;
    logic [1:0] grant_idx_r;

    logic [1:0] grant_idx_w;
    logic       valid_cmb;
    logic       dec_valid;
    logic       hold_grant;
    logic       accept_eff;

    assign req_eff    = req & ~mask;

    always @* begin
        case (token_r)
            2'd0: req_rot = req_eff;
            2'd1: req_rot = {req_eff[2:0], req_eff[3]};
            2'd2: req_rot = {req_eff[1:0], req_eff[3:2]};
            2'd3: req_rot = {req_eff[0],   req_eff[3:1]};
            default: req_rot = req_eff;
        endcase
    end

    always @* begin
        grant_rot = 4'b0000;
        if (req_rot[0])       grant_rot = 4'b0001;
        else if (req_rot[1])  grant_rot = 4'b0010;
        else if (req_rot[2])  grant_rot = 4'b0100;
        else if (req_rot[3])  grant_rot = 4'b1000;
    end

    always @* begin
        case (token_r)
            2'd0: grant_cmb = grant_rot;
            2'd1: grant_cmb = {grant_rot[2:0], grant_rot[3]};
            2'd2: grant_cmb = {grant_rot[1:0], grant_rot[3:2]};
            2'd3: grant_cmb = {grant_rot[0],   grant_rot[3:1]};
            default: grant_cmb = grant_rot;
        endcase
    end

    assign valid_cmb = |grant_cmb;

    onehot_to_index u_idx (
        .onehot({valid_cmb, grant_cmb}),
        .valid(dec_valid),
        .idx  (grant_idx_w)
    );

    assign hold_grant = valid_r & lock[grant_idx_r];
    assign accept_eff = accept & (dec_valid | valid_cmb);

    always @* begin
        unique case (1'b1)
            grant_cmb[0]: next_token = 2'd1;
            grant_cmb[1]: next_token = 2'd2;
            grant_cmb[2]: next_token = 2'd3;
            grant_cmb[3]: next_token = 2'd0;
            default:      next_token = token_r;
        endcase
    end

    always @* begin
        if (valid_cmb && accept_eff && !hold_grant) token_n = next_token;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            token_r      <= 2'd0;
            grant_r      <= 4'b0000;
            valid_r      <= 1'b0;
            grant_idx_r  <= 2'd0;
        end else begin
            if (!hold_grant) begin
                token_r      <= token_n;
                grant_r      <= grant_cmb;
                valid_r      <= valid_cmb;
                grant_idx_r  <= grant_idx_w;
            end
        end
    end

    assign grant     = grant_r;
    assign valid     = valid_r;
    assign grant_idx = grant_idx_r;

endmodule

module onehot_to_index (
    input  logic [3:0] onehot,
    output logic       valid,
    output logic [1:0] idx
);
    always_comb begin
        valid = |onehot;
        unique casez (onehot)
            4'b0001: idx = 2'd0;
            4'b0010: idx = 2'd1;
            4'b0100: idx = 2'd2;
            4'b1000: idx = 2'd3;
            default: idx = 2'd0;
        endcase
    end
endmodule