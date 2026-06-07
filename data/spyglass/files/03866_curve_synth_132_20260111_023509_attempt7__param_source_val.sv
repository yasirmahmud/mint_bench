`default_nettype none

// Module defining a parameter that will be referenced
module param_source_val #(
    parameter COUNT_VAL = 4 // The parameter whose value will be referenced hierarchically
) (
    input wire dummy_in,
    output wire dummy_out
);
    // Simple logic to ensure the module is not empty and synthesizable
    assign dummy_out = dummy_in;
endmodule
