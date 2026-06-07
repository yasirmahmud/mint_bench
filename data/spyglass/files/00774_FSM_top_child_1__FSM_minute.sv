module FSM_minute (
    input wire rst,
    input wire clk,
    input wire [5:0] min_in,
    input wire min_in_load,
    input wire [5:0] sec_count,
    output reg [5:0] min_out
);

reg [5:0] sec_count_q; // Registered sec_count to detect rollover
always @(posedge clk or posedge rst) begin
    if (rst) begin
        sec_count_q <= 6'd0;
    end else begin
        sec_count_q <= sec_count;
    end
end

// Detect when sec_count rolls over from 59 to 0
wire sec_rollover_trigger = (sec_count_q == 6'd59) && (sec_count == 6'd0);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        min_out <= 6'd0;
    end else begin
        if (min_in_load) begin
            min_out <= min_in;
        end else if (sec_rollover_trigger) begin
            if (min_out == 6'd59) begin
                min_out <= 6'd0;
            end else begin
                min_out <= min_out + 6'd1;
            end
        end
    end
end

endmodule
