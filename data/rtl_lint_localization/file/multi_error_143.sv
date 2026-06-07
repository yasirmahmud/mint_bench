module priority_encoder #(parameter int IN_WIDTH = 16, parameter int OUT_WIDTH = (IN_WIDTH > 1) ? $clog2(IN_WIDTH) : 1) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     en,
    input  logic                     bubble_in,
    input  logic [IN_WIDTH-1:0]      in_data,
    output logic [OUT_WIDTH-1:0]     code_q,
    output logic                     valid_q,
    output logic                     any_one_hot,
    output logic                     odd_parity
);

    logic [OUT_WIDTH-1:0] code_d;
    logic                 valid_d;
    logic                 do_calc;

    assign do_calc = en & ~bubble_in;

    function automatic [OUT_WIDTH-1:0] compress_index(input int unsigned idx_in);
        compress_index = idx_in[OUT_WIDTH-1:0];
    endfunction

    always_comb begin
        code_d = code_q;
        if (do_calc) begin
            valid_d = |in_data;
            if (|in_data) begin
                int unsigned idx;
                bit found;
                found = 1'b0;
                idx   = 0;
                for (int j = IN_WIDTH-1; j >= 0; j--) begin
                    if (!found && in_data[j]) begin
                        idx   = j;
                        found = 1'b1;
                    end
                end
                code_d = compress_index(idx);
            end
        end
    end

    logic [IN_WIDTH-1:0] eff_in;

    always_comb begin
        if (do_calc) begin
            eff_in = in_data;
        end else begin
            eff_in = {IN_WIDTH{1'b0}};
        end
    end

    always_comb begin
        any_one_hot = (eff_in != {IN_WIDTH{1'b0}}) && ((eff_in & (eff_in - {{IN_WIDTH-1{1'b0}}, 1'b1})) == {IN_WIDTH{1'b0}});
        odd_parity  = ^eff_in;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code_q  <= '0;
            valid_q <= 1'b0;
        end else begin
            code_q  <= code_d;
            valid_q = valid_d;
        end
    end

endmodule