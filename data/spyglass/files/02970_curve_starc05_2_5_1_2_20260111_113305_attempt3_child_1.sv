module curve_starc05_2_5_1_2_20260111_113305_attempt3 (
    input wire data_in,
    input wire enable_a,
    input wire enable_b,
    output wire i2c_sdat
);

    // STARC05-2.5.1.2: Tristate buffer 'i2c_sdat' has logic in enable condition.
    // The enable condition (enable_a && enable_b) is a logical AND expression,
    // not a simple signal, thereby triggering the violation.
    // Resolution: Introduce an intermediate wire for the enable condition.
    wire enable_i2c_sdat;
    assign enable_i2c_sdat = enable_a && enable_b;

    assign i2c_sdat = enable_i2c_sdat ? data_in : 1'bz;

endmodule
