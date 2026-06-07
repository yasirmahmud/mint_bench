module T_ff (
    input clk,
    input rstn,
    input T,
    output reg Q
);

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        Q <= 1'b0; // Asynchronous active-low reset
    end else begin
        if (T) begin
            Q <= ~Q; // Toggle when T is high
        end
    end
end

endmodule
