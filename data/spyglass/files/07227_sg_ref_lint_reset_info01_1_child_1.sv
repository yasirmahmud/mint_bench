module lint_reset_info01_ex1(input clk,input rst,input d,output reg q_async,output reg q_sync);

wire rst_sync_h; // Declare a new wire for the synchronous reset path

assign rst_sync_h = rst; // Assign the input reset to the new synchronous reset signal

always @(posedge clk or posedge rst) begin 
    if (rst) begin 
        q_async <= 1'b0;
    end else begin 
        q_async <= d;
    end 
end 

always @(posedge clk) begin 
    if (rst_sync_h) begin // Use the distinct signal for synchronous reset
        q_sync <= 1'b0;
    end else begin 
        q_sync <= d;
    end 
end 
endmodule
