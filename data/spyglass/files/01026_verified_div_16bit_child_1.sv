module verified_div_16bit(
    input wire [15:0] A,
    input wire [7:0] B,
    output wire [15:0] result,
    output wire [15:0] odd
    );

reg [15:0] a_reg;
reg [15:0] b_reg;
reg [31:0] tmp_a;
reg [31:0] tmp_b;
integer i;

always@(*) begin
    a_reg = A;
    b_reg = B;
end

always@(*) begin
    // Use local temporary registers to perform the iterative calculation.
    // This ensures that the module-level 'tmp_a' and 'tmp_b' are assigned only once
    // within this always block, resolving W415a violations by preventing multiple
    // assignments to the same 'reg' variable within a single combinatorial block.
    reg [31:0] loop_remainder_quotient;
    reg [31:0] local_divisor_shifted;

    // Initialize the local variables that will be used in the loop.
    loop_remainder_quotient = {16'b0, a_reg};
    local_divisor_shifted = {b_reg, 16'b0};

    // Perform the 16-bit division algorithm using a shift-and-subtract method.
    for(i = 0;i < 16;i = i+1) begin
        reg [31:0] shifted_val = loop_remainder_quotient << 1; // Shift the current remainder/quotient
        // Conditionally subtract the divisor and set the quotient bit (by adding 1 to the LSB)
        if (shifted_val >= local_divisor_shifted) begin
            loop_remainder_quotient = shifted_val - local_divisor_shifted + 1;
        end
        else begin
            loop_remainder_quotient = shifted_val;
        end
    end

    // Assign the final computed results to the module's 'reg' outputs only once.
    tmp_a = loop_remainder_quotient; // 'tmp_a' now holds the final remainder in bits [31:16] and quotient in [15:0]
    tmp_b = local_divisor_shifted;   // 'tmp_b' is assigned once, reflecting the constant divisor used in the loop
end

assign odd = tmp_a[31:16];    // The upper 16 bits of tmp_a represent the remainder
assign result = tmp_a[15:0]; // The lower 16 bits of tmp_a represent the quotient

endmodule
