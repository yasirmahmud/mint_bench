module FloatingPointAdder  (
  input signed  [31:0] A,
  input signed [31:0] B,
  output signed [31:0] Sum
);

  reg sign_A, sign_B;       //0->positive      //1-> negative
  reg Sum_sign;            
  
  reg [7:0] exponent_A, exponent_B;
  reg signed [7:0] Sum_exponent;

  reg signed [22:0] mantissa_A, mantissa_B; 
  reg signed [22:0] mantissa_Sum;

  reg signed [31:0] mantissa_A_32, mantissa_B_32,minus_mantissa_A_32,minus_mantissa_B_32;
  wire signed [31:0] mantissa_addAB, mantissa_subAB,mantissa_subBA;
  
  reg [21:0] temp_mantissa;
  integer i;
  wire cout;
  wire overflow1,overflow2,overflow3;
  reg signed [7:0] exponent_diff;

   CarryBypassAdder mantissa_add(
        .A(mantissa_A_32),
        .B(mantissa_B_32),
        .Cin(1'b0),
        .Sum(mantissa_addAB),
        .Cout(cout),
        .Overflow(overflow1)
      );
  CarryBypassAdder mantissa_subA_B(
       .A(mantissa_A_32),
       .B(minus_mantissa_A_32),
       .Cin(1'b0),
       .Sum(mantissa_subAB),
       .Cout(cout),
       .Overflow(overflow2)
     );
  CarryBypassAdder mantissa_subB_A(
       .A(minus_mantissa_A_32),
       .B(mantissa_B_32),
       .Cin(1'b0),
       .Sum(mantissa_subBA),
       .Cout(cout),
       .Overflow(overflow3)
     );

  always @* begin
    //decompose numbers into sign,exponent,mantissa
     sign_A = A[31]; //most significant bit 
     sign_B = B[31]; 

     exponent_A = A[30:23];    // 8-bits 30 -> 23
     exponent_B = B[30:23];    

     mantissa_A =  A[22:0];
     mantissa_B =  B[22:0];

    //compute the exponent difference then align the mantissas
    exponent_diff = exponent_A - exponent_B;
    if (exponent_diff < 0) begin
      Sum_exponent = exponent_B;
      mantissa_A = $signed(mantissa_A) >>> -exponent_diff; 
      Sum_sign = sign_B;
    end else begin
      Sum_exponent = exponent_A;
      mantissa_B = $signed(mantissa_B) >>> exponent_diff;
      Sum_sign = sign_A;
    end
	 
    mantissa_A_32 = { {9{mantissa_A[22]}}, mantissa_A };  //sign-expansion with the sign bit
    mantissa_B_32 = { {9{mantissa_B[22]}}, mantissa_B };  

	  if (sign_A == sign_B) begin
      mantissa_Sum=mantissa_addAB[22:0];   //same sign add numbers
    end else begin
      if (mantissa_A > mantissa_B) begin    //different signs subtract 
        minus_mantissa_A_32= -mantissa_B_32;
        mantissa_Sum=mantissa_subAB[22:0];
        Sum_sign = sign_A;
      end else begin
        minus_mantissa_A_32= -mantissa_A_32;
        mantissa_Sum=mantissa_subBA[22:0];
        Sum_sign = sign_B;
      end
    end

    //normalize mantissa after summation 
	  temp_mantissa=mantissa_Sum[21:0];
    if (mantissa_Sum==23'b0) begin
      temp_mantissa=22'b0;
    end else begin
      for(i = 0; i < 22; i = i + 1) begin
        if(temp_mantissa[21]==0) begin
        temp_mantissa = temp_mantissa <<1;
        Sum_exponent =Sum_exponent-1;
        end
      end
    end
    mantissa_Sum[21:0]=temp_mantissa;
	 
  end

  //reassmble the Sum
  assign Sum = {Sum_sign, Sum_exponent, mantissa_Sum};

endmodule
