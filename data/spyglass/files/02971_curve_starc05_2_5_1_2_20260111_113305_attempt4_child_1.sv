module curve_starc05_2_5_1_2_20260111_113305_attempt4 (
    input wire data_in,
    input wire control_a,
    input wire control_b,
    output wire i2c_sdat
);

    // STARC05-2.5.1.2: Tristate buffer 'i2c_sdat' has logic in enable condition.
    // The enable condition (control_a || control_b) is a logical OR expression,
    // not a simple signal, thereby triggering the violation.
    
    // Fix: Introduce an intermediate wire for the enable condition
    wire enable_i2c_sdat;
    assign enable_i2c_sdat = control_a || control_b;
    
    assign i2c_sdat = enable_i2c_sdat ? data_in : 1'bz;

endmodule
