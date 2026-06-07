module UndrivenInTerm_ML_Module (
    input wire in_val,
    output wire out_val
);

assign in_val = 1'b0; // SpyGlass violation: UndrivenInTerm-ML. An input port is being driven internally.

assign out_val = in_val; // Use in_val to avoid unused signal warning for in_val.

endmodule
