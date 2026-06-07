`ifdef PLATFORM_SIM
module xchecker_logic #(
    parameter DW = 32,
    parameter SIGNAL_NAME = ""
)
(
    input clk,
    input [DW-1 : 0] data_i
);

// The assertion is moved to a synchronous block triggered by 'posedge clk'
// to align with the requirement to detect X values "after a clock edge".
// This change also resolves the W240 violation by clearly defining when 'data_i' is 'read'.
always @(posedge clk) begin : CHECK_X_LOGIC
    assert ((^(data_i)) !== 1'bx)
    else $fatal("Error! ", SIGNAL_NAME, ", detected a X value after posedge clk!\n");
end

endmodule
