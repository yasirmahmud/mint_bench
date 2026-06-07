module BCD_counter (
    input clk, rstn, en,
    output reg [3:0] Q,
    output reg done
);

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            Q <= 4'b0;
            done <= 1'b0;
        end else if (en) begin
            if (Q == 4'd9) begin
                Q <= 4'b0;
                done <= 1'b1; // Assert done for one cycle when wrapping from 9 to 0
            end else begin
                Q <= Q + 4'b1;
                done <= 1'b0;
            end
        end else begin
            // If 'en' is low, Q holds its value and 'done' should be low as no completion event occurs.
            done <= 1'b0;
        end
    end

endmodule
