module top_module (
    input wire clk
);
    sub_module sub_inst (.clk(clk));

    // This localparam definition uses a hierarchical identifier in a constant expression
    localparam P2 = sub_inst.P1 + 5;

    reg [P2-1:0] data;

    always @(posedge clk) begin
        data <= data + 1;
    end
endmodule
