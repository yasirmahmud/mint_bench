// Generic Scan Enable D-Flip-flop
module mj_s_ff_se_d #(parameter WIDTH = 1) (
    output [WIDTH-1:0] out,
    input  [WIDTH-1:0] din,
    input              lenable, // load enable
    input              clk,
    input              sin,     // scan input
    input              sm,      // scan mode (1 for scan, 0 for functional)
    output             so       // scan output
);

reg [WIDTH-1:0] q_reg;
reg [WIDTH-1:0] next_q_func; // Changed from wire to reg
reg [WIDTH-1:0] next_q_scan; // Changed from wire to reg

always @(*) begin
    // Functional path: data from din
    next_q_func = din;
    // Scan path: shift in sin
    next_q_scan = {q_reg[WIDTH-2:0], sin};
end

always @(posedge clk) begin
    if (lenable) {
        if (sm) begin // Scan mode
            q_reg <= next_q_scan;
        end else begin // Functional mode
            q_reg <= next_q_func;
        end
    }
end

assign out = q_reg;
assign so = q_reg[WIDTH-1]; // Scan out is the MSB of the register

endmodule
