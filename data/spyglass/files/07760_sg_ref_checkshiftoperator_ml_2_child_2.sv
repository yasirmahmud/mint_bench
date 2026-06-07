module check_shift_ex2 (
    output [7:0] result_out
);
 wire signed [7:0] s_val;
 wire [7:0] result;

 // Fix: Drive 's_val' to resolve "read but never set" violation
 // Assigning a signed value (e.g., -1) to demonstrate signed shift behavior
 assign s_val = 8'sd-1; // 8'hFF as a signed 8-bit number

 // Original functional behavior: arithmetic right shift of s_val
 assign result = s_val[7:0] >> 1;

 // Fix: Make 'result' an output to resolve "set but not read" violation
 assign result_out = result;
endmodule
