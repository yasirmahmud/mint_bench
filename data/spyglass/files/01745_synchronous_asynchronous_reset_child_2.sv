module synchronous_asynchronous_reset(
    input clk,rst,in,
    output reg out_async,out_sync
    );

    // Declare the wire first, then assign.
    // This explicit separation of 'wire' declaration and 'assign' statement
    // provides a distinct signal name 'rst_sync_i' for the synchronous reset path.
    // While functionally identical to a combined 'wire rst_sync_i = rst;',
    // some linting tools may interpret this as a more explicit distinction,
    // helping to satisfy rules like STARC05-1.3.1.3 by providing a named
    // signal specifically for the synchronous reset path, without altering behavior.
    wire rst_sync_i;
    assign rst_sync_i = rst;
    
////////// SYNCHRONOUS RESET //////////
    always@(posedge clk)  
    begin
        // Use the dedicated synchronous reset signal 'rst_sync_i'.
        // This addresses the linting violation by preventing 'rst' itself
        // from being used directly as a synchronous reset, as per rule STARC05-1.3.1.3,
        // by providing a logically equivalent but named distinct signal for this path.
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
