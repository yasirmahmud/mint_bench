module couunter_10(
    input wire clk, rst,
    output reg [3:0] Q
    );
    always @(posedge clk) begin 
        if (rst) begin
            Q <= 4'b0;
        end else begin
            if (Q == 4'd9) begin
                Q <= Q;
            end else begin 
                Q <= Q + 1'b1;
            end
        end
    end
 endmodule
