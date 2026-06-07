module parallel2serial(
    input wire clk,
    input wire rst_n,
    input wire [3:0] d,
    output reg valid_out,
    output reg dout
);

    // Internal registers
    reg [3:0] data_reg;
    reg [1:0] cnt; // 2-bit counter to handle 4 clock cycles for 4 bits

    // Next-state logic variables
    reg [3:0] next_data_reg;
    reg [1:0] next_cnt;
    reg next_valid_out;
    reg next_dout;

    // Combinational logic to determine next state values
    always @* begin
        // Default assignments to avoid latches. These values are used if no other condition overrides them.
        next_data_reg = data_reg;
        next_cnt = cnt;
        next_valid_out = 1'b0; // Default to low unless explicitly set high
        next_dout = 1'b0;      // Default to low unless explicitly set high

        // Logic for data_reg, cnt, and valid_out based on current state (cnt)
        if (cnt == 2'b11) begin // If counter is 3, indicating the last bit is being outputted, load new data
            next_data_reg = d; // Load the parallel data
            next_cnt = 2'b00; // Reset the counter
            next_valid_out = 1'b1; // Set valid_out high as data is ready to be outputted (for this cycle and the next, if cnt becomes 0)
        end else begin
            next_cnt = cnt + 1; // Increment the counter
            next_data_reg = {data_reg[2:0], 1'b0}; // Shift left the data register
            // Original valid_out logic: `valid_out <= (cnt == 2'b00) ? 1'b1 : 1'b0;`
            // This implies valid_out is high when cnt is 0 in the current cycle.
            // Combining with the `cnt == 2'b11` case, next_valid_out is high if current cnt is 0 or 3.
            if (cnt == 2'b00) begin
                next_valid_out = 1'b1;
            end
        end

        // `dout` assignment: `dout <= data_reg[3];`
        // This means `dout` should output the MSB of the data_reg *after* it has been updated (loaded or shifted).
        // So, `next_dout` reflects `next_data_reg[3]`.
        next_dout = next_data_reg[3];
    end

    // Sequential logic for register updates
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Resetting all registers when rst_n is 0
            data_reg <= 4'b0000;
            cnt <= 2'b00;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            // Update registers with their calculated next state values
            data_reg <= next_data_reg;
            cnt <= next_cnt;
            valid_out <= next_valid_out;
            dout <= next_dout;
        end
    end

endmodule
