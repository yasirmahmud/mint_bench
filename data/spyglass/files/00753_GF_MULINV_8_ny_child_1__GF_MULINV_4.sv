// Global functions, accessible to all modules
function [3:0] gf_sq4;
   input [3:0] x;
   begin
     gf_sq4[0] = x[3] ^ x[1] ^ x[0];
     gf_sq4[1] = x[2] ^ x[1];
     gf_sq4[2] = x[3] ^ x[2];
     gf_sq4[3] = x[3];      
   end
endfunction // gf_sq4

function [3:0] gf_mul4;
   input [3:0] x, y;
   begin
     gf_mul4[3] = x[3]&y[3] ^ x[3]&y[1] ^ x[1]&y[3] ^ 
                  x[2]&y[3] ^ x[2]&y[1] ^ x[0]&y[3] ^
                  x[3]&y[2] ^ x[3]&y[0] ^ x[1]&y[2];
     
     gf_mul4[2] = x[3]&y[3] ^ x[3]&y[1] ^ x[1]&y[3] ^
                  x[2]&y[2] ^ x[2]&y[0] ^ x[0]&y[2];
     
     gf_mul4[1] = x[2]&y[3] ^ x[3]&y[2] ^ x[2]&y[2]^
                  x[1]&y[1] ^ x[0]&y[1] ^ x[1]&y[0];
     
     gf_mul4[0] = x[3]&y[3] ^ x[2]&y[3] ^ x[3]&y[2]^
                  x[1]&y[1] ^ x[0]&y[0];   
   end
endfunction

function [3:0] gf_mul4_lambda;
   input [3:0] x;
   begin
     gf_mul4_lambda[3] = x[2] ^ x[0];
     gf_mul4_lambda[2] = x[3] ^ x[2] ^ x[1] ^ x[0];
     gf_mul4_lambda[1] = x[3];
     gf_mul4_lambda[0] = x[2];
   end
endfunction

// Definition for GF_MULINV_4 module to resolve black-box violation
module GF_MULINV_4 (a, a_inv);
   input [3:0] a;
   output [3:0] a_inv;

   wire [3:0] a2, a4, a8;
   
   // Compute powers of a using gf_sq4 (a^2, a^4, a^8)
   assign a2 = gf_sq4(a);
   assign a4 = gf_sq4(a2);
   assign a8 = gf_sq4(a4);

   // Compute a_inv = a^14 = a^8 * a^4 * a^2
   // Handle the zero input case: if a is 0, a_inv is 0.
   assign a_inv = (a == 4'h0) ? 4'h0 : gf_mul4(gf_mul4(a8, a4), a2);

endmodule
