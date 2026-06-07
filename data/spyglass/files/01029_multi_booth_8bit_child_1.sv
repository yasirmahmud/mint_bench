module multi_booth_8bit (
    input wire clk,
    input wire reset,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg [15:0] p,
    output reg rdy
);

    reg [7:0] multiplicand_reg;
    reg [7:0] multiplier_reg;
    reg [4:0] count_reg; // 5 bits to count up to 8 iterations (0 to 8)
    reg [16:0] product_reg; // 1 extra bit for sign extension

    // next_booth_code is derived from the current multiplier bits
    wire [1:0] next_booth_code_val = {multiplier_reg[1], multiplier_reg[0]};
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize all registers with asynchronous reset
            product_reg <= 0;
            multiplicand_reg <= a;
            multiplier_reg <= b;
            count_reg <= 0;
            rdy <= 0;
            p <= 0; // Output 'p' must also be reset to a defined value
        end else begin
            // Default assignments to ensure all registers retain their value
            // if not explicitly updated in a given cycle. This prevents latch inference
            // and ensures all registers are always driven in a synchronous block.
            product_reg <= product_reg;
            multiplicand_reg <= multiplicand_reg; // Multiplicand remains constant after initial load
            multiplier_reg <= multiplier_reg;
            count_reg <= count_reg;
            rdy <= 0; // 'rdy' is pulsed, so reset to 0 unless multiplication is complete
            p <= p;   // 'p' holds its value after completion, otherwise retains previous or reset value

            // Perform Booth recoding operation based on current multiplier bits
            // All assignments within the else block are now non-blocking (<=).
            case (next_booth_code_val) 
                2'b01: product_reg <= product_reg + (multiplicand_reg << count_reg);
                2'b10: product_reg <= product_reg - (multiplicand_reg << count_reg);
                default: product_reg <= product_reg; // 2'b00 or 2'b11 means no operation, hold value
            endcase
            
            // Prepare for the next iteration by incrementing count and shifting multiplier
            count_reg <= count_reg + 1; 
            multiplier_reg <= multiplier_reg >> 2; // Shift by 2 for Radix-4 Booth

            // Check if multiplication is complete after 8 iterations
            // count_reg goes from 0 to 7 during the 8 iterations, then increments to 8.
            if (count_reg == 5'd8) begin 
                rdy <= 1; // Assert ready signal
                p <= product_reg[15:0]; // Assign the lower 16 bits of the product to output
            end
        end
    end

endmodule
