// lshift
module lshift(
    output [31:0] out,
    input  [31:0] high,
    input  [30:0] low,
    input  [4:0]  shifta
);
    // Combines high and low into a 63-bit value, then left shifts and takes MSB 32 bits
    // The max value for shifta [4:0] is 31, so no need for 'shifta >= 32' check.
    wire [62:0] combined_data = {high, low};
    assign out = (combined_data << shifta)[62:31];
endmodule
