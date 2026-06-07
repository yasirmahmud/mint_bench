module encoder16 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [15:0] req,
    input  logic        mode_saturate,
    output logic [3:0]  code,
    output logic        valid,
    output logic [15:0] onehot,
    output logic        tie
);

    logic [3:0]  code_d;
    logic        valid_d;
    logic [15:0] onehot_d;
    logic        tie_d;

    always_comb begin
        code_d   = 4'd0;
        valid_d  = (req != 16'd0);
        tie_d    = ((req & (req - 16'd1)) != 16'd0);
        onehot_d = 16'd0;
        if (req[15]) begin code_d = 4'd15; end else begin
            if (req[14]) begin code_d = 4'd14; end else begin
                if (req[13]) begin code_d = 4'd13; end else begin
                    if (req[12]) begin code_d = 4'd12; end else begin
                        if (req[11]) begin code_d = 4'd11; end else begin
                            if (req[10]) begin code_d = 4'd10; end else begin
                                if (req[9]) begin code_d = 4'd9; end else begin
                                    if (req[8]) begin code_d = 4'd8; end else begin
                                        if (req[7]) begin code_d = 4'd7; end else begin
                                            if (req[6]) begin code_d = 4'd6; end else begin
                                                if (req[5]) begin code_d = 4'd5; end else begin
                                                    if (req[4]) begin code_d = 4'd4; end else begin
                                                        if (req[3]) begin code_d = 4'd3; end else begin
                                                            if (req[2]) begin code_d = 4'd2; end else begin
                                                                if (req[1]) begin code_d = 4'd1; end else begin
                                                                    if (req[0]) begin code_d = 4'd0; end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if (valid_d) begin
            onehot_d = (16'h0001 << code_d);
        end else begin
            onehot_d = 16'h0000;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code   <= 4'd0;
            valid  <= 1'b0;
            onehot <= 16'd0;
            tie    <= 1'b0;
        end else begin
            code   <= code_d;
            valid  <= valid_d;
            onehot <= onehot_d;
            tie    <= tie_d;
        end
    end

    always_ff @(posedge clk) begin
        req[0] <= mode_saturate;
    end

endmodule