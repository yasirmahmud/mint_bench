// rf (Register File/Memory)
module rf (
    input [31:0] di_d,
    input [31:0] di_e,
    input [5:0] add_a,
    input [5:0] add_b,
    input [5:0] add_c,
    input [5:0] add_d,
    input [5:0] add_e,
    input we_d,
    input we_e,
    input clk,
    output [31:0] do_a,
    output [31:0] do_b,
    output [31:0] do_c
);

    reg [31:0] mem [63:0];

    // Read ports (combinational)
    assign do_a = mem[add_a];
    assign do_b = mem[add_b];
    assign do_c = mem[add_c];

    // Write ports (synchronous on negedge clk based on actual usage with ~clk)
    always @(negedge clk) begin
        if (we_d) {
            mem[add_d] <= di_d;
        }
        if (we_e) {
            mem[add_e] <= di_e;
        }
    end
endmodule
