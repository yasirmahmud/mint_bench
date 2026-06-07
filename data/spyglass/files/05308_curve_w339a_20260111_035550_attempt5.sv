module curve_w339a_20260111_035550_attempt5 (
    input wire [1:0] in_a,
    input wire [1:0] in_b,
    output wire out_val
);

    reg sim_internal_flag; // Local register for simulation-only use

    // An initial block, especially one not initializing synthesizable memory,
    // is typically ignored by synthesis tools and is considered simulation-only logic.
    // The logic within this block does not contribute to hardware description.
    initial begin
        // W339a violation: Operator '!==' is used.
        // SpyGlass often flags such operators (case equality/inequality)
        // with W339a even in non-synthesizable contexts because the rule is
        // a general design guideline to avoid these operators in RTL meant
        // for synthesis, regardless of immediate synthesizability.
        // The comparison with 2'bXX further emphasizes its simulation-only nature,
        // as 'X' values are not present in physical hardware.
        if (in_a !== 2'bXX) begin // This line targets the W339a violation
            sim_internal_flag = 1'b1;
        end else begin
            sim_internal_flag = 1'b0;
        end
    end

    // The output is driven independently to avoid unused signal warnings
    // and to ensure no synthesizable logic depends on 'sim_internal_flag'.
    assign out_val = 1'b0; // Assign a constant value

endmodule
