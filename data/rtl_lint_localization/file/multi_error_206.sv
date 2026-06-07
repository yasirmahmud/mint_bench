module priority_encoder32 (
    input  logic [31:0] din,
    input  logic        enable,
    output logic [4:0]  code,
    output logic        valid,
    output logic [31:0] onehot,
    output logic        none,
    output logic        multi
);

    localparam int W   = 32;
    localparam int LGW = 5;

    logic [W-1:0] din_masked;
    logic [W-1:0] scan_bus;

    logic \always_comb ;
    logic unused_debug;

    function automatic int popcount32 (
        input logic [W-1:0] v
    );
        int pc;
        pc = 0;
        for (int i = 0; i < W; i++) begin
            pc += v[i];
        end
        return pc;
    endfunction

    always_comb begin
        code        = '0;
        valid       = 1'b0;
        onehot      = '0;
        none        = 1'b1;
        multi       = 1'b0;
        \always_comb  = 1'b0;
        din_masked  = '0;
        scan_bus    = '0;

        if (enable) begin
            din_masked = din;
        end else begin
            din_masked = '0;
        end

        scan_bus = din_masked;

        if (scan_bus != '0) begin
            for (int idx = W - 1; idx >= 0; idx--) begin
                if (scan_bus[idx] && !valid) begin
                    valid       = 1'b1;
                    code        = idx[LGW-1:0];
                    onehot[idx] = 1'b1;
                end
            end
        end else begin
            valid  = 1'b0;
            code   = '0;
            onehot = '0;
        end

        multi        = (popcount32(scan_bus) > 1);
        \always_comb  = valid;
        none         = ~\always_comb ;
    end

endmodule