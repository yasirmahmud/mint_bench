// synchronizer module for crossing clock domains
module synchronizer(input clk, input [2:0] ptra, output reg [2:0] ptrb);
    reg [2:0] flop1;
    reg [2:0] flop2;
    always @(posedge clk) begin
        flop1 <= ptra;
        flop2 <= flop1;
        ptrb <= flop2;
    end
endmodule
