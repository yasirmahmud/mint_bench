module curve_wrn_64_20260111_181106_154939_w53504_attempt8 (
    input [3:0] data_in,
    output out1,
    output out2,
    output [3:0] valid_out
);

    // WRN_64: Part-select is out-of-range
    // This module is designed to trigger two distinct WRN_64 violations.

    // 1. Valid use of 'data_in':
    // This assignment fully consumes 'data_in' within its valid range [3:0],
    // preventing the W240 (unused input) warning seen in previous attempts.
    assign valid_out = data_in;

    // 2. WRN_64 occurrence 1 (high index out of range):
    // 'data_in' is a 4-bit vector (indices 3 down to 0). Attempting to access
    // bit '4' (data_in[4]) is out of range as '4' is greater than the MSB '3'.
    // This will trigger one WRN_64 violation.
    assign out1 = data_in[4];

    // 3. WRN_64 occurrence 2 (low index out of range):
    // Attempting to access bit '-1' (data_in[-1]) is out of range as '-1' is
    // less than the LSB '0'.
    // This will trigger a second, distinct WRN_64 violation.
    assign out2 = data_in[-1];

endmodule
