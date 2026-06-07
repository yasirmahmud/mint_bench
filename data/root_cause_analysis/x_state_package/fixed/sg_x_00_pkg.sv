package sg_x_pkg;
    // Root X source for this dataset. In the injected variant this is 'x; in the fixed
    // variant it is '0. All downstream reset initializations slice/cast from this.
    localparam logic [31:0] RESET_SEED = '0;
endpackage

