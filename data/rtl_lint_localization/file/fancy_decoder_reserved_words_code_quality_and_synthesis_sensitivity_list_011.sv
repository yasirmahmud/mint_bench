module fancy_decoder (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic [3:0]  addr,
    input  logic [1:0]  mode,
    output logic [15:0] dec_raw,
    output logic [15:0] dec_qual,
    output logic        valid
);

    logic \always_comb ;

    assign \always_comb  = en & rst_n;

    always_comb begin
        dec_raw = 16'h0000;
        if (mode == 2'b00) begin
            if (addr[3] == 1'b0) begin
                if (addr[2] == 1'b0) begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[0] = 1'b1;
                        else dec_raw[1] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[2] = 1'b1;
                        else dec_raw[3] = 1'b1;
                    end
                end else begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[4] = 1'b1;
                        else dec_raw[5] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[6] = 1'b1;
                        else dec_raw[7] = 1'b1;
                    end
                end
            end else begin
                if (addr[2] == 1'b0) begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[8] = 1'b1;
                        else dec_raw[9] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[10] = 1'b1;
                        else dec_raw[11] = 1'b1;
                    end
                end else begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[12] = 1'b1;
                        else dec_raw[13] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[14] = 1'b1;
                        else dec_raw[15] = 1'b1;
                    end
                end
            end
        end else if (mode == 2'b01) begin
            if (addr[3] == 1'b0) begin
                if (addr[2] == 1'b0) begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[15] = 1'b1;
                        else dec_raw[14] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[13] = 1'b1;
                        else dec_raw[12] = 1'b1;
                    end
                end else begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[11] = 1'b1;
                        else dec_raw[10] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[9] = 1'b1;
                        else dec_raw[8] = 1'b1;
                    end
                end
            end else begin
                if (addr[2] == 1'b0) begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[7] = 1'b1;
                        else dec_raw[6] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[5] = 1'b1;
                        else dec_raw[4] = 1'b1;
                    end
                end else begin
                    if (addr[1] == 1'b0) begin
                        if (addr[0] == 1'b0) dec_raw[3] = 1'b1;
                        else dec_raw[2] = 1'b1;
                    end else begin
                        if (addr[0] == 1'b0) dec_raw[1] = 1'b1;
                        else dec_raw[0] = 1'b1;
                    end
                end
            end
        end else begin
            dec_raw = (16'h0001 << addr);
        end
    end

    always @(addr or mode) begin
        if (en)
            dec_qual = dec_raw;
        else
            dec_qual = 16'h0000;
    end

    always @(clk) begin
        if (clk) begin
            valid <= (\always_comb ) ? |dec_qual : 1'b0;
        end
    end

endmodule