module popcount255  (
    input [254:0] in,
    output reg [7:0] out
);

    integer i;
    reg [7:0] current_count; // Declared outside the always block to resolve STX_VE_479

    always @ (in) begin
        current_count = 0;
        for (i = 0; i < 255; i = i + 1) begin
            if (in[i] == 1'b1) 
                current_count = current_count + 1; // Increment the local variable
        end
        out = current_count; // Assign the final accumulated value to the output once
    end

endmodule
