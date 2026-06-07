module FSM_hour (
    input wire rst,
    input wire clk,
    input wire [5:0] hour_in,
    input wire hour_in_load,
    input wire [5:0] min_count,
    input wire [5:0] sec_count, // Not directly used for hour increment logic, but part of interface
    output reg [5:0] hour_out
);

reg [5:0] min_count_q; // Registered min_count to detect rollover
always @(posedge clk or posedge rst) begin
    if (rst) begin
        min_count_q <= 6'd0;
    end else begin
        min_count_q <= min_count;
    end
end

// Detect when min_count rolls over from 59 to 0
wire min_rollover_trigger = (min_count_q == 6'd59) && (min_count == 6'd0);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        hour_out <= 6'd0;
    end else begin
        if (hour_in_load) begin
            hour_out <= hour_in;
        } else if (min_rollover_trigger) begin
            if (hour_out == 6'd23) begin // Hours count from 0 to 23
                hour_out <= 6'd0;
            } else begin
                hour_out <= hour_out + 6'd1;
            }
        }
    end
end
endmodule
