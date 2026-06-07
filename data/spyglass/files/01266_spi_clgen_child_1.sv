module spi_clgen (
  parameter SPI_DIVIDER_LEN = 8, // Define the macro as a parameter with a default value
  input                         wb_clk_in,
  input                         wb_rst,
  input                         tip,
  input                         go,
  input                         last_clk,
  input [`SPI_DIVIDER_LEN-1:0] divider, // Correctly declare divider as an input port
  output                        sclk_out,
  output                        cpol_0,
  output                        cpol_1);

  reg                           sclk_out;
  reg                           cpol_0;
  reg                           cpol_1;
  
  reg [`SPI_DIVIDER_LEN-1:0]    cnt; // This declaration now correctly uses the parameter

  
  
  
  // Counter counts half period
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        cnt <= {{SPI_DIVIDER_LEN{1'b0}},1'b1}; // Macro is now a parameter, access directly
      end
    else if(tip)
      begin
        if(cnt == (divider + 1))
          begin
            cnt <= {{SPI_DIVIDER_LEN{1'b0}},1'b1}; // Macro is now a parameter, access directly
          end
        else
          begin
            cnt <= cnt + 1;
          end
      end
    else if(cnt == 0)
      begin
        cnt <= {{SPI_DIVIDER_LEN{1'b0}},1'b1}; // Macro is now a parameter, access directly
      end
  end
  
  
  // Generation of the serial clock
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        sclk_out <= 1'b0;
      end
    else if(tip)
      begin
        if(cnt == (divider + 1))
          begin
            if(!last_clk || sclk_out)
              sclk_out <= ~sclk_out;
          end
      end
  end
  
  
  // Posedge and negedge detection of sclk
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        cpol_0 <= 1'b0;
        cpol_1 <= 1'b0;
      end
    else
      begin
        cpol_0 <= 1'b0; // Use 1'b0 for clarity, consistent with non-blocking
        cpol_1 <= 1'b0; // Use 1'b0 for clarity, consistent with non-blocking
          if(tip)
            begin
              if(~sclk_out)
                begin
                  if(cnt == divider)
                    begin
                      cpol_0 <= 1'b1; // Use 1'b1 for clarity, consistent with non-blocking
                    end
                end
            end
          if(tip)
            begin
              if(sclk_out)
                begin
                  if(cnt == divider)
                    begin
                      cpol_1 <= 1'b1; // Use 1'b1 for clarity, consistent with non-blocking
                    end
                end
            end
      end
   end


endmodule
