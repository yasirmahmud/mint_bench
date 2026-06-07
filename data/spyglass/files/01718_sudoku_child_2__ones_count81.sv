// Black-box definition for ones_count81. Added dummy combinational logic to resolve WarnAnalyzeBBox and W240 violations.
module ones_count81 (
   input [80:0]   in,
   output [6:0]   out
);
   integer j;
   reg [6:0] count;
   always @(*) begin
       count = 0;
       for (j = 0; j < 81; j = j + 1) begin
           if (in[j]) count = count + 1; // Reads 'in'
       end
   end
   assign out = count; // Drives 'out'
endmodule
