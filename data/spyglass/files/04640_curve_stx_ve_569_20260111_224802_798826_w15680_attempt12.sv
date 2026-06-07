module curve_stx_ve_569_20260111_224802_798826_w15680_attempt12 (
    input [1:0] sel,
    input       data_a,
    input       data_b,
    output reg  result
);

always @* begin
    case (sel)
        2'b00: begin
            result = data_a;
        end // Closes the begin block for 2'b00
        2'b01: begin
            result = data_b;
            // The 'end' keyword for this 'begin' block (2'b01) is missing here.
            // SpyGlass STX_VE_569 will be triggered when 'endcase' is encountered
            // because the 'begin' for 2'b01 is still open.
        // Missing 'end' for '2'b01: begin'
    endcase // Expected STX_VE_569 violation point due to unclosed 'begin'
end // Closes the always @* begin block
endmodule
