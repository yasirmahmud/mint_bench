module curve_w480_20260111_114952_attempt3 (
    input [7:0] data_in,
    output reg [3:0] count_out
);

    // W480 violation fixed: Loop index 'i' is now of type integer.
    integer i; 

    always @(*) begin
        count_out = 4'b0; // Initialize combinational output
        // For-loop using the integer index 'i'
        for (i = 0; i < 8; i = i + 1) begin 
            if (data_in[i]) begin
                count_out = count_out + 1;
            end
        end
    end

endmodule
