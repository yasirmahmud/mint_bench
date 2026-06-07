module fifo_read_control (
    input wire clk_i,
    input wire rst_ni,
    input wire enable_i,
    output wire ready_o
);

    assign ready_o = enable_i; // Simple passthrough

endmodule
