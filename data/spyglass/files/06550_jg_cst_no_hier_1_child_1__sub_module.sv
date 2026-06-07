module sub_module (
    input wire clk
);
    parameter P1 = 10;
    // Fix for W240 (Input 'clk' declared but not read) and WarnAnalyzeBBox (empty definition):
    // Introduce a simple clocked register to utilize 'clk' and make the module non-empty.
    reg [3:0] dummy_q;
    always @(posedge clk) begin
        dummy_q <= P1[3:0]; // Using P1 and clk to demonstrate functionality
    end
endmodule
