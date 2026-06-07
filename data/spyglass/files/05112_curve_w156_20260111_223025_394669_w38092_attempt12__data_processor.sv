module data_processor (
    input [0:7] data_in, // LSB:MSB indexed input
    output [7:0] data_out // MSB:LSB indexed output
);
    assign data_out = data_in; // Simple pass-through
endmodule
