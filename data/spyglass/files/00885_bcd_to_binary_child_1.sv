module bcd_to_binary #(parameter N=16) (rst,in,out);
input rst;
input [(N*4)-1:0] in;       //N is no of bcd bits
output reg [(N*4)-1:0] out; //out is also represented in binary 

wire [3:0] bcd_bit [N-1:0]; // bcd_bit is a wire as it's a combinatorial breakdown of 'in'

integer i;

genvar j;
    generate
        for(j=0; j<N; j=j+1) begin : bcd_split_inst // Named generate block for Verilog-2001 compatibility
            assign bcd_bit[j] = in[(j*4)+3 : j*4]; // Use assign for continuous assignment to wires
        end
    endgenerate

 always @(*) begin 
    if(rst==1) begin
        out = 0; // Output is reset to zero when 'rst' is active
    end else begin    
        // Use a local temporary variable for summation to ensure 'out' starts from zero 
        // for each combinatorial calculation cycle when not under reset.
        reg [(N*4)-1:0] calculated_out;
        calculated_out = 0; // Initialize sum for current calculation
        for(i=0; i<N; i=i+1) begin
            calculated_out = calculated_out + (bcd_bit[i] * (10**i));  
        end
        out = calculated_out; // Assign the final calculated sum to 'out'
    end
end   
    
endmodule
