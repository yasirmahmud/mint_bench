`define DEVICE_ID 100
`define DEVICE_ID 200 // WRN_26: Redefinition of macro DEVICE_ID

module curve_wrn_26_20260112_013204_422440_w25608_attempt16 (
    input wire clk,
    input wire rst_n,
    input wire din,
    output reg dout
);

    // Using the macro avoids unused warnings. It will take the last defined value (200).
    parameter SYSTEM_ID = `DEVICE_ID;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dout <= 1'b0;
        end else begin
            // Simple pass-through or capture logic
            dout <= din;
        end
    end

endmodule
