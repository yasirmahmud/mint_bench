module curve_w362_20260111_132516_attempt1 (
    input [7:0] data_in,
    input [31:0] rmax,
    output result
);

    // W362: For operator (>), left expression: "data_in" width 8 should match right expression: "rmax" width 32
    assign result = (data_in > rmax);

endmodule
