module StreamData (
input wire CLK,               
input wire rst,   
input wire CEB,            
output wire [31:0] output1,    
output wire [31:0] output2,    
output wire [31:0] output3,
output wire [31:0] output4,    
output wire [31:0] output5,    
output wire [31:0] output6,       
output wire [31:0] output7,    
output wire [31:0] output8,    
output wire [31:0] output9,
output wire [31:0] output10,
output wire [31:0] output11,    
output wire [31:0] output12,    
output wire [31:0] output13,
output wire [31:0] output14,    
output wire [31:0] output15,    
output wire [31:0] output16,       
output wire [31:0] output17,    
output wire [31:0] output18,    
output wire [31:0] output19,
output wire [31:0] output20,
output wire [31:0] output21,    
output wire [31:0] output22,    
output wire [31:0] output23,
output wire [31:0] output24,    
output wire [31:0] output25,    
output wire [31:0] output26,       
output wire [31:0] output27,    
output wire [31:0] output28,    
output wire [31:0] output29,
output wire [31:0] output30,
output wire [31:0] output31,    
output wire [31:0] output32,    
output wire [31:0] output33,
output wire [31:0] output34,    
output wire [31:0] output35,    
output wire [31:0] output36,       
output wire [31:0] output37,    
output wire [31:0] output38,    
output wire [31:0] output39,
output wire [31:0] output40,
output wire [31:0] output41,    
output wire [31:0] output42,    
output wire [31:0] output43,
output wire [31:0] output44,    
output wire [31:0] output45,    
output wire [31:0] output46,       
output wire [31:0] output47,    
output wire [31:0] output48,    
output wire [31:0] output49,
output wire [31:0] output50,
output wire [31:0] output51,    
output wire [31:0] output52,    
output wire [31:0] output53,
output wire [31:0] output54,    
output wire [31:0] output55,    
output wire [31:0] output56,       
output wire [31:0] output57,    
output wire [31:0] output58,    
output wire [31:0] output59,   
output wire [31:0] output60,
output wire [31:0] output61,    
output wire [31:0] output62,    
output wire [31:0] output63,
output wire [31:0] output64    
);
             
reg [10:0] Addr;
always @(posedge CLK) begin
  if (rst) begin
    Addr <= 11'd0;
  end else begin
    Addr <= Addr + 11'd1;
  end
end

// All 64 memory_rom modules are identical in functionality and content.
// Replaced the 64 redundant memory_rom_X modules with a single generic 'memory_rom' module
// and instantiated it 64 times.

memory_rom DATA_1(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output1));

memory_rom DATA_2(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output2));

memory_rom DATA_3(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output3));

memory_rom DATA_4(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output4));

memory_rom DATA_5(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output5));

memory_rom DATA_6(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output6));

memory_rom DATA_7(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output7));

memory_rom DATA_8(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output8));

memory_rom DATA_9(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output9));

memory_rom DATA_10(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output10));

memory_rom DATA_11(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output11));

memory_rom DATA_12(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output12));

memory_rom DATA_13(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output13));

memory_rom DATA_14(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output14));

memory_rom DATA_15(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output15));

memory_rom DATA_16(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output16));

memory_rom DATA_17(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output17));

memory_rom DATA_18(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output18));

memory_rom DATA_19(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output19));

memory_rom DATA_20(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output20));

memory_rom DATA_21(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output21));

memory_rom DATA_22(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output22));

memory_rom DATA_23(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output23));

memory_rom DATA_24(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output24));

memory_rom DATA_25(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output25));

memory_rom DATA_26(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output26));

memory_rom DATA_27(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output27));

memory_rom DATA_28(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output28));

memory_rom DATA_29(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output29));

memory_rom DATA_30(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output30));

memory_rom DATA_31(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output31));

memory_rom DATA_32(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output32));

memory_rom DATA_33(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output33));

memory_rom DATA_34(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output34));

memory_rom DATA_35(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output35));

memory_rom DATA_36(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output36));

memory_rom DATA_37(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output37));

memory_rom DATA_38(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output38));

memory_rom DATA_39(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output39));

memory_rom DATA_40(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output40));

memory_rom DATA_41(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output41));

memory_rom DATA_42(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output42));

memory_rom DATA_43(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output43));

memory_rom DATA_44(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output44));

memory_rom DATA_45(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output45));

memory_rom DATA_46(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output46));

memory_rom DATA_47(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output47));

memory_rom DATA_48(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output48));

memory_rom DATA_49(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output49));

memory_rom DATA_50(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output50));

memory_rom DATA_51(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output51));

memory_rom DATA_52(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output52));

memory_rom DATA_53(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output53));

memory_rom DATA_54(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output54));

memory_rom DATA_55(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output55));

memory_rom DATA_56(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output56));

memory_rom DATA_57(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output57));

memory_rom DATA_58(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output58));

memory_rom DATA_59(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output59));

memory_rom DATA_60(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output60));

memory_rom DATA_61(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output61));

memory_rom DATA_62(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output62));

memory_rom DATA_63(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output63));

memory_rom DATA_64(
    .CLK(CLK), .rst(rst),
    .CEB(CEB),
    .Addr(Addr),
    .Q(output64));


endmodule
