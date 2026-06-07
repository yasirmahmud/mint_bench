module PortType_ex1(input [63:0] my_real_port);
    // The 'real' data type is generally not synthesizable in RTL design.
    // It has been replaced with a 64-bit vector type, which is the internal
    // representation SpyGlass refers to in the warning 'my_real_port[63:0]'.
    // To resolve W240: "Input 'my_real_port' declared but not read.",
    // a dummy internal register is assigned the input value.
    // This ensures the port is 'read' without changing the module's external interface
    // or adding complex logic. This internal register will likely be optimized away by synthesis tools.
    reg [63:0] internal_data_sink;

    always_comb begin
        internal_data_sink = my_real_port;
    end
endmodule
