// Top module definition
module curve_synth_132_20260111_023509_attempt1 (
    input clk,
    input rst,
    input [7:0] data_in_top,
    output [7:0] data_out_top
);

    // Instantiate the sub_module
    sub_module sub_inst (
        .clk(clk),
        .rst(rst),
        .data_in(data_in_top),
        .data_out(data_out_top)
    );

    // This localparam definition uses a hierarchical identifier in a constant expression.
    // This line directly triggers the SYNTH_132 violation.
    localparam P_OFFSET = sub_inst.SIZE + 4; 

    // Declare and use a register with the calculated width to avoid 'unused signal' violations.
    reg [P_OFFSET-1:0] internal_reg;

    always @(posedge clk) begin
        internal_reg <= {P_OFFSET{1'b0}}; // Simple assignment to use the register
    end

endmodule
