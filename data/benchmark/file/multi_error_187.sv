module priority_encoder8 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic        mode,
    input  logic [7:0]  din,
    output logic [2:0]  code,
    output logic        valid,
    output logic [7:0]  onehot,
    output logic        parity,
    output logic        sticky_err
);

    logic [2:0] code_d;
    logic [2:0] code_q;
    logic       valid_d;
    logic       valid_q;
    logic [7:0] onehot_d;
    logic [7:0] onehot_q;
    logic       parity_d;
    logic       parity_q;
    logic       error_d;

    always @(enable or mode) begin
        code_d   = 3'd0;
        valid_d  = 1'b0;
        onehot_d = 8'd0;
        parity_d = 1'b0;
        error_d  = 1'b0;
        if (enable) begin
            if (din != 8'd0) begin
                valid_d = 1'b1;
                if (mode == 1'b0) begin
                    if (din[7]) begin
                        code_d   = 3'd7;
                        onehot_d = 8'b10000000;
                    end else if (din[6]) begin
                        code_d   = 3'd6;
                        onehot_d = 8'b01000000;
                    end else if (din[5]) begin
                        code_d   = 3'd5;
                        onehot_d = 8'b00100000;
                    end else if (din[4]) begin
                        code_d   = 3'd4;
                        onehot_d = 8'b00010000;
                    end else if (din[3]) begin
                        code_d   = 3'd3;
                        onehot_d = 8'b00001000;
                    end else if (din[2]) begin
                        code_d   = 3'd2;
                        onehot_d = 8'b00000100;
                    end else if (din[1]) begin
                        code_d   = 3'd1;
                        onehot_d = 8'b00000010;
                    end else begin
                        code_d   = 3'd0;
                        onehot_d = 8'b00000001;
                    end
                end else begin
                    if (din[0]) begin
                        code_d   = 3'd0;
                        onehot_d = 8'b00000001;
                    end else if (din[1]) begin
                        code_d   = 3'd1;
                        onehot_d = 8'b00000010;
                    end else if (din[2]) begin
                        code_d   = 3'd2;
                        onehot_d = 8'b00000100;
                    end else if (din[3]) begin
                        code_d   = 3'd3;
                        onehot_d = 8'b00001000;
                    end else if (din[4]) begin
                        code_d   = 3'd4;
                        onehot_d = 8'b00010000;
                    end else if (din[5]) begin
                        code_d   = 3'd5;
                        onehot_d = 8'b00100000;
                    end else if (din[6]) begin
                        code_d   = 3'd6;
                        onehot_d = 8'b01000000;
                    end else begin
                        code_d   = 3'd7;
                        onehot_d = 8'b10000000;
                    end
                end
            end else begin
                error_d = 1'b1;
            end
            parity_d = ^onehot_d;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code_q     <= 3'd0;
            valid_q    <= 1'b0;
            onehot_q   <= 8'd0;
            parity_q   <= 1'b0;
            sticky_err <= 1'b0;
        end else begin
            code_q     <= code_d;
            valid_q    <= valid_d;
            onehot_q   <= onehot_d;
            parity_q   <= parity_d;
            sticky_err = sticky_err | error_d;
        end
    end

    assign code   = code_q;
    assign valid  = valid_q;
    assign onehot = onehot_q;
    assign parity = parity_q;

endmodule