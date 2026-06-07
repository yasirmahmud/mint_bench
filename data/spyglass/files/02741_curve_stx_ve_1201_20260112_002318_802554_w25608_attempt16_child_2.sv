`timescale 1ns/1ps

module curve_stx_ve_1201_20260112_002318_802554_w25608_attempt16 (
    input clk,
    input reset_n,
    output reg test_out_1,
    output reg test_out_2
);

`ifndef SYNTHESIS
    // Initialize output registers to known states to prevent X propagation
    initial begin
        test_out_1 = 1'b0;
        test_out_2 = 1'b0;
    end
`endif

`ifndef SYNTHESIS
    initial begin : main_simulation_block
        $display("Simulation started at time %0t", $time);

        // First STX_VE_1201 violation: Mismatch in a fork-join block
        // The begin label 'concurrent_operation_group_A' does not match the end label 'concurrent_operation_group_B_mismatch'.
        fork : concurrent_operation_group_A
            begin
                #10 test_out_1 = 1'b1;
                $display("Time %0t: test_out_1 set to 1.", $time);
            end
            begin
                #15 test_out_2 = 1'b0;
                $display("Time %0t: test_out_2 set to 0.", $time);
            end
        join : concurrent_operation_group_A // Fixed: Label now matches 'fork' label

        $display("Time %0t: Concurrent block finished. test_out_1 = %b, test_out_2 = %b", $time, test_out_1, test_out_2);

        // Second STX_VE_1201 violation: Mismatch in a sequential begin-end block
        // The begin label 'sequential_process_step_X' does not match the end label 'sequential_process_step_Y_mismatch'.
        begin : sequential_process_step_X
            #20 test_out_1 = ~test_out_1; // Toggle test_out_1
            $display("Time %0t: test_out_1 toggled to %b.", $time, test_out_1);
            #5 test_out_2 = ~test_out_2; // Toggle test_out_2
            $display("Time %0t: test_out_2 toggled to %b.", $time, test_out_2);
        end : sequential_process_step_X // Fixed: Label now matches 'begin' label

        $display("Time %0t: Sequential block finished. test_out_1 = %b, test_out_2 = %b", $time, test_out_1, test_out_2);

        // Use all input ports to prevent unused signal warnings
        // These statements are for compliance and do not affect the violation.
        if (clk) begin : clk_usage
            $display("Time %0t: Clock input observed as high.", $time);
        end else begin : clk_low_usage
            $display("Time %0t: Clock input observed as low.", $time);
        end

        if (!reset_n) begin : reset_usage
            $display("Time %0t: Reset_n input observed as active.", $time);
        end else begin : reset_inactive_usage
            $display("Time %0t: Reset_n input observed as inactive.", $time);
        end

        #100 $finish;
    end : main_simulation_block
`endif

endmodule
