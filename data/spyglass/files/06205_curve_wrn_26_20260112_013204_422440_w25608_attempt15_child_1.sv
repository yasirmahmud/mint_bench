`define SETUP_TIME 12

module curve_wrn_26_20260112_013204_422440_w25608_attempt15 (
    input wire clk,
    input wire rst_n,
    input wire data_in,
    output reg data_out
);

    // Using the macro avoids unused warnings. It will take the last defined value (12).
    parameter DELAY_CYCLES = `SETUP_TIME;

    reg [3:0] counter; // Sized to comfortably hold DELAY_CYCLES up to 15

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 4'b0;
            data_out <= 1'b0;
        end else begin
            if (counter == DELAY_CYCLES - 1) begin
                counter <= 4'b0;
                data_out <= data_in; // Pass input data after DELAY_CYCLES
            end else {
                counter <= counter + 1;
            }
        end
    end

endmodule
