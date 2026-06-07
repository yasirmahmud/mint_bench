module curve_w502_20260111_115546_attempt7 (
    input wire d,
    input wire en,
    output reg q
);

    // This always block implements a D-latch. The W502 rule is triggered
    // when a signal is modified inside an always block, particularly when it's
    // explicitly assigned its own value, often to manage a latch or prevent inference.
    // Here, 'q = q;' explicitly assigns 'q' to itself, making it a target for W502.
    // This example is distinct from previous attempts by using a combinational always block
    // with blocking assignments (`=`) in the 'else' branch, mirroring the behavior
    // seen in the successful context examples for W502.
    always @(d or en or q) begin
        if (en) begin
            q = d;
        end else begin
            // Target for W502: The signal 'q' is explicitly modified with its own value
            // inside this always block.
            q = q; 
        end
    end

endmodule
