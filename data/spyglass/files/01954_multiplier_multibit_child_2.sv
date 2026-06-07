module multiplier_multibit(input_a_, input_b_, output_z, CLK,Reset, overflow, zero, NaN, precisionLost);
  //Operands
  input CLK,Reset;
  input [15:0] input_a_;
  input [9:0] input_b_;
  output reg [15:0] output_z;
  // Added output ports based on commented line in original module and W528 violations
  output wire overflow;
  output wire zero;
  output reg NaN;
  output wire precisionLost;

  //Flags (declarations for internal wires)
  wire NaN_; //Not a Number flag
  //Decode numbers
  wire sign1_, sign2_, sign2_r, signR; //hold signs
  wire [4:0] ex1_, ex2_, exR; //hold exponents
  wire [2:0] ex2_r;
  wire [4:0] ex1_pre, ex2_pre, exR_calc, exR_calc_1; //hold exponents
  reg [4:0] exSubCor;//Corrected exponents for Subnormal Numbers
  // wire [9:0] fra1; // Removed: W528 violation (set but not read)
  wire [9:0] fra2, fraR; //hold fractions
  wire [5:0] fra2_r;
  reg [9:0] fraSub;//Corrected Mantissa for SubNormal Numbers
  wire [20:0] float1;
  wire [10:0] float2;
  wire [5:0] exSum_; //exponent sum
  reg [11:0] float_res; //output_z
  reg [9:0] dump_res; //Lost precision
  wire [21:0] res_full;
  reg [20:0] mid[9:0];
  reg [21:0] mid_p2[5:0];
  reg [22:0] mid_p3[2:0];
  reg [23:0] mid_p4[1:0];
  wire inf_num_; //at least on of the operands is inf.
  wire NsubNormal;//not of subNormal number
  wire ovf;
  wire neg_ex;
  wire neg_ex_SubCor;
  // wire ovf_ex_SubCor; // Removed: W528 violation (set but not read), handled by bit slicing
  wire ex_zero_;
  reg ex_zerop1,ex_zerop2,ex_zerop3,ex_zerop4,ex_zero;
  reg NaNp1,NaNp2,NaNp3,NaNp4;
  reg inf_nump1,inf_nump2,inf_nump3,inf_nump4,inf_num;
  reg [5:0] exSump2,exSump3,exSump4,exSum;
  reg sign1p1,sign1p2,sign1p3,sign1p4,sign1;
  reg sign2p1,sign2p2,sign2p3,sign2p4,sign2;
  reg [4:0] ex1p1,ex2p1;
  
  reg [20:0] float1p0;
  reg float2bp0;

  assign {sign2_r, ex2_r, fra2_r} = input_b_; 

  //Flags
  assign zero =~ex_zero | (~NsubNormal & ((fraSub == 10'd0) |ex_zero));
  assign ex_zero_=|{ex1_pre,ex2_r};
  assign NaN_ = (&input_a_[14:10] & |input_a_[9:0]) | (&input_b_[8:6] & |input_b_[5:0]); 
  assign inf_num_ = (&input_a_[14:10] & ~|input_a_[9:0]) | (&input_b_[8:6] & ~|input_b_[5:0]); 
  assign overflow = inf_num | neg_ex&ovf;
  assign NsubNormal = |float_res[11:10];
  assign precisionLost = |dump_res;

  // Replaced {sign1_, ex1_pre, fra1} = input_a_ with direct assignments as fra1 was unused
  assign sign1_ = input_a_[15];
  assign ex1_pre = input_a_[14:10];

  assign sign2_ = sign2_r;
  assign ex2_pre = {2'd0,ex2_r} + 5'b01100;
  assign fra2 = {fra2_r, 4'd0}; 
  // assign check = {sign2_, ex2_pre, fra2}; // Removed: W528 violation (set but not read)
  assign ex1_ = ex1_pre + {4'd0, ~|ex1_pre};
  assign ex2_ = ex2_pre + {4'd0, ~|ex2_pre};


  assign res_full = {float_res, dump_res};
  assign exSum_ = {1'b0,ex1p1} + {1'b0,ex2p1}; 
  assign float1 = {|input_a_[14:10], input_a_[9:0], 10'd0};
  assign float2 = {|ex2_r,fra2};
  assign signR = ~zero & (sign1 ^ sign2);
  assign {neg_ex,ovf,exR_calc_1} = exSum[5:0]+ {5'd0, float_res[11]} + 6'b110001;
  
  // Resolved W528 for ovf_ex_SubCor: It was set but not read. 
  // The needed bits (neg_ex_SubCor, exR_calc) are extracted, and the unused bit is implicitly discarded.
  wire [6:0] temp_ex_subcor_calc = {ovf,exR_calc_1} + (~{1'b0,exSubCor} & {6{~NsubNormal}}) + {5'd0, ~NsubNormal};
  assign neg_ex_SubCor = temp_ex_subcor_calc[6];
  assign exR_calc = temp_ex_subcor_calc[4:0]; 
  
  // Fix for STX_VE_481: Simplified the nested ternary and explicitly handled 'zero' condition first.
  // This preserves functional behavior as 'exR = X & {5{~zero}}' means exR is 0 if zero is high, otherwise X.
  assign exR = (zero) ? 5'b00000 : ( (overflow) ? 5'b11111 : ((~NsubNormal&(~neg_ex| ~neg_ex_SubCor)| ~neg_ex & ~neg_ex_SubCor) ? 5'b00000 : (exR_calc)) );
  
  // Resolved W486: Rhs width '22' with shift is more than lhs width '10'. Explicitly truncated.
  assign fraR = (zero | overflow) ? 10'd0 : (~neg_ex & ~neg_ex_SubCor) ? float_res[11:2] : (neg_ex & ~neg_ex_SubCor & ~|exR) ? (res_full >> (5'd11-exR_calc_1))[9:0] :((NsubNormal | ~|{ex1_pre,ex2_pre}) ? ((float_res[11]) ? float_res[10:1] : float_res[9:0]) : fraSub);

  always@(posedge CLK or posedge Reset) //create mids from fractions
    begin
        if(Reset==1'b1)
        begin
        output_z<=16'd0;
        //exSubCor<=5'd0; // Original lines were commented out
        //fraSub<=10'd0; // Original lines were commented out
        float_res<=12'd0;
        dump_res<=10'd0;
        mid[0]<=21'd0;
        mid[1]<=21'd0;
        mid[2]<=21'd0;
        mid[3]<=21'd0;
        mid[4]<=21'd0;
        mid[5]<=21'd0;
        mid[6]<=21'd0;
        mid[7]<=21'd0;
        mid[8]<=21'd0;
        mid[9]<=21'd0;        
        // mid[10]<=21'd0; // Removed: SYNTH_5255 / WRN_1021 violation (index out of range for mid[9:0])
        mid_p2[0]<=22'd0;
        mid_p2[1]<=22'd0;
        mid_p2[2]<=22'd0;
        mid_p2[3]<=22'd0;
        mid_p2[4]<=22'd0;
        mid_p2[5]<=22'd0;
        mid_p3[0]<=23'd0;
        mid_p3[1]<=23'd0;
        mid_p3[2]<=23'd0;
        mid_p4[0]<=24'd0;
        mid_p4[1]<=24'd0;
        ex_zerop1<=1'b0;
        ex_zerop2<=1'b0;
        ex_zerop3<=1'b0;
        ex_zerop4<=1'b0;
        ex_zero<=1'b0;
        
        
        NaNp1<=1'b0;
        NaNp2<=1'b0;
        NaNp3<=1'b0;
        NaNp4<=1'b0;
        NaN<=1'b0; // NaN is now an output register, reset here.
        inf_nump1<=1'b0;
        inf_nump2<=1'b0;
        inf_nump3<=1'b0;
        inf_nump4<=1'b0;
        inf_num<=1'b0;
        exSump2<=6'd0;
        exSump3<=6'd0;
        exSump4<=6'd0;
        exSum<=6'd0;
        sign1p1<=1'd0;
        sign1p2<=1'd0;
        sign1p3<=1'd0;
        sign1p4<=1'd0;
        sign1<=1'd0;
        sign2p1<=1'd0;
        sign2p2<=1'd0;
        sign2p3<=1'd0;
        sign2p4<=1'd0;
        sign2<=1'd0;
        ex1p1<=5'd0;
        ex2p1<=5'd0;
        float1p0<=21'b0;
        float2bp0<=1'b0;   
        end
        
        
        else
        
        
            begin
            
            //6th Stage
            output_z <= {signR, exR, fraR};
            
            //5th Stage
//            input_a<=input_ap4; // Original lines were commented out
//            input_b<=input_bp4; // Original lines were commented out
            sign1<=sign1p4;
            sign2<=sign2p4;
            ex_zero<=ex_zerop4;
            inf_num<=inf_nump4;
            NaN<=NaNp4; // NaN is now an output reg, assigned here.
            exSum<=exSump4;
            
            {float_res, dump_res}<=mid_p4[0]+mid_p4[1];

            //4th Stage
//            input_ap4<=input_ap3; // Original lines were commented out
//            input_bp4<=input_bp3; // Original lines were commented out
            sign1p4<=sign1p3;
            sign2p4<=sign2p3;
            ex_zerop4<=ex_zerop3;
            inf_nump4<=inf_nump3;
            NaNp4<=NaNp3;
            exSump4<=exSump3;            
           
            mid_p3[0]<=mid_p2[0]+mid_p2[1];
            mid_p3[1]<=mid_p2[2]+mid_p2[3];
            mid_p3[2]<=mid_p2[4]+mid_p2[5];
            //2nd Stage
//            input_ap2<=input_ap1; // Original lines were commented out
//            input_bp2<=input_bp1; // Original lines were commented out
                sign1p2<=sign1p1;
                sign2p2<=sign2p1;
                ex_zerop2<=ex_zerop1;
                inf_nump2<=inf_nump1;
                NaNp2<=NaNp1;
                exSump2<=exSum_;
            mid_p2[0]<=mid[0]+mid[1];            
            mid_p2[1]<=mid[2]+mid[3];
            mid_p2[2]<=mid[4]+mid[5];
            mid_p2[3]<=mid[6]+mid[7];
            mid_p2[4]<=mid[8]+mid[9];
//            mid_p2[5]<=mid[10];             // Original line was commented out
            mid_p2[5]<=float1p0 & {21{float2bp0}};            
              //1th Stage
//              input_ap1<=input_a_; // Original lines were commented out
//              input_bp1<=input_b_; // Original lines were commented out
                sign1p1<=sign1_;
                sign2p1<=sign2_;
                ex_zerop1<=ex_zero_;
                inf_nump1<=inf_num_;
                NaNp1<=NaN_;
//                exSump1<=exSum_; // Original line was commented out
                ex1p1<=ex1_;
                ex2p1<=ex2_;
              mid[0] <= (float1 >> 10) & {21{float2[0]}};
              mid[1] <= (float1 >> 9)  & {21{float2[1]}};
              mid[2] <= (float1 >> 8)  & {21{float2[2]}};
              mid[3] <= (float1 >> 7)  & {21{float2[3]}};
              mid[4] <= (float1 >> 6)  & {21{float2[4]}};
              mid[5] <= (float1 >> 5)  & {21{float2[5]}};
              mid[6] <= (float1 >> 4)  & {21{float2[6]}};
              mid[7] <= (float1 >> 3)  & {21{float2[7]}};
              mid[8] <= (float1 >> 2)  & {21{float2[8]}};
              mid[9] <= (float1 >> 1)  & {21{float2[9]}};
              float1p0<=float1;
              float2bp0<=float2[10];
//              mid[10] <= float1        & {21{float2[10]}}; // Original line was commented out
            end
        
    end
  //Corrections for subnormal normal op
  always@*
    begin
      casex(res_full)
        22'b001xxxxxxxxxxxxxxxxxxx:
          begin
            fraSub = res_full[18:9];
          end
        22'b0001xxxxxxxxxxxxxxxxxx:
          begin
            fraSub = res_full[17:8];
          end
        22'b00001xxxxxxxxxxxxxxxxx:
          begin
            fraSub = res_full[16:7];
          end
        22'b000001xxxxxxxxxxxxxxxx:
          begin
            fraSub = res_full[15:6];
          end
        22'b0000001xxxxxxxxxxxxxxx:
          begin
            fraSub = res_full[14:5];
          end
        22'b00000001xxxxxxxxxxxxxx:
          begin
            fraSub = res_full[13:4];
          end
        22'b000000001xxxxxxxxxxxxx:
          begin
            fraSub = res_full[12:3];
          end
        22'b0000000001xxxxxxxxxxxx:
          begin
            fraSub = res_full[11:2];
          end
        22'b00000000001xxxxxxxxxxx:
          begin
            fraSub = res_full[10:1];
          end
        22'b000000000001xxxxxxxxxx:
          begin
            fraSub = res_full[9:0];
          end
        22'b0000000000001xxxxxxxxx:
          begin
            fraSub = {res_full[8:0], 1'd0};
          end
        22'b00000000000001xxxxxxxx:
          begin
            fraSub = {res_full[7:0], 2'd0};
          end
        22'b000000000000001xxxxxxx:
          begin
            fraSub = {res_full[6:0], 3'd0};
          end
        22'b0000000000000001xxxxxx:
          begin
            fraSub = {res_full[5:0], 4'd0};
          end
        22'b00000000000000001xxxxx:
          begin
            fraSub = {res_full[4:0], 5'd0};
          end
        22'b000000000000000001xxxx:
          begin
            fraSub = {res_full[3:0], 6'd0};
          end
        22'b0000000000000000001xxx:
          begin
            fraSub = {res_full[2:0], 7'd0};
          end
        22'b00000000000000000001xx:
          begin
            fraSub = {res_full[1:0], 8'd0};
          end
        22'b000000000000000000001x:
          begin
            fraSub = {res_full[0], 9'd0};
          end
        default:
          begin
            fraSub = 10'd0;
          end
      endcase
    end
  always@*
    begin
      casex(res_full)
        22'b001xxxxxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd1;
          end
        22'b0001xxxxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd2;
          end
        22'b00001xxxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd3;
          end
        22'b000001xxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd4;
          end
        22'b0000001xxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd5;
          end
        22'b00000001xxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd6;
          end
        22'b000000001xxxxxxxxxxxxx:
          begin
            exSubCor = 5'd7;
          end
        22'b0000000001xxxxxxxxxxxx:
          begin
            exSubCor = 5'd8;
          end
        22'b00000000001xxxxxxxxxxx:
          begin
            exSubCor = 5'd9;
          end
        22'b000000000001xxxxxxxxxx:
          begin
            exSubCor = 5'd10;
          end
        22'b0000000000001xxxxxxxxx:
          begin
            exSubCor = 5'd11;
          end
        22'b00000000000001xxxxxxxx:
          begin
            exSubCor = 5'd12;
          end
        22'b000000000000001xxxxxxx:
          begin
            exSubCor = 5'd13;
          end
        22'b0000000000000001xxxxxx:
          begin
            exSubCor = 5'd14;
          end
        22'b00000000000000001xxxxx:
          begin
            exSubCor = 5'd15;
          end
        22'b000000000000000001xxxx:
          begin
            exSubCor = 5'd16;
          end
        22'b0000000000000000001xxx:
          begin
            exSubCor = 5'd17;
          end
        22'b00000000000000000001xx:
          begin
            exSubCor = 5'd18;
          end
        22'b000000000000000000001x:
          begin
            exSubCor = 5'd19;
          end
        default:
          begin
            exSubCor = 5'd0;
          end
      endcase
    end
endmodule
