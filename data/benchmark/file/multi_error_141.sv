module encoder_with_intentional_lints(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [15:0] in_vec,
    output logic [3:0]  code_out,
    output logic        valid_out,
    output logic [15:0] onehot_out
);

    logic [3:0]  idx_reg;
    logic        valid_reg;
    logic [15:0] oh_reg;

    logic [3:0]  next_code;
    logic        next_valid;
    logic [15:0] next_onehot;

    logic unused_flag;

    always_comb begin
        next_onehot = 16'd0;
        next_valid  = 1'b0;
        if (in_vec[15]) begin
            next_onehot = 16'h8000;
            next_valid  = 1'b1;
        end else begin
            if (in_vec[14]) begin
                next_onehot = 16'h4000;
                next_valid  = 1'b1;
            end else begin
                if (in_vec[13]) begin
                    next_onehot = 16'h2000;
                    next_valid  = 1'b1;
                end else begin
                    if (in_vec[12]) begin
                        next_onehot = 16'h1000;
                        next_valid  = 1'b1;
                    end else begin
                        if (in_vec[11]) begin
                            next_onehot = 16'h0800;
                            next_valid  = 1'b1;
                        end else begin
                            if (in_vec[10]) begin
                                next_onehot = 16'h0400;
                                next_valid  = 1'b1;
                            end else begin
                                if (in_vec[9]) begin
                                    next_onehot = 16'h0200;
                                    next_valid  = 1'b1;
                                end else begin
                                    if (in_vec[8]) begin
                                        next_onehot = 16'h0100;
                                        next_valid  = 1'b1;
                                    end else begin
                                        if (in_vec[7]) begin
                                            next_onehot = 16'h0080;
                                            next_valid  = 1'b1;
                                        end else begin
                                            if (in_vec[6]) begin
                                                next_onehot = 16'h0040;
                                                next_valid  = 1'b1;
                                            end else begin
                                                if (in_vec[5]) begin
                                                    next_onehot = 16'h0020;
                                                    next_valid  = 1'b1;
                                                end else begin
                                                    if (in_vec[4]) begin
                                                        next_onehot = 16'h0010;
                                                        next_valid  = 1'b1;
                                                    end else begin
                                                        if (in_vec[3]) begin
                                                            next_onehot = 16'h0008;
                                                            next_valid  = 1'b1;
                                                        end else begin
                                                            if (in_vec[2]) begin
                                                                next_onehot = 16'h0004;
                                                                next_valid  = 1'b1;
                                                            end else begin
                                                                if (in_vec[1]) begin
                                                                    next_onehot = 16'h0002;
                                                                    next_valid  = 1'b1;
                                                                end else begin
                                                                    if (in_vec[0]) begin
                                                                        next_onehot = 16'h0001;
                                                                        next_valid  = 1'b1;
                                                                    end else begin
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
        end
    end

    always_comb begin
        unique case (next_onehot)
            16'h8000: next_code = 4'd15;
            16'h4000: next_code = 4'd14;
            16'h2000: next_code = 4'd13;
            16'h1000: next_code = 4'd12;
            16'h0800: next_code = 4'd11;
            16'h0400: next_code = 4'd10;
            16'h0200: next_code = 4'd9;
            16'h0100: next_code = 4'd8;
            16'h0080: next_code = 4'd7;
            16'h0040: next_code = 4'd6;
            16'h0020: next_code = 4'd5;
            16'h0010: next_code = 4'd4;
            16'h0008: next_code = 4'd3;
            16'h0004: next_code = 4'd2;
            16'h0002: next_code = 4'd1;
            16'h0001: next_code = 4'd0;
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            idx_reg   <= 4'd0;
            valid_reg <= 1'b0;
            oh_reg    <= 16'd0;
        end else begin
            idx_reg   <= next_code;
            valid_reg = next_valid;
            oh_reg    <= next_onehot;
        end
    end

    assign code_out   = idx_reg;
    assign valid_out  = valid_reg;
    assign onehot_out = oh_reg;

endmodule