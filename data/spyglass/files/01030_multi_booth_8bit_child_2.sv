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

    // Intermediate next-state registers for W415a resolution
    reg [16:0] product_reg_next;
    reg [7:0] multiplier_reg_next;
    reg [4:0] count_reg_next;
    reg rdy_next;
    reg [15:0] p_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize all registers with asynchronous reset
            product_reg <= 0;
            multiplicand_reg <= a;
            multiplier_reg <= b;
            count_reg <= 0;
            rdy <= 0;
            p <= 0;
        end else begin
            // --- Combinational logic to determine next state values (using blocking assignments) ---
            // Default assignments to hold current value or a known default for all 'next' registers.
            // This ensures each 'next' register is always driven, preventing latches and resolving W415a.
            product_reg_next = product_reg;
            multiplier_reg_next = multiplier_reg;
            count_reg_next = count_reg;
            rdy_next = 0; // 'rdy' is pulsed, so default to 0 unless multiplication is complete
            p_next = p;   // 'p' holds its value after completion, otherwise retains previous or reset value

            // Sign-extended multiplicand for arithmetic operations to match product_reg width
            wire [16:0] signed_multiplicand = {{9{multiplicand_reg[7]}}, multiplicand_reg};

            // Perform Booth recoding operation based on current multiplier bits
            case (next_booth_code_val)
                2'b01: product_reg_next = product_reg + (signed_multiplicand << count_reg);
                2'b10: product_reg_next = product_reg - (signed_multiplicand << count_reg);
                default: ; // 2'b00 or 2'b11 means no operation, product_reg_next retains product_reg (default assignment above)
            endcase

            // Prepare for the next iteration by incrementing count and shifting multiplier
            count_reg_next = count_reg + 1; 
            multiplier_reg_next = multiplier_reg >> 2; // Shift by 2 for Radix-4 Booth

            // Check if multiplication is complete after 8 iterations
            // count_reg goes from 0 to 7 during the 8 iterations, then increments to 8.
            if (count_reg == 5'd8) begin 
                rdy_next = 1; // Assert ready signal
                p_next = product_reg[15:0]; // Assign the lower 16 bits of the product to output
            end

            // --- Apply next state values to registers (using non-blocking assignments) ---
            product_reg <= product_reg_next;
            multiplier_reg <= multiplier_reg_next;
            count_reg <= count_reg_next;
            rdy <= rdy_next;
            p <= p_next;
            // multiplicand_reg is only assigned on reset and then holds its value, so it does not need a '_next' signal
            // nor an explicit assignment in the 'else' block, as it effectively retains its value by not being driven.
        end
    end

endmodule
