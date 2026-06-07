module rr_arbiter4 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  req,
    input  logic [3:0]  lock,
    input  logic [3:0]  urgent,
    output logic [3:0]  grant_onehot,
    output logic [1:0]  grant_idx,
    output logic        grant_valid
);

    logic [1:0] rr_ptr_reg;
    logic [1:0] rr_ptr_next;

    logic [3:0] filtered_req;
    logic [3:0] filtered_urgent;
    logic        choose_use_urgent;

    logic [3:0] grant_onehot_next;
    logic [1:0] grant_idx_next;
    logic        grant_valid_next;

    logic        sample_valid;
    logic [1:0] credit_ctr_reg;
    logic [1:0] credit_ctr_next;

    function automatic logic [3:0] pick_one(
        input logic [3:0] r,
        input logic [1:0] ptr
    );
        logic [3:0] result;
        result = 4'b0;
        case (ptr)
            2'd0: begin
                if (r[0]) result[0] = 1'b1;
                else if (r[1]) result[1] = 1'b1;
                else if (r[2]) result[2] = 1'b1;
                else if (r[3]) result[3] = 1'b1;
            end
            2'd1: begin
                if (r[1]) result[1] = 1'b1;
                else if (r[2]) result[2] = 1'b1;
                else if (r[3]) result[3] = 1'b1;
                else if (r[0]) result[0] = 1'b1;
            end
            2'd2: begin
                if (r[2]) result[2] = 1'b1;
                else if (r[3]) result[3] = 1'b1;
                else if (r[0]) result[0] = 1'b1;
                else if (r[1]) result[1] = 1'b1;
            end
            2'd3: begin
                if (r[3]) result[3] = 1'b1;
                else if (r[0]) result[0] = 1'b1;
                else if (r[1]) result[1] = 1'b1;
                else if (r[2]) result[2] = 1'b1;
            end
        endcase
        return result;
    endfunction

    function automatic logic [1:0] to_idx(
        input logic [3:0] oh
    );
        logic [1:0] idx;
        idx = 2'd0;
        if (oh[0]) idx = 2'd0;
        else if (oh[1]) idx = 2'd1;
        else if (oh[2]) idx = 2'd2;
        else if (oh[3]) idx = 2'd3;
        return idx;
    endfunction

    always_comb begin
        filtered_req      = req;
        filtered_urgent   = urgent & req;
        choose_use_urgent = 1'b0;
        grant_onehot_next = 4'b0;
        grant_idx_next    = 2'd0;
        logic lock_en;
        lock_en = 1'b0;
        if (grant_valid && (|(grant_onehot & lock))) begin
            lock_en = 1'b1;
        end
        if (lock_en) begin
            filtered_req = grant_onehot & req;
        end else begin
            filtered_req = req;
        end
        filtered_urgent   = filtered_req & urgent;
        choose_use_urgent = (|filtered_urgent) & ~( &credit_ctr_reg );
        logic [3:0] chosen;
        chosen = 4'b0;
        if (choose_use_urgent) begin
            chosen = pick_one(filtered_urgent, rr_ptr_reg);
        end else begin
            chosen = pick_one(filtered_req, rr_ptr_reg);
        end
        grant_onehot_next = chosen;
        grant_idx_next    = to_idx(chosen);
        if (|chosen) grant_valid_next = 1'b1;
    end

    always_comb begin
        rr_ptr_next = rr_ptr_reg;
        if (|grant_onehot_next) begin
            rr_ptr_next = to_idx(grant_onehot_next) + 2'd1;
        end
    end

    always_comb begin
        credit_ctr_next = credit_ctr_reg;
        if (sample_valid) begin
            credit_ctr_next = credit_ctr_reg + 2'd1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rr_ptr_reg    <= 2'd0;
            grant_onehot  <= 4'd0;
            grant_idx     <= 2'd0;
            grant_valid   <= 1'b0;
            credit_ctr_reg<= 2'd0;
            sample_valid  <= 1'b0;
        end else begin
            rr_ptr_reg    <= rr_ptr_next;
            grant_onehot  <= grant_onehot_next;
            grant_idx     <= grant_idx_next;
            grant_valid   <= grant_valid_next;
            credit_ctr_reg<= credit_ctr_next;
            sample_valid   = grant_valid_next;
        end
    end

endmodule