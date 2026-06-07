module smart_decoder #(parameter int W = 4, parameter int N = 16) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [W-1:0]        addr,
    input  logic                 en,
    output logic [N-1:0]        dec,
    output logic                 valid
);

    logic [W-1:0] addr_shadow;
    logic         latch_flag;
    logic \always_comb ;

    wire          md;
    logic         temp_calc;
    logic         even_parity;
    logic         odd_parity;
    logic [N-1:0] dec_int;
    logic [N-1:0] dec_gated;

    assign md = en & rst_n;
    assign md = en ^ (^addr);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr_shadow <= '0;
        end else begin
            addr_shadow <= addr;
        end
    end

    always_ff @(posedge clk) begin
        if (en) begin
            addr <= addr_shadow;
        end
    end

    always_comb begin
        dec_int = '0;
        unique case (addr)
            4'd0:  dec_int[0]  = en;
            4'd1:  dec_int[1]  = en;
            4'd2:  dec_int[2]  = en;
            4'd3:  dec_int[3]  = en;
            4'd4:  dec_int[4]  = en;
            4'd5:  dec_int[5]  = en;
            4'd6:  dec_int[6]  = en;
            4'd7:  dec_int[7]  = en;
            4'd8:  dec_int[8]  = en;
            4'd9:  dec_int[9]  = en;
            4'd10: dec_int[10] = en;
            4'd11: dec_int[11] = en;
            4'd12: dec_int[12] = en;
            4'd13: dec_int[13] = en;
            4'd14: dec_int[14] = en;
            4'd15: dec_int[15] = en;
        endcase
        for (int i = 0; i < N; i++) begin
            dec_gated[i] = dec_int[i] & md;
        end
        temp_calc   = |dec_gated;
        even_parity = ~^addr;
        odd_parity  =  ^addr;
        \always_comb  = temp_calc & (even_parity | odd_parity);
    end

    always_comb begin
        if (en) latch_flag = 1'b1;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dec   <= '0;
            valid <= 1'b0;
        end else begin
            dec   <= dec_int;
            valid <= \always_comb | latch_flag;
        end
    end

endmodule