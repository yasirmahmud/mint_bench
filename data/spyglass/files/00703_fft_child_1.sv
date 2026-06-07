module fft  (
    input clk,
    input reset,
    input signed [15:0] x_real,
    input signed [15:0] x_imag,
    output reg signed [15:0] y_real,
    output reg signed [15:0] y_imag
);

    // Number of points (N)
    parameter N = 4;
    
    // Twiddle factors
    wire signed [15:0] twiddle_real [0:N-1]; // Changed from N/2-1 to N-1 to support k up to N-1
    wire signed [15:0] twiddle_imag [0:N-1]; // Changed from N/2-1 to N-1 to support k up to N-1
    
    // Define the twiddle factors for N=4 (W_N^k = cos(2*pi*k/N) - j*sin(2*pi*k/N))
    assign twiddle_real[0] = 16'd1;  // W_4^0 = 1 + j0
    assign twiddle_imag[0] = 16'd0;
    assign twiddle_real[1] = 16'd0;  // W_4^1 = 0 - j1
    assign twiddle_imag[1] = -16'd1;
    assign twiddle_real[2] = -16'd1; // W_4^2 = -1 + j0
    assign twiddle_imag[2] = 16'd0;
    assign twiddle_real[3] = 16'd0;  // W_4^3 = 0 + j1
    assign twiddle_imag[3] = 16'd1;
    
    // Input and output arrays
    reg signed [15:0] x_real_arr [0:N-1];
    reg signed [15:0] x_imag_arr [0:N-1];
    reg signed [15:0] y_real_arr [0:N-1];
    reg signed [15:0] y_imag_arr [0:N-1];
    
    integer i, j, k;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < N; i = i + 1) begin
                x_real_arr[i] <= 16'd0;
                x_imag_arr[i] <= 16'd0;
                y_real_arr[i] <= 16'd0;
                y_imag_arr[i] <= 16'd0;
            end
        end else begin
            // Load input values
            // NOTE: The original code only loads the first input sample into x_real_arr[0] and x_imag_arr[0].
            // For a full N-point FFT, all N input samples would typically need to be loaded.
            // This behavior is preserved as it is not a linting violation related to array indexing.
            x_real_arr[0] <= x_real;
            x_imag_arr[0] <= x_imag;
            
            // Compute FFT
            // NOTE: The current implementation attempts to perform the entire
            // FFT computation within a single clock cycle. Due to the nested loops
            // and non-blocking assignments, for each 'i', y_real_arr[i] and y_imag_arr[i]
            // will effectively receive the value computed during the last iteration of 'j'.
            // This specific functional behavior is preserved as it is not the cause
            // of the reported linting violation.
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N/2; j = j + 1) begin
                    k = (i * j) % N;
                    // The 'k' index for twiddle factors can range from 0 to N-1 (0 to 3 for N=4).
                    // The 'twiddle_real' and 'twiddle_imag' arrays were previously declared with a range of [0:N/2-1],
                    // leading to an out-of-bounds access when k >= N/2. This has been fixed by expanding the array size
                    // and defining the additional twiddle factors.
                    y_real_arr[i] <= x_real_arr[i] + (x_real_arr[j] * twiddle_real[k] - x_imag_arr[j] * twiddle_imag[k]);
                    y_imag_arr[i] <= x_imag_arr[i] + (x_real_arr[j] * twiddle_imag[k] + x_imag_arr[j] * twiddle_real[k]);
                end
            end
            
            // Output results
            y_real <= y_real_arr[0];
            y_imag <= y_imag_arr[0];
        end
    end
endmodule
