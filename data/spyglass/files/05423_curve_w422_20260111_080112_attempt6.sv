module curve_w422_20260111_080112_attempt6 (
    input clk,
    input rst_n,
    input data_in,
    output reg q_out
);

reg event_flag_reg;

// This block captures 'data_in' on 'clk' or resets asynchronously.
// It correctly handles the asynchronous reset to avoid W442a for this block.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        event_flag_reg <= 1'b0;
    end else begin
        event_flag_reg <= data_in;
    end
end

// W422: Block might be un-synthesizable by some tool: event control has more than one clock
// This 'always' block is intentionally sensitive to two distinct edge-triggered events:
// 'posedge clk' (the main clock) and 'posedge event_flag_reg'.
// 'event_flag_reg' is an internal register, clocked by 'clk' in the previous block.
// The intent is that 'posedge event_flag_reg' constitutes a distinct, though synchronously derived,
// event from 'posedge clk', triggering W422 due to two distinct event controls.
// This setup aims to differentiate from: 
// 1. Direct multiple *independent* clocks (which often trigger STARC05-2.3.3.1) by having
//    'event_flag_reg' be derived from 'clk' itself, potentially making it not a separate 'clock' 
//    domain in the view of STARC05-2.3.3.1.
// 2. Asynchronous resets/sets (which trigger W442a if not handled) as 'posedge event_flag_reg' 
//    is not named or used as a typical reset/set signal, and the action 'q_out <= ~q_out;' 
//    does not imply reset/set behavior.
always @(posedge clk or posedge event_flag_reg) begin
    q_out <= ~q_out; // Toggle 'q_out' to ensure it's used and modified
end

endmodule
