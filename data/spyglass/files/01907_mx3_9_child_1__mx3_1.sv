module mx3_1 (inp, sel, out);
  input [2:0] inp;
  input [1:0] sel;
  output out;

  assign out = (sel == 2'b00) ? inp[0] :
               (sel == 2'b01) ? inp[1] :
               (sel == 2'b10) ? inp[2] :
               1'bx; // Handles sel = 2'b11, typically results in 'X' or default '0'

endmodule
