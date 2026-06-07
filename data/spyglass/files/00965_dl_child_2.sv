module dl (
    input d, en, output reg q
);
    always @(en or d or q) begin
        if (en) begin
            q <= d;
        end else begin
            q <= q; // Explicitly holding the value when en is low to address the InferLatch violation.
        end
    end
endmodule
