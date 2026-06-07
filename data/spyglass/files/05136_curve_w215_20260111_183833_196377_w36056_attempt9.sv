module curve_w215_20260111_183833_196377_w36056_attempt9 (
    input wire clk,
    input wire rst,
    output reg [3:0] out_data
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_data <= 4'b0;
        end else begin
            // Declare an integer loop variable 'i'. In Verilog-2001, 'integer' variables are typically 32-bit.
            // The SpyGlass W215 rule flags bit selects on integer variables as "Inappropriate bit select for int_bit_sel variable".
            // Each iteration of this loop performs a bit select 'i[0]' on the integer variable 'i'.
            // Since the loop runs 4 times, there will be 4 distinct instances of this bit select,
            // each triggering one W215 violation.
            for (integer i = 0; i < 4; i = i + 1) begin
                out_data[i] <= i[0]; // Triggers W215 for each iteration (4 times in total)
            end
        end
    end

endmodule
