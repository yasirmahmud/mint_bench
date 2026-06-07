module Shifter (
    input  wire        rst,
    input  wire        Sample_clk,
    input  wire        Shift_clk,
    input  wire        Data_in,
    input  wire        shifter_en,
    input  wire        SPDR_wr_en,
    input  wire        SPDR_rd_en,
    input  wire [7:0]  SPDR_in,
    output wire [7:0]  SPDR_out,
    output wire        Data_out
);
    reg [7:0] shift_reg; 
    reg       data_out_reg; 

    // CombLoop (3A) and W240: Make Data_out sequential to break combinational loop and use inputs
    always @(posedge Sample_clk or posedge rst) begin
        if (rst) begin
            shift_reg <= 8'h00;
        end else if (SPDR_wr_en) begin 
            shift_reg <= SPDR_in;
        end else if (shifter_en && Shift_clk) begin 
            shift_reg <= {shift_reg[6:0], Data_in}; 
        end
    end

    always @(posedge Shift_clk or posedge rst) begin
        if (rst) begin
            data_out_reg <= 1'b0;
        end else if (shifter_en && SPDR_rd_en) begin 
            data_out_reg <= shift_reg[7]; 
        end else begin
            data_out_reg <= 1'b0; 
        end
    end

    assign SPDR_out = shift_reg;
    assign Data_out = data_out_reg;
endmodule
