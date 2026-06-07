module MESI_protocol(
    clk,
    rst_n,
	Pr_Rd_1,
	Bus_Rd_C_1,
	Bus_Rd_IC_1,
	Pr_Wr_1,
	Bus_RdX_1,
	Bus_Upgr_1,
	Flush_1,
	Flush_Opt_1,
	Cache1_pointer,
	effective_address_1,
	Pr_Rd_2,
	Bus_Rd_C_2,
	Bus_Rd_IC_2,
	Pr_Wr_2,
	Bus_RdX_2,
	Bus_Upgr_2,
	Flush_2,
	Flush_Opt_2,
    Cache2_pointer,
	effective_address_2,
    output reg [31:0] LD1_data,
    output reg [31:0] LD2_data
);

input clk;  //Clock signal
input rst_n; // Active low reset

//Control Signals
input Pr_Rd_1;    //When processor wants to read data
input Bus_Rd_C_1;  //When one Cache wants to read data from another cache
input Bus_Rd_IC_1;  //When processor reads a data that is exclusive to itself--- "E" state
input Pr_Wr_1;    //processor wants to write something onto its' Cache
input Bus_RdX_1;  //When there's a write miss and processor has to fetch the cache address first before writing onto it
input Bus_Upgr_1;  //used to make the other Caches containing the same address "Invalid" while data is being written down by one processor onto its Cache
input Flush_1;     //used to perform Write-Back to the main memory
input Flush_Opt_1;     //I believe Flush and Flush_Opt are the same
input [31:0] effective_address_1; //Effective Address that has been calculated by the Processor 

input Pr_Rd_2;    //When processor wants to read data
input Bus_Rd_C_2;  //When one Cache wants to read data from aother cache
input Bus_Rd_IC_2;  //When processor reads a data that is exclusive to itself--- "E" state
input Pr_Wr_2;    //processor wants to write something onto its' Cache
input Bus_RdX_2;  //When there's a write miss and processor has to fetch the cache address first before writing onto it
input Bus_Upgr_2;  //used to make the other Caches containing the same address "Invalid" while data is being written down by one processor onto its Cache
input Flush_2;     //used to perform Write-Back to the main memory
input Flush_Opt_2;     //I believe Flush and Flush_Opt are the same
input [31:0] effective_address_2; //Effective Address that has been calculated by the Processor 

input [1:0] Cache1_pointer;          //to point to the row of Cache that will be opearted upon
input [1:0] Cache2_pointer;          //to keep count as to how many rows are filled

//Memory resources
reg [31:0] Memory_data [1:32];     //Data stored in Main Memory

reg [31:0] Cache1_data [0:3];      //Data stored in Cache of Processor 1
// reg [31:0] Cache1_addr [0:3];      // Address stored in Cache of Processor 1 - Removed as it was set but never read, to resolve W528
reg [1:0] Cache1_state [0:3];      //State of the Cache (for a particular address) of Processor 1

reg [31:0] Cache2_data [0:3];      //Data stored in Cache of Processor 2
// reg [31:0] Cache2_addr [0:3];      // Address stored in Cache of Processor 2 - Removed as it was set but never read, to resolve W528
reg [1:0] Cache2_state [0:3];      //State of the Cache (for a particular address) of Processor 2


//Pipelined Registers for LOAD/STORE Opeartions
output reg [31:0] LD1_data;       //Data from Main Memory or Cache is loaded onto this pipelined register (when processor 1 is active) from which it's written back 
reg [31:0] ST1_data;       //Data from this pipelined register (when processor 1 is active) is stored in the Cache with the same efective address 
output reg [31:0] LD2_data;       //Data from Main Memory or Cache is loaded onto this pipelined register (when processor 2 is active) from which it's written back 
reg [31:0] ST2_data;       //Data from this pipelined register (when processor 2 is active) is stored in the Cache with the same effective address 


initial 
begin
    // Initial block is for simulation-only data initialization
    Memory_data[5]=8;
end

