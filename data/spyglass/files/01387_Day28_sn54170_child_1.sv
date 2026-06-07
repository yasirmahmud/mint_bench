module Day28_sn54170(input [3:0]data_in,
                     input      wr_enb, 
                     input		rd_enb,
                     input [1:0]wr_sel,
                     input [1:0]rd_sel,
                     input      clk,   // Added clock input
                     input      rst_n, // Added active-low reset input
                     output [3:0]data_out);
  
  reg [3:0]latched_data[3:0];
  
  // Changed to an edge-triggered always block to infer flip-flops
  // This resolves the latch inference by making the storage synchronous.
  always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n) begin // Asynchronous active-low reset
        // Reset all registers to a known state
        integer i; 
        for (i=0; i<4; i=i+1) begin
          latched_data[i] <= 4'b0;
        end
      end else begin
        // Synchronous write operation when wr_enb is low
        if(!wr_enb)
          latched_data[wr_sel] <= data_in;
        // When wr_enb is high, the registers hold their current values.
        // This is characteristic of flip-flops and no latch is inferred.
      end
    end
  
  assign data_out = (rd_enb) ? 4'b1111 : latched_data[rd_sel];
  
endmodule
