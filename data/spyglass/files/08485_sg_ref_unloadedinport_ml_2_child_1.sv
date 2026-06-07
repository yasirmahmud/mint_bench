module my_module_ex2 (input in_port);
    // Fix for UnloadedInPort-ML: 'in_port' is read to prevent it from being unloaded.
    // Since there's no specific functional use described, it's connected to a dummy wire.
    wire unused_in_port_sink;
    assign unused_in_port_sink = in_port;
endmodule
