module d_ff(
    input D,
    input CLK,
    input RESET,
    output reg Q,
    output reg Qbar
);

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            Q <= 1'b0;
            Qbar <= 1'b1;
        end else begin
            Q <= D;
            Qbar <= ~D;
        end
    end

endmodule
