module ComplexDecoder (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic [7:0]  in_data,
    input  logic [1:0]  mode_sel,
    output logic [15:0] out_lines,
    output logic        valid
);

    logic [1:0]  mode_reg;
    logic [3:0]  idx;
    logic        parity;
    logic [15:0] decode_temp;
    wire  [15:0] decode_a;
    logic [15:0] decode_b;
    logic [15:0] mask;

    always @(posedge clk or negedge rst_n or posedge enable) begin
        if (!rst_n) begin
            mode_reg <= 2'b00;
        end else if (enable) begin
            mode_reg <= mode_sel;
        end else begin
            mode_reg <= mode_reg;
        end
    end

    always_comb begin
        parity = ^in_data;
    end

    always_comb begin
        idx = 4'd0;
        if (enable) begin
            if (in_data[7]) begin
                if (in_data[6]) begin
                    if (in_data[5]) begin
                        idx = 4'd15;
                    end else begin
                        if (in_data[4]) begin
                            idx = 4'd14;
                        end else begin
                            if (in_data[3]) begin
                                idx = 4'd13;
                            end else begin
                                if (in_data[2]) begin
                                    idx = 4'd12;
                                end else begin
                                    idx = 4'd11;
                                end
                            end
                        end
                    end
                end else begin
                    if (in_data[5]) begin
                        if (in_data[4]) begin
                            idx = 4'd10;
                        end else begin
                            if (in_data[3]) begin
                                idx = 4'd9;
                            end else begin
                                if (in_data[2]) begin
                                    idx = 4'd8;
                                end else begin
                                    idx = 4'd7;
                                end
                            end
                        end
                    end else begin
                        if (in_data[4]) begin
                            if (in_data[3]) begin
                                idx = 4'd6;
                            end else begin
                                if (in_data[2]) begin
                                    idx = 4'd5;
                                end else begin
                                    if (in_data[1]) begin
                                        idx = 4'd4;
                                    end else begin
                                        idx = 4'd3;
                                    end
                                end
                            end
                        end else begin
                            if (in_data[3]) begin
                                if (in_data[2]) begin
                                    idx = 4'd2;
                                end else begin
                                    idx = 4'd1;
                                end
                            end else begin
                                idx = 4'd0;
                            end
                        end
                    end
                end
            end else begin
                if (in_data[6]) begin
                    if (in_data[5]) begin
                        idx = 4'd15;
                    end else begin
                        if (in_data[4]) begin
                            idx = 4'd14;
                        end else begin
                            if (in_data[3]) begin
                                idx = 4'd13;
                            end else begin
                                if (in_data[2]) begin
                                    idx = 4'd12;
                                end else begin
                                    idx = 4'd11;
                                end
                            end
                        end
                    end
                end else begin
                    if (in_data[5]) begin
                        if (in_data[4]) begin
                            idx = 4'd10;
                        end else begin
                            idx = 4'd9;
                        end
                    end else begin
                        if (in_data[3]) begin
                            idx = 4'd8;
                        end else begin
                            if (in_data[2]) begin
                                idx = 4'd7;
                            end else begin
                                if (in_data[1]) begin
                                    idx = 4'd2;
                                end else begin
                                    idx = 4'd0;
                                end
                            end
                        end
                    end
                end
            end
        end else begin
            idx = 4'd0;
        end
    end

    always_comb begin
        decode_temp = 16'h0000;
        decode_temp[idx] = 1'b1;
    end

    assign decode_a = 16'h0000;
    assign decode_a = decode_temp;

    always_comb begin
        mask = 16'hFFFF;
        case (mode_reg)
            2'b00: begin
                mask = 16'hFFFF;
            end
            2'b01: begin
                mask = {8'hFF, {8{parity}}};
            end
            2'b10: begin
                mask = 16'h00FF;
            end
            default: begin
                mask = 16'hF0F0;
            end
        endcase
        decode_b = decode_temp & mask;
    end

    always_comb begin
        valid = enable & (|in_data);
    end

    always_comb begin
        out_lines = decode_a | decode_b;
    end

endmodule