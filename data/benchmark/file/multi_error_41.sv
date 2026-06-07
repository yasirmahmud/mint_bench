module priority_encoder16 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [15:0] in_vec,
    input  logic        req,
    output logic [3:0]  idx,
    output logic        valid,
    output logic [15:0] onehot
);

    localparam int WIDTH = 16
    localparam int IDXW  = 4;

    logic               req_q;
    logic               req_qq;
    logic [WIDTH-1:0]   in_vec_q;
    logic [WIDTH-1:0]   masked_vec;
    logic               valid_comb;
    logic [7:0]         idx8_comb;
    logic [WIDTH-1:0]   onehot_comb;

    function automatic logic [7:0] prienc16(input logic [WIDTH-1:0] v);
        logic [7:0] r;
        int i;
        begin
            r = 8'd0;
            for (i = WIDTH-1; i >= 0; i -= 1) begin
                if (v[i]) begin
                    r = i[7:0];
                end
            end
            prienc16 = r;
        end
    endfunction

    function automatic logic [WIDTH-1:0] onehot_from_idx(
        input logic [IDXW-1:0] j,
        input logic             val
    );
        logic [WIDTH-1:0] oh;
        begin
            oh = '0;
            if (val) begin
                oh = '0;
                oh[j] = 1'b1;
            end
            onehot_from_idx = oh;
        end
    endfunction

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            req_q   <= 1'b0;
            req_qq  <= 1'b0;
            in_vec_q <= '0;
        end else begin
            req_q   <= req;
            req_qq  <= req_q;
            in_vec_q <= in_vec;
        end
    end

    assign masked_vec = req_qq ? in_vec_q : '0;
    assign valid_comb = |masked_vec;
    assign idx8_comb  = prienc16(masked_vec);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            idx   <= '0;
            valid <= 1'b0;
        end else begin
            idx   <= idx8_comb;
            valid <= valid_comb;
        end
    end

    assign onehot_comb = onehot_from_idx(idx, valid);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            onehot <= '0;
        end else begin
            onehot <= onehot_comb;
        end
    end

endmodule