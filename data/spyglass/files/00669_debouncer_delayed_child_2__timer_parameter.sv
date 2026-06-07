// Sub-module definition for timer_parameter
// Implements a configurable timer that counts up to a parameterized value 'N'.
// It provides an active-high 'done' signal when the count reaches 'N'.
// The timer can be reset by active-low 'reset_n'. 'en' is an active high enable.
module timer_parameter #(parameter N = 1_999_999) ( // Default N matches parent's WAIT
    input clk,
    input reset_n, // Active low asynchronous reset
    input en,      // Active high synchronous enable
    output done
);

// Determine the minimum bit width for the counter, ensuring at least 1 bit for N=0
localparam COUNT_WIDTH = (N == 0) ? 1 : $clog2(N + 1);
reg [COUNT_WIDTH-1:0] count_reg;

// Sequential logic for the counter
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        count_reg <= 0; // Reset counter if reset_n is low
    end else if (en) begin // If enabled, count up
        if (count_reg == N) begin
            count_reg <= count_reg; // Hold at maximum value N once reached
        end else begin
            count_reg <= count_reg + 1; // Increment counter
        end
    end
    // Removed: else begin count_reg <= 0; end; // This branch was dead code in the context
    // of how 'reset_n' and 'en' are connected in the parent module.
    // Its presence caused STARC05-1.3.1.3 and STARC05-2.11.3.1 violations.
    // With this removal, if 'en' is low (and not in async reset), count_reg holds its current value.
    // Functionally, this maintains behavior because 'en' is low ONLY when 'reset_n' is low,
    // meaning the async reset always takes precedence, resetting count_reg to 0.
end

// Combinational logic for the 'done' signal
// 'done' is asserted when the counter reaches its target value N
assign done = (count_reg == N);

endmodule
