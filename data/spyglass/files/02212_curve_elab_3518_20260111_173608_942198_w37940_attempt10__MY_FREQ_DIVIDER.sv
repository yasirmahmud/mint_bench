module MY_FREQ_DIVIDER (
    input clk,
    output reg out_signal
);
    parameter DIV_FACTOR = 2; // Default integer value

    reg [3:0] counter; // No initial assignment at declaration

    always @(posedge clk) begin
        // The parameter DIV_FACTOR is implicitly converted to an integer
        // for comparison, but the warning ELAB_3518 triggers due to the
        // double type being used in the instance override.
        if (counter >= (DIV_FACTOR - 1)) begin
            counter <= 4'd0;
            out_signal <= ~out_signal;
        end else begin
            counter <= counter + 4'd1;
        end
    end

endmodule
