module curve_w502_20260111_230044_971245_w32456_attempt11 (
    input wire clk,
    input wire reset_n,
    input wire enable_update,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            data_out <= 8'h00;
        end else begin
            if (enable_update) begin
                data_out <= data_in;
            end else begin
                // W502 is expected here: The signal 'data_out' is explicitly self-assigned within this always block.
                data_out <= data_out; 
            end
        }
    end

endmodule
