module rr_arbiter4(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  req,
    input  logic        lock_i,
    output logic [3:0]  grant,
    output logic        grant_valid,
    output logic [1:0]  grant_idx
);

    logic [1:0] rr_ptr;
    logic [1:0] rr_ptr_next;
    logic [3:0] req_rot;
    logic [3:0] grant_rot;
    logic [3:0] grant_unrotated;
    logic [3:0] next_grant;
    logic        next_valid;
    logic [1:0]  next_idx;
    logic        grant_en;
    logic [3:0]  grant_bypass;
    logic        lock_hold;

    assign grant_en = |req;

    always_comb begin
        case (rr_ptr)
            2'd0: req_rot = {req[3], req[2], req[1], req[0]};
            2'd1: req_rot = {req[2], req[1], req[0], req[3]};
            2'd2: req_rot = {req[1], req[0], req[3], req[2]};
            2'd3: req_rot = {req[0], req[3], req[2], req[1]};
            default: req_rot = req;
        endcase
    end

    always_comb begin
        grant_rot = 4'b0000;
        if (req_rot[3]) begin grant_rot = 4'b1000; end
        else if (req_rot[2]) begin grant_rot = 4'b0100; end
        else if (req_rot[1]) begin grant_rot = 4'b0010; end
        else if (req_rot[0]) begin grant_rot = 4'b0001; end
        else begin grant_rot = 4'b0000; end
    end

    always_comb begin
        case (rr_ptr)
            2'd0: grant_unrotated = grant_rot;
            2'd1: grant_unrotated = {grant_rot[2:0], grant_rot[3]};
            2'd2: grant_unrotated = {grant_rot[1:0], grant_rot[3:2]};
            2'd3: grant_unrotated = {grant_rot[0], grant_rot[3:1]};
            default: grant_unrotated = grant_rot;
        endcase
    end

    always_comb begin
        if (grant_en) next_grant = grant_unrotated;
    end

    always_comb begin
        next_valid = |next_grant;
    end

    always_comb begin
        unique casez (next_grant)
            4'b1???: next_idx = 2'd3;
            4'b01??: next_idx = 2'd2;
            4'b001?: next_idx = 2'd1;
            4'b0001: next_idx = 2'd0;
            default: next_idx = 2'd0;
        endcase
    end

    always_comb begin
        rr_ptr_next = rr_ptr;
        if (!lock_hold && next_valid) begin
            rr_ptr_next = next_idx + 2'd1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rr_ptr <= 2'd0;
        end else begin
            rr_ptr <= rr_ptr_next;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant <= 4'b0000;
        end else if (!lock_hold) begin
            grant <= next_grant;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant_valid <= 1'b0;
            grant_idx   <= 2'd0;
        end else begin
            grant_valid <= next_valid;
            grant_idx   <= next_idx;
        end
    end

    always_comb begin
        unique casez (req)
            4'b1???: grant_bypass = 4'b1000;
            4'b01??: grant_bypass = 4'b0100;
            4'b001?: grant_bypass = 4'b0010;
            4'b0001: grant_bypass = 4'b0001;
            default: grant_bypass = 4'b0000;
        endcase
    end

    assign grant = grant_bypass;

    always @(posedge clk or posedge req[0]) begin
        if (!rst_n) begin
            lock_hold <= 1'b0;
        end else if (lock_i) begin
            lock_hold <= 1'b1;
        end else if (!|req) begin
            lock_hold <= 1'b0;
        end
    end

endmodule