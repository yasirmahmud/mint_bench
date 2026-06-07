`ifdef SPYGLASS_UNDEFINED
module top_design_unit ();
    // This module is intentionally hidden behind an `ifdef.
    // If 'SPYGLASS_UNDEFINED' is not defined during analysis,
    // SpyGlass will not find any top design unit.
endmodule
