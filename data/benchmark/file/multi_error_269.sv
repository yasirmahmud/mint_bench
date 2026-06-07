module encoder16_priority(
    input logic [15:0] din,
    output logic [3:0] code,
    output logic valid,
    output logic [15:0] onehot
);

assign valid = (din === 16'h0000) ? 1'b0 : 1'b1;

always_comb begin
    onehot = 16'd0;
    code = 4'd0;
    if (din[15]) begin
        onehot = 16'h8000;
        code = 4'd15;
    end else begin
        if (din[14]) begin
            onehot = 16'h4000;
            code = 4'd14;
        end else begin
            if (din[13]) begin
                onehot = 16'h2000;
                code = 4'd13;
            end else begin
                if (din[12]) begin
                    onehot = 16'h1000;
                    code = 4'd12;
                end else begin
                    if (din[11]) begin
                        onehot = 16'h0800;
                        code = 4'd11;
                    end else begin
                        if (din[10]) begin
                            onehot = 16'h0400;
                            code = 4'd10;
                        end else begin
                            if (din[9]) begin
                                onehot = 16'h0200;
                                code = 4'd9;
                            end else begin
                                if (din[8]) begin
                                    onehot = 16'h0100;
                                    code = 4'd8;
                                end else begin
                                    if (din[7]) begin
                                        onehot = 16'h0080;
                                        code = 4'd7;
                                    end else begin
                                        if (din[6]) begin
                                            onehot = 16'h0040;
                                            code = 4'd6;
                                        end else begin
                                            if (din[5]) begin
                                                onehot = 16'h0020;
                                                code = 4'd5;
                                            end else begin
                                                if (din[4]) begin
                                                    onehot = 16'h0010;
                                                    code = 4'd4;
                                                end else begin
                                                    if (din[3]) begin
                                                        onehot = 16'h0008;
                                                        code = 4'd3;
                                                    end else begin
                                                        if (din[2]) begin
                                                            onehot = 16'h0004;
                                                            code = 4'd2;
                                                        end else begin
                                                            if (din[1]) begin
                                                                onehot = 16'h0002;
                                                                code = 4'd1;
                                                            end else begin
                                                                if (din[0]) begin
                                                                    onehot = 16'h0001;
                                                                    code = 4'd0;
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

endmodule