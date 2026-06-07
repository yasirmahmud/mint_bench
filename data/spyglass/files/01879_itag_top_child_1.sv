module itag_top (
    input bist_reset, 
    input [1:0] bist_mode, 
    input [ic_msb-4:0] icu_tag_addr, 
    input [it_msb:0] icu_tag_in, 
    input icu_tag_vld, 
    input icu_tag_we, 
    input clk, 
    input enable, 
    input test_mode, 
    output ERROR, 
    output [it_msb:0] itag_dout, 
    output itag_vld, 
    output itag_hit
);

   // Define parameters for bus widths. These would typically come from an include file.
   // Providing default values to resolve undefined macro errors (STX_VE_533).
   parameter ic_msb = 31; // Example: MSB for a 32-bit address bus (width ic_msb+1)
   parameter it_msb = 31; // Example: MSB for a 32-bit tag data bus (width it_msb+1)

   // Removed redundant input/output declarations that were causing "port not defined"
   // errors (STX_VE_643) and "identifier not declared" (STX_VE_606).
   // The declarations are now directly in the module port list above.

   wire BACKGROUND;  
   wire [ic_msb-4:0] BIST_ADR;  
   wire BIST_CLK;  
   wire BIST_ON;  
   wire BIST_WE;  
   wire END_SEQ;  
   wire ERRN_ON;  
   wire INVERSE;  
   wire NO_COMP;  
   wire rritag_ERROR;  
   wire [it_msb+1:0] PATTERN;  

   itag_Controller  Controller_Ins ( .TCLK(clk), .TRESET(bist_reset), .MODE(bist_mode),
               .test_mode(test_mode), .rritag_ERROR(rritag_ERROR), 
               .BIST_ADR(BIST_ADR), .BIST_WE(BIST_WE), .INVERSE(INVERSE),
               .END_SEQ(END_SEQ), .BIST_ON(BIST_ON), .ERRN_ON(ERRN_ON),
               .NO_COMP(NO_COMP), .BACKGROUND(BACKGROUND), 
               .DONE(), .ERROR(ERROR), .FAIL() );

   itag  itag ( .icu_tag_addr(icu_tag_addr), .bist_icu_tag_addr(BIST_ADR),
         .clk(clk), .icu_tag_in(icu_tag_in), 
         .icu_tag_vld(icu_tag_vld),
         .bist_icu_tag_in(PATTERN[it_msb+1:1]), 
         .bist_icu_tag_vld(PATTERN[0]), 
         .icu_tag_we(icu_tag_we), .bist_icu_tag_we(BIST_WE), .enable(enable),
         .bist_enable(1'b1), .test_mode(test_mode), 
         .itag_dout(itag_dout), 
         .itag_vld(itag_vld), .itag_hit(itag_hit) );

   rritag_LocalBist rritag_Bist_Ins ( .func_do({itag_dout,itag_vld}), 
         .BIST_WE(BIST_WE),
         .ERRN_ON(ERRN_ON), .INVERSE(INVERSE), .NO_COMP(NO_COMP),
         .END_SEQ(END_SEQ), .BACKGROUND(BACKGROUND), .BIST_ADR(BIST_ADR),
         .rritag_ERROR(rritag_ERROR), .PATTERN(PATTERN) );

endmodule
