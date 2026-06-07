module FSM_second (
    input wire rst,
    input wire clk,
    input wire [5:0] sec_in,
    input wire sec_in_load,
    output reg [5:0] sec_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        sec_out <= 6'd0;
    end else begin
        if (sec_in_load) begin
            sec_out <= sec_in;
        end else begin
            if (sec_out == 6'd59) begin
                sec_out <= 6'd0;
            end else begin
                sec_out <= sec_out + 6'd1;
            end
        end
    end
end

endmodule
