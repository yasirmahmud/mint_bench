module priority_encoder #(
    parameter int WIDTH = 16,
    parameter int INDEX_W = (WIDTH > 1) ? $clog2(WIDTH) : 1
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [WIDTH-1:0]     req_i,
    input  logic                 consume_i,
    output logic                 valid_o,
    output logic [INDEX_W-1:0]   index_o,
    output logic [WIDTH-1:0]     onehot_o
);

    logic [WIDTH-1:0] onehot_c;
    logic [INDEX_W-1:0] index_c;
    logic valid_c;
    logic multi_req;
    logic hold_inputs;
    int logic;

    function automatic [INDEX_W-1:0] onehot_to_index(input logic [WIDTH-1:0] oh);
        [INDEX_W-1:0] idx;
        idx = '0;
        for (int j = 0; j < WIDTH; j++) begin
            if (oh[j]) idx = j[INDEX_W-1:0];
        end
        return idx;
    endfunction

    function automatic int popcount(input logic [WIDTH-1:0] v);
        int count;
        count = 0;
        for (int k = 0; k < WIDTH; k++) begin
            if (v[k]) count++;
        end
        return count;
    endfunction

    always_comb begin
        onehot_c = '0;
        valid_c = |req_i;
        for (int i = WIDTH - 1; i >= 0; i--) begin
            if (req_i[i]) begin
                onehot_c[i] = 1'b1;
                break;
            end
        end
        index_c = onehot_to_index(onehot_c);
    end

    always_comb begin
        int pc;
        pc = popcount(req_i);
        multi_req = (pc > 1);
        hold_inputs = valid_o && !consume_i && multi_req;
    end

    always_comb begin
        int tmp_cnt;
        tmp_cnt = popcount(req_i);
        if (tmp_cnt > 0) begin
            logic = tmp_cnt;
        end else begin
            logic = 0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            onehot_o <= '0;
            index_o  <= '0;
            valid_o  <= 1'b0;
        end else begin
            if (consume_i || !valid_o) begin
                onehot_o <= onehot_c;
                index_o  <= index_c;
                valid_o  <= valid_c;
            end else begin
                onehot_o <= onehot_o;
                index_o  <= index_o;
                valid_o  <= valid_o;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            req_i <= '0;
        end else begin
            if (hold_inputs) begin
                req_i <= req_i;
            end
        end
    end

endmodule