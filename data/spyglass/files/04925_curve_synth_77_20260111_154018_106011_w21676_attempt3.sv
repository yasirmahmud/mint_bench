module curve_synth_77_20260111_154018_106011_w21676_attempt3 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data,
    output reg [7:0] out_var
);

// A blocking assignment in an initial block
// This initializes out_var at simulation start using a blocking assignment.
initial begin
    out_var = 8'd0; // Blocking assignment
end

// Non-blocking assignments for the same variable in a sequential always block
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_var <= 8'hAA; // Non-blocking assignment for reset
    end else begin
        out_var <= in_data; // Non-blocking assignment for data
    end
end

endmodule
