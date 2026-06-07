module afifo(input rst,input rdclk, input wrclk, input rd_en, input wr_en,output reg is_full, output reg is_empty, output reg [3:0]count,
             input [7:0] data_in, output reg [7:0] data_out,temp, output reg [2:0] wr_ptr,rd_ptr);
             
    parameter size = 8;
    
    reg [7:0] fifo [0:size-1];
    
    wire [2:0] wr_sync_ptr,rd_sync_ptr;
    
    synchronizer rd(.clk(rdclk), .ptra(rd_ptr), .ptrb(wr_sync_ptr));
    synchronizer wr(.clk(wrclk), .ptra(rd_ptr), .ptrb(wr_sync_ptr));
    
    always @(posedge rst) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count <= 0;
        data_out <= 8'b00000000;
        temp <= 8'b00000000;
    end
    always @(posedge wrclk) begin
        if( !rst && wr_en && !is_full) begin
                fifo[wr_ptr] <= data_in;
                wr_ptr <= (wr_ptr +1)%size;
        end
    end

    always @(posedge rdclk ) begin
        if (!rst && rd_en && (!is_empty)) begin
        data_out <= fifo[rd_ptr];
        rd_ptr <= (rd_ptr +1)%size;
        
        end
    end
    
    always @(posedge rdclk ) begin
        if (!rst && rd_en && (!is_empty)) begin 
        count <= count - 1;
        end
    end
    always @(posedge wrclk) begin
           if (!rst && wr_en && (!is_full)) begin
           count <= count +1;
           end
          
           
     end
     always @(*) begin
           is_empty <= count ? 0:1;   
           if( size == count) begin 
           is_full <= 1'b1;
           end
           if (size != count) is_full <= 1'b0;
     end
    
    
                
endmodule
