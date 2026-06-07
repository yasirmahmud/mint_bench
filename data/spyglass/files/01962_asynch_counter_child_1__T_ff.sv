module T_ff (
    input clk,
    input rstn,
    input T,
    output reg Q
);
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            Q <= 1'b0;
        end else if (T) begin
            Q <= !Q;
        end
    end
endmodule
