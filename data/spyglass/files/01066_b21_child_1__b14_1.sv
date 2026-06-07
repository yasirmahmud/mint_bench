module b14_1(
    input clock,
    input reset,
    input [19:0] addr,
    input [31:0] datai,
    output reg [31:0] datao,
    output reg rd,
    output reg wr
);
    // Dummy module definition to resolve black-box error
    // Functional behavior is minimal to allow linting
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            datao <= 32'h0;
            rd <= 1'b0;
            wr <= 1'b0;
        end else begin
            datao <= datai; // Simple pass-through behavior
            rd <= 1'b0;
            wr <= 1'b0;
        end
    end
endmodule
