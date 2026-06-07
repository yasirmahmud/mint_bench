module rshifter (
    output [31:0] rshiftout,
    output sticky,
    input  [30:0] high,
    input  [31:0] low,
    input  stin,
    input   [4:0] saout
);
    wire [62:0] combined_in = {high, low};
    reg  [62:0] shifted_val;
    reg          temp_sticky_or;

    always @(*) begin
        shifted_val = combined_in >> saout;
        temp_sticky_or = 1'b0;
        if (saout > 0) begin
            for (int i = 0; i < saout; i = i + 1) begin
                temp_sticky_or = temp_sticky_or | combined_in[i];
            end
        end
    end

    assign sticky = stin | temp_sticky_or;
    assign rshiftout = shifted_val[31:0];
endmodule
