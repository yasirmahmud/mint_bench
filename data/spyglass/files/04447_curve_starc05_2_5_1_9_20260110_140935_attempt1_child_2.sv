module curve_starc05_2_5_1_9_20260110_140935_attempt1 (
    input wire sel,
    input wire data_in,
    output wire tri_out,
    output reg out_reg
);

    // Create a tri-state output signal
    assign tri_out = sel ? data_in : 1'bz;

    // The original casez statement used 'tri_out' in its selection expression,
    // which triggered the STARC05-2.5.1.9 violation. To resolve this, the logic
    // for 'out_reg' is now directly derived from 'sel' and 'data_in', preserving
    // the original functional behavior without using the tri-state signal in the casez/casex selection.
    always @(*) begin
        if (sel == 1'b1) begin
            // When 'sel' is 1, 'tri_out' would be driven by 'data_in'.
            // The original casez statement would assign 'out_reg' based on 'data_in' (0, 1, or X).
            out_reg = data_in;
        end else begin
            // When 'sel' is 0, 'tri_out' would be high-impedance (1'bz).
            // The original default case in the casez statement would set 'out_reg' to 1'bx.
            out_reg = 1'bx;
        end
    end

endmodule
