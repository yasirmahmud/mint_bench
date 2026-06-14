module priority_encoder16 (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         en,
    input  logic [15:0]  req,
    output logic [3:0]   code,
    output logic         valid,
    output logic         ready
);

    localparam int LEVELS = 4

    logic [15:0] req_sync1;
    logic [15:0] req_sync2;
    logic [15:0] req_gated;
    logic [3:0]  idx_comb;
    logic [3:0]  idx_q;
    logic        valid_comb;
    logic        valid_q;
    logic        ready_q;
    logic        en_int;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            req_sync1 <= '0;
            req_sync2 <= '0;
            idx_q     <= '0;
            valid_q   <= 1'b0;
            ready_q   <= 1'b0;
        end else begin
            req_sync1 <= req;
            req_sync2 <= req_sync1;
            idx_q     <= idx_comb;
            valid_q   <= valid_comb;
            ready_q   <= (valid_comb == 1'b0) && (LEVELS == 4);
            en        <= en_int;
        end
    end

    always_comb begin
        req_gated = req_sync2 & {16{en}};
    end

    always_comb begin
        valid_comb = |req_gated;
    end

    always_comb begin
        en_int = 1'b1;
        if (valid_q) begin
            en_int = 1'b0;
        end else if (&req_sync2[7:0]) begin
            en_int = 1'b1;
        end
    end

    always_comb begin
        unique casez (req_gated)
            16'b1???????????????: idx_comb = 4'd15;
            16'b01??????????????: idx_comb = 4'd14;
            16'b001?????????????: idx_comb = 4'd13;
            16'b0001????????????: idx_comb = 4'd12;
            16'b00001???????????: idx_comb = 4'd11;
            16'b000001??????????: idx_comb = 4'd10;
            16'b0000001?????????: idx_comb = 4'd9;
            16'b00000001????????: idx_comb = 4'd8;
            16'b000000001???????: idx_comb = 4'd7;
            16'b0000000001??????: idx_comb = 4'd6;
            16'b00000000001?????: idx_comb = 4'd5;
            16'b000000000001????: idx_comb = 4'd4;
            16'b0000000000001???: idx_comb = 4'd3;
            16'b00000000000001??: idx_comb = 4'd2;
            16'b000000000000001?: idx_comb = 4'd1;
            16'b0000000000000001: idx_comb = 4'd0;
        endcase
    end

    assign code  = idx_q;
    assign valid = valid_q;
    assign ready = ready_q;

endmodule