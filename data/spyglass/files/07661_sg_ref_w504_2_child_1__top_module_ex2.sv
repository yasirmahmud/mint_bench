module top_module_ex2;
    // Violation W110 (incompatible width) and W287a (undriven) related to int_var.
    // Fix: Change 'int_var' to an 8-bit 'reg' to match child_mod's input width
    // and ensure it is driven.
    reg [7:0] int_var;

    // Drive int_var to resolve W287a (undriven) and ensure in_port is driven (UndrivenInTerm-ML).
    initial begin
        int_var = 8'h00; // Initialize int_var
        #10;
        int_var = 8'hFF; // Drive with a value
        #10;
        int_var = 8'hAA; // Drive with another value
    end

    // The child_mod instance now receives an 8-bit driven signal, resolving W110 and UndrivenInTerm-ML.
    child_mod u_inst (.in_port(int_var));
endmodule
