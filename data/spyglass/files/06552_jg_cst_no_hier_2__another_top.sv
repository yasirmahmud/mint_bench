module another_top (
    input wire clk
);
    another_sub sub_inst_2 (.in_val(1'b0));

    // The array declaration uses a hierarchical identifier in its constant size expression
    reg [sub_inst_2.SIZE_PARAM-1:0] data_bus;

    always @(posedge clk) begin
        data_bus <= 0;
    end
endmodule
