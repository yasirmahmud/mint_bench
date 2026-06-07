module curve_w398_20260111_112810_attempt2 (
    input [2:0] selector,
    output reg result_out
);

always @(*) begin
    result_out = 1'b0; 
    casex (selector) 
        3'b0x1: result_out = 1'b1; // Matches 3'b001, 3'b011
        3'b01x: result_out = 1'b0; // Matches 3'b010, 3'b011
        default: result_out = 1'b0;
    endcase
end

endmodule
