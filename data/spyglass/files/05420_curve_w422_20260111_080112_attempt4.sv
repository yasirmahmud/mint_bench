module curve_w422_20260111_080112_attempt4 (
    input sys_clk,
    input pulse_event,
    output reg toggle_out
);

// W422: Block might be un-synthesizable by some tool: event control has more than one clock
// This occurs because two distinct edge-sensitive events (sys_clk and pulse_event)
// are used in the sensitivity list of a single always block.
always @(posedge sys_clk or posedge pulse_event) begin
    toggle_out <= ~toggle_out;
end

endmodule
