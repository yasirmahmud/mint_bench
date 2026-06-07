module curve_w422_20260111_080112_attempt5 (
    input primary_clk,
    input control_event_edge, // An edge-sensitive control signal, not a continuous clock
    output reg data_register
);

// W422: Block might be un-synthesizable by some tool: event control has more than one clock
// This Verilog code triggers W422 by having an 'always' block sensitive to two distinct
// edge-triggered events: 'primary_clk' (a clear clock) and 'control_event_edge'
// (another edge-sensitive signal). Combining these in a single sensitivity list
// is generally considered unsynthesizable as it implies multiple asynchronous
// event sources trying to control the same sequential block.
//
// This attempt aims to trigger W422 while avoiding STARC05-2.3.3.1 and W442a.
// - W442a is avoided because 'control_event_edge' is not named or structured as an
//   asynchronous reset/set, and no such reset logic is implied or expected.
// - The distinction from STARC05-2.3.3.1 (Edges of multiple clocks used in the same always block)
//   relies on the nuance that 'control_event_edge', while being an edge-triggered event,
//   might not be strictly classified as a 'clock' by STARC05-2.3.3.1's specific criteria,
//   whereas W422 is more general about 'event control having more than one clock' where
//   'clock' refers to any significant edge-triggered event causing unsynthesizability.
always @(posedge primary_clk or posedge control_event_edge) begin
    data_register <= !data_register; // Toggle the register to use it
end

endmodule
