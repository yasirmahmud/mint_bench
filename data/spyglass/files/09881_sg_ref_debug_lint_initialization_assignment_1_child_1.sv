module debug_init_assign_ex1 (
    output reg [7:0] data_bus = 8'hF0 // Initialize directly as output reg
);
    // The original initial block assignments result in data_bus = 8'hF0:
    // data_bus = 8'hFF (1111_1111)
    // data_bus[3:0] = 4'h0 (xxxx_0000)
    // Resulting in data_bus = 8'hF0 (1111_0000)
    // This direct initialization of the output register resolves SYNTH_5143 (initial block ignored for synthesis)
    // and W528 (variable set but not read) as data_bus is now an observable output.
endmodule
