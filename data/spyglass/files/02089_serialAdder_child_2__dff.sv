// dff module definition
module dff(
    input wire i_clock, // Clock input as per instantiation
    input wire i_reset, // Reset input as per instantiation
    input wire i_data,
    output reg o_data
);

always @(posedge i_clock or negedge i_reset) begin
    if (!i_reset) {
        o_data <= 1'b0;
    } else {
        o_data <= i_data;
    }
end

endmodule
