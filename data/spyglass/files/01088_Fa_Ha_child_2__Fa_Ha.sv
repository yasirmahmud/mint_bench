module Fa_Ha(input A,B,Cin,
    output sum,carry
    );
    wire w1_sum1,w2_carry1,w3;
    half_adder a1(A,B,w1_sum1,w2_carry1);
    half_adder a2(w1_sum1,Cin,sum,w3 );
    half_adder a3(.in1(w2_carry1), .in2(w3), .sum_out(carry), .carry_out());
endmodule
