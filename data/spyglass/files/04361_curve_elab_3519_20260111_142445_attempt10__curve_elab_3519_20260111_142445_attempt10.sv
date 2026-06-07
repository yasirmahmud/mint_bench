module curve_elab_3519_20260111_142445_attempt10 (
    input clk,
    input rst,
    input [7:0] in_data,
    input sel_i,
    output [7:0] out_mux_data,
    output [7:0] out_reg_data
);

    // Required for ELAB_3519: A MUX instance explicitly named 'M0'.
    // This is one of the conflicting entities.
    MY_MUX M0 (
        .IN0(in_data),
        .IN1(in_data), // Connect to avoid unused wire warnings
        .SEL(sel_i),
        .OUT(out_mux_data)
    );

    // Required for ELAB_3519: A register in an always block that "gets elaborated as M0".
    // The hypothesis is that SpyGlass's elaboration engine assigns the name 'M0'
    // to the sequential logic within a named 'begin...end' block, if that block is named 'M0'.
    // This will cause a conflict with the MY_MUX instance also named 'M0'.
    reg [7:0] my_register;

    always @(posedge clk or posedge rst) begin : M0 // Named sequential block 'M0'
        if (rst) begin
            my_register <= 8'h00;
        end else begin
            my_register <= in_data;
        end
    end

    // Connect the register to an output to avoid an unused signal violation.
    assign out_reg_data = my_register;

endmodule
