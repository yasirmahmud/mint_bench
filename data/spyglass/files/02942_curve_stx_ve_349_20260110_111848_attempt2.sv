module curve_stx_ve_349_20260110_111848_attempt2 (
    input wire clk,
    input wire rst_n,
    input wire en,
    output reg out_signal
);

// This always block implements a simple clocked process.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Asynchronous reset condition
        out_signal <= 1'b0;
    end else if (en) begin
        // When 'en' is high, attempt to call an undefined task named 'exit'.
        // This explicit call to 'exit()' without a corresponding task or function definition
        // is expected to trigger the STX_VE_349 violation: "Task or function name ( exit ) not defined".
        exit();
        out_signal <= 1'b1;
    end else begin
        // Default state when 'en' is low
        out_signal <= 1'b0;
    end
end

endmodule
