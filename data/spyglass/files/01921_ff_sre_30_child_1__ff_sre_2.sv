module ff_sre (
        output reg q,
        input      d,
        input      en,
        input      rst_l,
        input      clk
    );

    always @(posedge clk or negedge rst_l) begin
        if (!rst_l) begin
            q <= 1'b0;
        end else if (en) begin
            q <= d;
        end
    end

    endmodule
