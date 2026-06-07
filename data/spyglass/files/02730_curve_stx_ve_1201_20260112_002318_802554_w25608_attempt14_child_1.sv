module curve_stx_ve_1201_20260112_002318_802554_w25608_attempt14 (
    input clk,
    input reset,
    output reg out_reg_sync
);

    reg initial_block_val;

    // STX_VE_1201 violation: The begin label 'setup_block_start' does not match the end label 'setup_block_end_mismatch'
    initial begin : setup_block_start
        initial_block_val = 1'b0; // Initialize a register
        #10 initial_block_val = 1'b1; // Change its value
        $display("Setup sequence completed with intentional label mismatch.");
    end : setup_block_start 

    // This always block uses all inputs and internal signals to avoid unused warnings.
    // Its begin/end labels match, so it does not trigger a violation.
    always @(posedge clk or posedge reset) begin : main_sequential_logic
        if (reset) begin
            out_reg_sync <= 1'b0;
        end else begin
            out_reg_sync <= initial_block_val; // Use initial_block_val to avoid unused signal warning
        end
    end : main_sequential_logic

endmodule
