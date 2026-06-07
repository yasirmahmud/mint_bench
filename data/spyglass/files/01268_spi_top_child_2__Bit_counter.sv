module Bit_counter (
    input  wire       BaudRate,
    input  wire       rst,
    output wire [2:0] counter,
    output wire       counter_enable
);
    // W240: Dummy use of inputs
    assign counter = rst ? 3'b0 : (BaudRate ? 3'b1 : 3'b0);
    assign counter_enable = rst | BaudRate;
endmodule
