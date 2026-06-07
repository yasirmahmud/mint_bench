module curve_synth_5369_20260112_005817_982726_w44756_attempt14 (
    input wire [7:0] data_in,
    output reg [31:0] result_out
);

    // Function to calculate a recursive product (similar to factorial).
    // The recursion depth can exceed 100 if data_in > 100.
    // This is intended to trigger SYNTH_5369.
    function [31:0] compute_recursive_product;
        input [7:0] val_in;
        begin
            if (val_in <= 1) begin
                // Base case: for 0 or 1, the product is typically 1 (e.g., 0! = 1, 1! = 1)
                compute_recursive_product = 32'd1;
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                // due to the potential recursion depth exceeding 100 if val_in
                // is greater than 100.
                compute_recursive_product = val_in * compute_recursive_product(val_in - 1);
            end
        end
    endfunction

    always @(*) begin
        // The output is assigned the result of the recursive function.
        // If data_in is > 100, the recursion depth will exceed the limit.
        result_out = compute_recursive_product(data_in);
    end

endmodule
