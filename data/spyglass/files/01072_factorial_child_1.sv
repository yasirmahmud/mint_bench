module factorial(n,result);
input [3:0]n;
output reg [31:0]result;

always @(n) begin
    // Use an iterative approach instead of recursion to resolve synthesis issues.
    // 'integer' for loop variable 'i' is standard practice.
    integer i;
    // 'temp_product' needs to be wide enough to hold intermediate products
    // up to factorial of 15 (which is 1,307,674,368,000, requiring 41 bits).
    // The final result will be truncated to 32 bits as per the 'result' output width.
    reg [40:0] temp_product;

    // Initialize product to 1. This also correctly handles factorial of 0 (0! = 1).
    temp_product = 1;

    // Iterate from 1 up to 'n' to compute the factorial.
    // If n is 0, the loop will not execute, and temp_product (which is 1) will be assigned.
    for (i = 1; i <= n; i = i + 1) begin
        temp_product = temp_product * i;
    end

    // Assign the computed (and potentially truncated) product to the 32-bit result.
    result = temp_product;
end

endmodule
