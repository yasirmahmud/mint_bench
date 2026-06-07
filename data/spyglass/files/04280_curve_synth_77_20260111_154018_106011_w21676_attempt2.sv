module curve_synth_77_20260111_154018_106011_w21676_attempt2 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data,
    input wire control,
    output reg [7:0] out_var
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_var <= 8'd0; // Non-blocking assignment
    end else begin
        if (control) begin
            out_var <= in_data; // Non-blocking assignment
        end else begin
            out_var = in_data + 1; // Blocking assignment
        end
    end
end

endmodule
