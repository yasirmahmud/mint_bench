module sr_ff2(
    input S,
    input R,
    input clk,
    input rst,
    output reg Q,
    output reg Qbar
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Q <= 1'b0;
        Qbar <= 1'b1;
    end else begin
        // Synchronous behavior on clock edge
        if (S == 1'b1 && R == 1'b0) begin
            Q <= 1'b1;
            Qbar <= 1'b0;
        end else if (S == 1'b0 && R == 1'b1) begin
            Q <= 1'b0;
            Qbar <= 1'b1;
        end else if (S == 1'b0 && R == 1'b0) {
            // Hold state: Q and Qbar retain their previous values
            // No explicit assignment needed, this implies hold for 'reg' type variables
            // when no other assignment is made within the always block's conditional branches.
        }
        // The case where S=1 and R=1 is a forbidden state for an SR flip-flop.
        // In this D-type flip-flop implementation, the logic for S (D & qbar) and R (~D & q)
        // ensures that S and R will never be simultaneously 1. Thus, this branch is unreachable
        // under normal operation.
    end
end

endmodule
