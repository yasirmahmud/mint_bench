module curve_stx_ve_481_20260111_210355_776339_w36056_attempt9 (
    input [1:0] sel,
    output reg val
);

always @* begin
    case (sel)
        2'b00: val = 1'b0;
        // The keyword 'else' is illegal here in a case statement. 
        // 'default' should be used for the catch-all condition.
        else begin 
            val = 1'b1;
        end
    endcase
end

endmodule