// All sequential assignments must use non-blocking assignments ('<=') within this block.
// The four original 'case' statements have been merged into two, one for each cache,
// combining local processor requests and remote bus snooping reactions to resolve W415a.
always@(posedge clk or negedge rst_n)
begin
    if (!rst_n) begin
        // Reset all state and data registers
        for (integer i = 0; i < 4; i = i + 1) begin
            Cache1_state[i] <= 2'b00;
            Cache2_state[i] <= 2'b00;
            Cache1_data[i] <= 32'b0;
            Cache2_data[i] <= 32'b0;
        end
        ST1_data <= 15; // Initial values for store data
        ST2_data <= 10;
        LD1_data <= 32'b0;
        LD2_data <= 32'b0;
    end else begin
        // --- State Machine for Processor 1's Cache (Cache1) ---
        // This section handles P1's own requests and P2's bus snooping impacting Cache1.
        // P1's local actions are prioritized over P2's bus actions via 'if-else if' structure.
        case(Cache1_state[Cache1_pointer])
            2'b00: begin                           //Cache1 is in the "I" state
                if(Pr_Rd_1==1 && Bus_Rd_IC_1==1) begin // If effective address is not found in the Caches of both the processors, then it must be in Memory
                    Cache1_data[Cache1_pointer] <= Memory_data[effective_address_1];  //Fetch data from Memory and store it in the Cache of working processor
                    LD1_data <= Memory_data[effective_address_1];       //Fetch data from Memory and send it to the working processor
                    Cache1_state[Cache1_pointer] <= 2'b01;         //Change state from "I" to "E"
                end   
                else if(Pr_Rd_1==1 && Bus_Rd_C_1==1) begin    //If effective address is found in the Cache of the other processor and is not in "I" state
                    LD1_data <= Cache2_data[Cache2_pointer];       //Fetch data from that cache to the current working processor
                    Cache1_data[Cache1_pointer] <= Cache2_data[Cache2_pointer]; //Fetch data from that Cache to the Cache of the current working processor
                    Cache1_state[Cache1_pointer] <= 2'b10;         //Change state from "I" to "S"
                end 
                else if(Pr_Wr_1==1 && Bus_RdX_1==1) begin     //If processor wants to write into the Cache but there's a Cache miss
                    Cache1_data[Cache1_pointer] <= ST1_data;       //Store data into Cache
                    Cache1_state[Cache1_pointer] <= 2'b11;              //Change state from "I" to "M"
                end
                // P2's bus actions affecting Cache1 when Cache1 is in I state (no state change for Cache1)
                else if(Bus_Rd_IC_2==1 || Bus_RdX_2==1 || Bus_Upgr_2==1) begin
                    Cache1_state[Cache1_pointer] <= 2'b00;  //Cache remains in same "I" state
                end      
            end 
            2'b01: begin                                //Cache1 is in state "E"
                if(Pr_Rd_1==1) begin             //If the current working processor just wants to read the data that is already present in its Cache 
                    LD1_data <= Cache1_data[Cache1_pointer];  //Fetch the required data from Cache
                    Cache1_state[Cache1_pointer] <= 2'b01;    //Cache remains in the same "E" state
                end
                else if(Pr_Wr_1==1) begin             //If the current working processor wants to write something onto its' Cache 
                    Cache1_data[Cache1_pointer] <= ST1_data;  //Store data from processor onto the Cache
                    Cache1_state[Cache1_pointer] <= 2'b11;    //Change state from "E" to "M"
                end
                // P2's bus actions affecting Cache1 when Cache1 is in E state
                else if(Bus_RdX_2==1 && Flush_Opt_2==1) begin  // If P2 has a write miss on this line, P1 must invalidate
                    Memory_data[effective_address_2] <= Cache1_data[Cache1_pointer];  // Data present in P1's cache is being written back
                    Cache1_state[Cache1_pointer] <= 2'b00;          // And state changes from "E" to "I"
                end 
                else if(Bus_Rd_C_2==1 && Flush_Opt_2==1) begin  // P2 fetches data from P1's cache
                    Cache2_data[Cache2_pointer] <= Cache1_data[Cache1_pointer];  // P2 fetches data from P1's Cache
                    Memory_data[effective_address_2] <= Cache1_data[Cache1_pointer];  // Write back to Memory as well
                    Cache1_state[Cache1_pointer] <= 2'b10;       // Change state from "E" to "S"
                end   
            end 
            2'b10: begin                           //Cache1 is in state "S"
                if(Pr_Rd_1==1) begin           //If the current working processor just wants to read the data that is already present in its Cache 
                    LD1_data <= Cache1_data[Cache1_pointer];  //Fetch the required data from Cache
                    Cache1_state[Cache1_pointer] <= 2'b10;    //Cache remains in the same "S" state
                end 
                else if(Pr_Wr_1==1 && Bus_Upgr_1==1) begin  //If the current working processor wants to write something onto its' Cache
                    Cache1_data[Cache1_pointer] <= ST1_data;   //Store data from processor onto the Cache
                    Cache1_state[Cache1_pointer] <= 2'b11;     //Change state from "S" to "M"
                end
                // P2's bus actions affecting Cache1 when Cache1 is in S state
                else if(Bus_Rd_C_2==1 && Flush_Opt_2==1) begin  // P2 fetches data from P1's cache (P1 remains Shared)
                    Memory_data[effective_address_2] <= Cache1_data[Cache1_pointer]; // Write back takes place
                    Cache1_state[Cache1_pointer] <= 2'b10;     // Cache remains in the "S" state
                end
                else if(Bus_RdX_2==1 && Flush_Opt_2==1) begin  // P2 write miss, P1's cache invalidates
                    Memory_data[effective_address_2] <= Cache1_data[Cache1_pointer];  // write back before going into "I" state
                    Cache1_state[Cache1_pointer] <= 2'b00;     // state changes to "I" state
                end   
                else if(Bus_Upgr_2==1) begin     // P2 wants to write and invalidate other Caches
                    Memory_data[effective_address_2] <= Cache1_data[Cache1_pointer];  // Write back happens before going into "I" state
                    Cache1_state[Cache1_pointer] <= 2'b00;   // Cache of P1 goes into the "I" state
                end   
            end    
            2'b11: begin                       //Cache1 is in state "M"
                if(Pr_Rd_1==1) begin             //If the current working processor just wants to read the data that has just been written onto its' Cache
                    LD1_data <= Cache1_data[Cache1_pointer];    //Fetch the required data from Cache
                    Cache1_state[Cache1_pointer] <= 2'b11;      //Cache remains in the same "M" state
                end
                else if(Pr_Wr_1==1) begin         //If the current working processor wants to write something onto its' Cache
                    Cache1_data[Cache1_pointer] <= ST1_data;    //Store data from processor onto the Cache
                    Cache1_state[Cache1_pointer] <= 2'b11;       //Cache remains in the same "M" state
                end   
                // P2's bus actions affecting Cache1 when Cache1 is in M state
                else if(Bus_Rd_C_2==1 && Flush_2==1) begin   // P2 now wants to read the data that had been written by P1
                    Memory_data[effective_address_2] <= Cache1_data[Cache1_pointer]; // write back to the memory before going into "S" state
                    Cache1_state[Cache1_pointer] <= 2'b10;   // change of the state of P1's cache to "S" cache
                end
                else if(Bus_RdX_2==1 && Flush_2==1) begin  // P2 write miss encountered
                    Memory_data[effective_address_2] <= Cache1_data[Cache1_pointer];  // write back needs to happen before it goes into the "I" state 
                    Cache1_state[Cache1_pointer] <= 2'b00;   // cache goes into the "I" state
                end    
            end
            default: Cache1_state[Cache1_pointer] <= 2'b00;
        endcase

        // --- State Machine for Processor 2's Cache (Cache2) ---
        // This section handles P2's own requests and P1's bus snooping impacting Cache2.
        // P2's local actions are prioritized over P1's bus actions via 'if-else if' structure.
        case(Cache2_state[Cache2_pointer])
            2'b00: begin                           //Cache2 is in the "I" state
                if(Pr_Rd_2==1 && Bus_Rd_IC_2==1) begin //If effective address is not found in the Caches of both the processors, then it must be in Memory
                    Cache2_data[Cache2_pointer] <= Memory_data[effective_address_2];  //Fetch data from Memory and store it in the Cache of working processor
                    LD2_data <= Memory_data[effective_address_2];       //Fetch data from Memory and send it to the working processor
                    Cache2_state[Cache2_pointer] <= 2'b01;         //Change state from "I" to "E"
                end   
                else if(Pr_Rd_2==1 && Bus_Rd_C_2==1) begin    //If effective address is found in the Cache of the other processor and is not in "I" state
                    LD2_data <= Cache1_data[Cache1_pointer];       //Fetch data from that cache to the current working processor
                    Cache2_data[Cache2_pointer] <= Cache1_data[Cache1_pointer]; //Fetch data from that Cache to the Cache of the current working processor
                    Cache2_state[Cache2_pointer] <= 2'b10;         //Change state from "I" to "S"
                end 
                else if(Pr_Wr_2==1 && Bus_RdX_2==1) begin     //If processor wants to write into the Cache but there's a Cache miss
                    Cache2_data[Cache2_pointer] <= ST2_data;       //Store data into Cache
                    Cache2_state[Cache2_pointer] <= 2'b11;              //Change state from "I" to "M"
                end
                // P1's bus actions affecting Cache2 when Cache2 is in I state (no state change for Cache2)
                else if(Bus_Rd_IC_1==1 || Bus_RdX_1==1 || Bus_Upgr_1==1) begin
                   Cache2_state[Cache2_pointer] <= 2'b00;  //Cache remains in same "I" state
                end      
            end 
            2'b01: begin                                //Cache2 is in state "E"
                if(Pr_Rd_2==1) begin             //If the current working processor just wants to read the data that is already present in its Cache 
                    LD2_data <= Cache2_data[Cache2_pointer];  //Fetch the required data from Cache
                    Cache2_state[Cache2_pointer] <= 2'b01;    //Cache remains in the same "E" state
                end
                else if(Pr_Wr_2==1) begin             //If the current working processor wants to write something onto its' Cache 
                    Cache2_data[Cache2_pointer] <= ST2_data;  //Store data from processor onto the Cache
                    Cache2_state[Cache2_pointer] <= 2'b11;    //Change state from "E" to "M"
                end
                // P1's bus actions affecting Cache2 when Cache2 is in E state
                else if(Bus_RdX_1==1 && Flush_Opt_1==1) begin  // If P1 has a write miss on this line, P2 must invalidate
                    Memory_data[effective_address_1] <= Cache2_data[Cache2_pointer];  // Data present in P2's cache is being written back
                    Cache2_state[Cache2_pointer] <= 2'b00;          // And state changes from "E" to "I"
                end 
                else if(Bus_Rd_C_1==1 && Flush_Opt_1==1) begin  // P1 fetches data from P2's cache
                    Cache1_data[Cache1_pointer] <= Cache2_data[Cache2_pointer];  // P1 fetches data from P2's Cache
                    Memory_data[effective_address_1] <= Cache2_data[Cache2_pointer];  // Write back to Memory as well
                    Cache2_state[Cache2_pointer] <= 2'b10;       // Change state from "E" to "S"
                end   
            end 
            2'b10: begin                           //Cache2 is in state "S"
                if(Pr_Rd_2==1) begin           //If the current working processor just wants to read the data that is already present in its Cache 
                    LD2_data <= Cache2_data[Cache2_pointer];  //Fetch the required data from Cache
                    Cache2_state[Cache2_pointer] <= 2'b10;    //Cache remains in the same "S" state
                end 
                else if(Pr_Wr_2==1 && Bus_Upgr_2==1) begin  //If the current working processor wants to write something onto its' Cache
                    Cache2_data[Cache2_pointer] <= ST2_data;   //Store data from processor onto the Cache
                    Cache2_state[Cache2_pointer] <= 2'b11;     //Change state from "S" to "M"
                end   
                // P1's bus actions affecting Cache2 when Cache2 is in S state
                else if(Bus_Rd_C_1==1 && Flush_Opt_1==1) begin  // P1 fetches data from P2's cache (P2 remains Shared)
                    Memory_data[effective_address_1] <= Cache2_data[Cache2_pointer]; // Write back takes place
                    Cache2_state[Cache2_pointer] <= 2'b10;     // Cache remains in the "S" state
                end
                else if(Bus_RdX_1==1 && Flush_Opt_1==1) begin  // P1 write miss, P2's cache invalidates
                    Memory_data[effective_address_1] <= Cache2_data[Cache2_pointer];  // write back before going into "I" state
                    Cache2_state[Cache2_pointer] <= 2'b00;     // state changes to "I" state
                end   
                else if(Bus_Upgr_1==1) begin     // P1 wants to write and invalidate other Caches
                    Memory_data[effective_address_1] <= Cache2_data[Cache2_pointer];  // Write back happens before going into "I" state
                    Cache2_state[Cache2_pointer] <= 2'b00;   // Cache of P2 goes into the "I" state
                end   
            end    
            2'b11: begin                       //Cache2 is in state "M"
                if(Pr_Rd_2==1) begin             //If the current working processor just wants to read the data that has just been written onto its' Cache
                    LD2_data <= Cache2_data[Cache2_pointer];    //Fetch the required data from Cache
                    Cache2_state[Cache2_pointer] <= 2'b11;      //Cache remains in the same "M" state
                end
                else if(Pr_Wr_2==1) begin         //If the current working processor wants to write something onto its' Cache
                    Cache2_data[Cache2_pointer] <= ST2_data;    //Store data from processor onto the Cache
                    Cache2_state[Cache2_pointer] <= 2'b11;       //Cache remains in the same "M" state
                end   
                // P1's bus actions affecting Cache2 when Cache2 is in M state
                else if(Bus_Rd_C_1==1 && Flush_1==1) begin   // P1 now wants to read the data that had been written by P2
                    Memory_data[effective_address_1] <= Cache2_data[Cache2_pointer]; // write back to the memory before going into "S" state
                    Cache2_state[Cache2_pointer] <= 2'b10;   // change of the state of P2's cache to "S" cache
                end
                else if(Bus_RdX_1==1 && Flush_1==1) begin  // P1 write miss encountered
                    Memory_data[effective_address_1] <= Cache2_data[Cache2_pointer];  // write back needs to happen before it goes into the "I" state 
                    Cache2_state[Cache2_pointer] <= 2'b00;   // cache goes into the "I" state
                end    
            end               
            default: Cache2_state[Cache2_pointer] <= 2'b00;
        endcase
    end
end

endmodule
