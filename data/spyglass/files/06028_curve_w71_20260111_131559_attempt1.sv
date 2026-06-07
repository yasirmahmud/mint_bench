module curve_w71_20260111_131559_attempt1 (
    input [1:0] sel,
    input [7:0] in_data,
    output reg [7:0] out_data
);

always @ (*) begin
    // 'out_data' is not assigned before the case statement
    case (sel)
        2'b00: out_data = in_data;
        // 'out_data' is not assigned for sel = 2'b01, 2'b10, 2'b11
        // No 'default' clause is present
    endcase
end

endmodule
