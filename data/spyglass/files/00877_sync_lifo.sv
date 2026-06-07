module sync_lifo  (
    input clk,rst,read,write,
    input [7:0]data_in,
    output reg [7:0]data_out, 
    output reg full,empty
    
);


parameter depth = 8;
localparam address_bit =$clog2(depth);
reg [7:0] mem [0:depth-1];
reg [address_bit-1:0] pointer;
reg [address_bit:0]count;


always @(posedge clk) begin
    if (rst) begin
        data_out<=0;
        full<=0;
        empty<=1;
        pointer <=0;
        count <=0;
        for (integer i =0 ;i<depth;i=i+1 ) begin
            mem[i] <=0;
        end
    end
    else begin
        if (write && !full) begin
            mem[pointer] <= data_in;
            if (pointer <depth) begin
                pointer <= pointer +1;
            end
            count <= count +1;
        end
        if (read && !empty) begin
            data_out <= mem[pointer-1];
            
            if (pointer> 0) begin
                pointer <= pointer -1;
            end
            count = count -1;
        end
        if (count == depth) begin
            full <=1;
        end
        else begin
            full <= 0;
        end
        if (count == 0) begin
            empty <=1;
        end
        else begin
            empty<=0;
        end
    end
    
end
endmodule
