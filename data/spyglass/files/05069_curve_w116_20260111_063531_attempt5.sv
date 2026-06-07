module curve_w116_20260111_063531_attempt5 (
    input [15:0] control_word,
    output wire status_alert
);

    // W116: For operator (&), left expression (1 bit) should match right expression (7 bits).
    // Specifically, 'control_word[7]' (1 bit) is ANDed with '(~control_word[6:0])' (7 bits).
    assign status_alert = control_word[7] & (~control_word[6:0]);

endmodule
