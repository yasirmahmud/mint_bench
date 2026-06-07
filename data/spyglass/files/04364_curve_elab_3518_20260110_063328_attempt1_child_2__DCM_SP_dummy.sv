`timescale 1ns/1ps

module DCM_SP_dummy (
    input CLKIN,
    output CLKOUT
);
    parameter CLKDV_DIVIDE = 1; // An integer parameter

    // Minimal logic to use ports
    assign CLKOUT = CLKIN;

endmodule
