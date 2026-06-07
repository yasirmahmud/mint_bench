module sync_lifo  (
    input clk,rst,read,write,
    input [7:0]data_in,
    output reg [7:0]data_out, 
    output reg full,empty
    
);


parameter depth = 8;
localparam address_bit =$clog2(depth);
reg [7:0] mem [0:depth-1];
reg [address_bit:0] pointer; // FIX: Increased pointer width to correctly store 'depth' value
reg [address_bit:0]count;


integer i; // FIX: Declared loop variable 'i' outside the for loop for Verilog-2001 compliance

always @(posedge clk) begin
    if (rst) begin
        data_out<=0;
        full<=0;
        empty<=1;
        pointer <=0;
        count <=0;
        for (i =0 ;i<depth;i=i+1 ) begin // FIX: Syntax for for loop (removed 'integer' from declaration)
            mem[i] <=0;
        end
    end
    else begin
        if (write && !full) begin
            mem[pointer] <= data_in;
            // FIX: Removed redundant condition 'if (pointer < depth)'. 
            // With 'pointer' width fixed and '!full' guard, pointer will not exceed depth.
            pointer <= pointer +1; 
            count <= count +1;
        end
        if (read && !empty) begin
            data_out <= mem[pointer-1];
            
            // FIX: Removed redundant condition 'if (pointer > 0)'. 
            // With 'pointer' width fixed and '!empty' guard, pointer will not go below zero.
            pointer <= pointer -1;
            count <= count -1; // FIX: Changed to non-blocking assignment to resolve SYNTH_77
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
