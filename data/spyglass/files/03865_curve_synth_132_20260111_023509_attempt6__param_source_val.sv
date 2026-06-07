`default_nettype none

// Module defining a parameter that will be referenced
module param_source_val #(
    parameter COUNT_VAL = 4 // The parameter whose value will be referenced hierarchically
) ();
    // This module is intentionally simple as its only purpose is to define a parameter
    // that can be referenced from another scope.
endmodule
