module fibonacci #(parameter N = 10)(
    input wire clk, rst,
    output reg [3:0] out
);
    reg [3:0] out1 [0:N-1]; // This will store the Fibonacci numbers, inferred as registers
    reg [($clog2(N == 0 ? 1 : N)) : 0] i; // Counter for outputting numbers

    // Step 1: Calculate Fibonacci sequence combinatorially.
    // This ensures the Fibonacci values are always available and addresses the sequential dependency
    // required by out1[j] = out1[j-1] + out1[j-2] within a single clock/reset event.
    // The values are pre-calculated before being loaded into the 'out1' registers.
    wire [3:0] fib_calc_val [0:N-1];

    generate
        genvar j;
        for (j = 0; j < N; j = j + 1) begin : fib_calc_gen
            if (j == 0) begin
                assign fib_calc_val[j] = 1;
            end else if (j == 1) begin
                assign fib_calc_val[j] = 1; // Assuming fib(0)=1, fib(1)=1 as per original code initialization
            end else begin
                assign fib_calc_val[j] = fib_calc_val[j-1] + fib_calc_val[j-2];
            end
        end
    endgenerate

    // Step 2 & 3: Handle registers 'out1', 'i', and 'out' in a single always block.
    // This resolves all W336 (blocking assignment) and W415 (multiple drivers for 'i') violations.
    // The description states "calculates the Fibonacci sequence up to N numbers during reset, stores them in an array".
    // This implies that while 'rst' is active, the array 'out1' should be loaded with the sequence.
    // A standard synchronous reset implementation involves loading values on a clock edge when 'rst' is high.
    always @(posedge clk or posedge rst) begin
        integer k; // Declare 'k' here for Verilog-2001 compatibility
        if (rst) begin
            // Reset condition: Load Fibonacci numbers into 'out1' and reset counter 'i'.
            // This loading happens synchronously with 'clk' while 'rst' is asserted high.
            i <= 0;
            out <= 0; // Initialize output to 0 during reset
            for (k = 0; k < N; k = k + 1) begin // 'k' is now declared
                out1[k] <= fib_calc_val[k]; // Non-blocking assignment for register array
            end
        end else begin
            // Normal operation (after reset, on positive clock edge)
            if (i < N) begin
                out <= out1[i]; // Output current Fibonacci number (non-blocking)
                i <= i + 1;     // Increment index for the next number (non-blocking)
            end
            // If i >= N, 'out' and 'i' retain their last values as per original implicit behavior.
        end
    end
endmodule
