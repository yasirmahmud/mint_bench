module decoder_stage #(parameter int W = 4) (
    input  logic [W-1:0] in_sel,
    input  logic         en,
    output logic [(1<<W)-1:0] onehot
);
    always_comb begin
        onehot = '0;
        if (en) begin
            onehot[in_sel] = 1'b1;
        end
    end
endmodule

module decoder_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic [4:0]  addr_in,
    output logic [31:0] dec_out,
    output logic        valid
);
    logic [4:0] addr_q;
    logic [4:0] addr_d;
    logic       en_q;
    logic       en_d;
    logic       parity;
    logic       en_masked;
    logic [15:0] low_onehot;
    logic [31:0] dec_from_func;
    logic [31:0] dec_shifted;
    logic [31:0] dec_combined;
    logic        temp_var;

    function automatic logic [31:0] onehot32(input logic [4:0] idx);
        logic [31:0] t;
        int k;
        begin
            t = '0;
            for (k = 0; k < 32; k = k + 1) begin
                if (k == idx) begin
                    t[k] = 1'b1;
                end
            end
            onehot32 = t;
        end
    endfunction

    assign temp_var = en;

    decoder_stage #(.W(4)) u_low (.in_sel(addr_q[2:0]), .en(en_q), .onehot(low_onehot));

    always_comb begin
        addr_d = addr_q;
        en_d   = en_q;
        if (!rst_n) begin
            addr_d = '0;
            en_d   = 1'b0;
        end else begin
            addr_d = addr_in;
            en_d   = en;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr_q <= '0;
            en_q   <= 1'b0;
        end else begin
            addr_q <= addr_d;
            en_q   <= en_d;
        end
    end

    always_comb begin
        parity       = ^addr_q;
        en_masked    = en_q & ~parity & temp_var;
        dec_from_func = onehot32(addr_q);
        dec_shifted  = '0;
        if (en_masked) begin
            if (addr_q[4]) begin
                dec_shifted[31:16] = low_onehot;
            end else begin
                dec_shifted[15:0]  = low_onehot;
            end
        end
        dec_combined = dec_shifted | (dec_from_func & {32{en_masked}});
        dec_out      = dec_combined;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid <= 1'b0;
        end else begin
            valid <= en_masked;
        end
    end
endmodule