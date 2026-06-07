module curve_w480_20260111_114952_attempt5 (
    input [3:0] data_in,
    output reg [2:0] count_out
);

    // W480 violation: Loop index 'i' is not of type integer.
    // Declaring 'i' as a 'reg' (bit vector) instead of 'integer' type.
    reg [1:0] i; 

    // This combinational block calculates the sum of set bits in data_in.
    // The loop ensures 'i' is used as a loop index, triggering W480.
    // A local 'integer' variable 'temp_sum' is used to accumulate the sum
    // to avoid W415a (multiple assignments to a module-level signal).
    always @* begin
        integer temp_sum; // Declared local to the always block to prevent W415a on it
        temp_sum = 0;

        // The loop iterates 4 times, indexing through data_in.
        // 'i' is declared as a 'reg', triggering the W480 violation.
        for (i = 0; i < 4; i = i + 1) begin
            if (data_in[i]) begin
                temp_sum = temp_sum + 1; // Accumulate in local integer variable
            end
        end
        
        // Assign the final accumulated sum to the output once.
        // This avoids W415a on 'count_out' as it's assigned only at the end.
        count_out = temp_sum;
    end

endmodule
