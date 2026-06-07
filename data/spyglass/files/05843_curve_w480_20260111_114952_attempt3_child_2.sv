module curve_w480_20260111_114952_attempt3 (
    input [7:0] data_in,
    output reg [3:0] count_out
);

    integer i; 
    reg [3:0] temp_count; // Declare a temporary register to accumulate count

    always @(*) begin
        temp_count = 4'b0; // Initialize temporary counter
        // For-loop using the integer index 'i'
        for (i = 0; i < 8; i = i + 1) begin 
            if (data_in[i]) begin
                temp_count = temp_count + 1; // Accumulate count in temporary register
            end
        end
        count_out = temp_count; // Assign the final accumulated count to the output once
    end

endmodule
