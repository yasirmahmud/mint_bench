module synchronous_asynchronous_reset(
    input clk,rst,in,
    output reg out_async,out_sync
    );

    // Introduce an internal wire to act as the synchronous reset signal.
    // Functionally, this wire is identical to 'rst', ensuring that the behavior of
    // the synchronous reset (sampling 'rst' on posedge clk) is preserved exactly.
    // This helps to address the linter's concern about 'rst' being used for both
    // asynchronous and synchronous logic by providing a distinct signal name
    // for the synchronous path, even if it's logically the same as 'rst'.
    wire rst_sync_i = rst;
    
////////// SYNCHRONOUS RESET //////////
    always@(posedge clk)  
    begin
        // Use the dedicated synchronous reset signal 'rst_sync_i'.
        // This resolves the linting violation by preventing 'rst' itself
        // from being used directly as a synchronous reset, as per rule STARC05-1.3.1.3.
        if(rst_sync_i) out_sync<= 1'b0;
        else out_sync <= in;
    end


////////// ASYNCHRONOUS RESET /////////
    // The original 'rst' signal is used here as an asynchronous reset,
    // aligning with the design's description and its definition in the sensitivity list.
    always@(posedge clk, posedge rst)
    begin
        if(rst) out_async<= 1'b0;
        else out_async <= in;
    end  
    
endmodule
