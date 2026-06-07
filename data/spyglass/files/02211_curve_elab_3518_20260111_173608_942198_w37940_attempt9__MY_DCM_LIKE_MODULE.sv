module MY_DCM_LIKE_MODULE (
    input clk_in,
    output clk_out
);
    parameter MY_DIVIDER = 2; // Default integer value

    reg [3:0] counter = 4'd0;
    reg divided_clk = 1'b0;

    always @(posedge clk_in) begin
        if (counter >= MY_DIVIDER - 1) begin
            divided_clk <= ~divided_clk;
            counter <= 4'd0;
        end else begin
            counter <= counter + 4'd1;
        end
    end

    assign clk_out = divided_clk;

endmodule
