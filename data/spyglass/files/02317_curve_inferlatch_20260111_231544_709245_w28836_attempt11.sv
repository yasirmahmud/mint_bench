module lemming (
    input [2:0] data_in,
    input       control_sel,
    output reg  [2:0] ns
);

    // Latch inference occurs because 'ns' is not assigned for all possible
    // values of 'control_sel' within this combinational always block.
    always @(data_in or control_sel) begin
        case (control_sel)
            1'b1: begin
                ns = data_in;
            end
            // When control_sel is 1'b0, 'ns' retains its previous value,
            // leading to the inference of a latch for 'ns[2:0]'.
        endcase
    end

endmodule
