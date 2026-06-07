module curve_w215_20260111_183833_196377_w36056_attempt7 (
    input wire clk,
    input wire rst,
    output reg [3:0] out_bits
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_bits <= 4'b0;
        end else begin
            // Use a loop to generate exactly 4 W215 violations on the loop variable.
            // The loop variable 'i' is implicitly of type 'integer' when declared directly in a Verilog-2001 for loop.
            // Performing a bit select 'i[0]' on an integer variable is considered inappropriate by SpyGlass W215.
            for (integer i = 0; i < 4; i = i + 1) begin
                out_bits[i] <= i[0]; // Triggers W215 for each iteration (4 times)
            end
        end
    end

endmodule
