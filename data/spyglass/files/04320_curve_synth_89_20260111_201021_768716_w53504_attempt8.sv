module curve_synth_89_20260111_201021_768716_w53504_attempt8 (
    input clk,
    output reg [3:0] my_counter = 4'd7 // Initial assignment ignored by synthesis
);

    always @(posedge clk) begin
        my_counter <= my_counter + 1;
    end

endmodule
