module my_submodule (
    input wire clk,
    input wire enable,
    output reg result_q
);

    always @(posedge clk) begin
        if (enable) begin
            result_q <= 1'b1;
        end else begin
            result_q <= 1'b0;
        end
    end

endmodule
