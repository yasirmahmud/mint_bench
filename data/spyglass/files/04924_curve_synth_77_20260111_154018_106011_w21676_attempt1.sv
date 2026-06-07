module curve_synth_77_20260111_154018_106011_w21676_attempt1 (
    input wire clk,
    input wire rst_n,
    input wire in_data,
    output reg my_variable
);

// Non-blocking assignment to 'my_variable' in a sequential block
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        my_variable <= 1'b0;
    end else begin
        my_variable <= in_data;
    end
end

// Blocking assignment to the SAME 'my_variable' in a combinational block
always @(*) begin
    my_variable = in_data;
end

endmodule
