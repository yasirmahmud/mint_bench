module my_module_ex2 (
    input [1:0] sel,
    output reg out
);

always @* begin
    casez (sel) // Changed to casez to correctly interpret 'X' as a don't-care bit
        2'b0X: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
