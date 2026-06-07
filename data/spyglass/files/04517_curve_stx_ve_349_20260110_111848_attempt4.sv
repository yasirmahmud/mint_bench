module curve_stx_ve_349_20260110_111848_attempt4 (
    input wire clk,
    input wire rst_n,
    input wire enable_processing,
    output reg processing_done
);

reg [2:0] loop_counter;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        processing_done <= 1'b0;
        loop_counter <= 3'b0;
    end else begin
        if (enable_processing) begin
            // The 'for' loop and 'break' statement were introduced in Verilog-2005.
            // When this code is parsed under a Verilog-2001 standard, 'break' is not
            // a recognized keyword. The tool interprets it as an undeclared task or function call.
            for (loop_counter = 0; loop_counter < 4; loop_counter = loop_counter + 1) begin
                if (loop_counter == 2) begin
                    // This 'break;' statement is invalid in Verilog-2001.
                    // It is expected to trigger STX_VE_349 for an undefined task/function.
                    // The violation message might refer to 'break' instead of 'exit'.
                    break;
                end
            end
            processing_done <= 1'b1;
        end else begin
            processing_done <= 1'b0;
            loop_counter <= 3'b0;
        end
    end
end

endmodule
