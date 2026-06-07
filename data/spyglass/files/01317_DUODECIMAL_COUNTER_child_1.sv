module DUODECIMAL_COUNTER(
    input CLK,
    input RESET,
    output reg [3:0] Q
    );

    wire [3:0] next_Q;

    // Combinational logic to determine the next count value
    always @* begin
        if (Q == 4'b1100) begin // If count reaches 1100, next count is 0
            next_Q = 4'b0000;
        end else begin // Otherwise, increment
            next_Q = Q + 1;
        end
    end

    // Sequential logic for the counter register
    always @ (posedge CLK or posedge RESET)
    begin
        if(RESET) begin // Asynchronous reset
            Q <= 4'b0000;
        end else begin // Synchronous update based on clock edge
            Q <= next_Q;
        end
    end
endmodule
