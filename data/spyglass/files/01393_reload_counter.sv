module reload_counter(
    input load_i,
    input [3:0] load,
    input reset,
    input clk,
    output reg [3:0] count_out
    );
    
    
    always @(posedge clk) begin
        if (reset == 1'b1)
            count_out <= 4'b0;
        else begin
            if (load_i == 1'b0) begin
                    count_out = count_out + 1;
            end
            else 
                count_out <= load;
         end
    end

endmodule
