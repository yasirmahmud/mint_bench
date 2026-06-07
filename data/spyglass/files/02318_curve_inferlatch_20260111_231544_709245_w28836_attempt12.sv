module lemming (
    input [2:0] data_in,
    input       control_sel,
    output reg  [2:0] ns
);

    // Latch is inferred for 'ns[2:0]' because it is only assigned
    // when 'control_sel' is high, and retains its value otherwise.
    always @(data_in or control_sel) begin
        if (control_sel == 1'b1) begin
            ns = data_in;
        end
        // No else branch for 'ns' means it holds its previous value
        // when 'control_sel' is 0, thus inferring a latch.
    end

endmodule
