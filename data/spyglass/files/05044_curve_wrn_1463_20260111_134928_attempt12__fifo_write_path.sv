// WRN_1463 is expected to trigger on the declaration of this second module
// because SpyGlass typically flags multiple top-level design units in a single file.
// This aligns with context examples where the rule was reported on subsequent module declarations.
module fifo_write_path (
    input wire clk_i,
    input wire rst_ni,
    input wire write_req_i,
    output wire [7:0] data_out_o
);

    assign data_out_o = {8{write_req_i}}; // Simple data generation based on request

endmodule
