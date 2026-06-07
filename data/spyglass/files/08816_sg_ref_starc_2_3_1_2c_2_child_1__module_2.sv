primitive unsynth_ff_ex2 (q, d, clk);
 output q;
 input d, clk;
 reg q;
 table
  // For D = 0, CLK rising edge
  0 (01) : 0 : 0; // If current Q is 0, next Q is 0
  0 (01) : 1 : 0; // If current Q is 1, next Q is 0
  0 (01) : x : 0; // If current Q is x, next Q is 0

  // For D = 1, CLK rising edge
  1 (01) : 0 : 1; // If current Q is 0, next Q is 1
  1 (01) : 1 : 1; // If current Q is 1, next Q is 1
  1 (01) : x : 1; // If current Q is x, next Q is 1

  // For CLK falling edge (D don't care)
  x (10) : ? : ?; // Preserve original behavior: output goes to 'x' on falling edge for any current state

  // For CLK low level (D don't care)
  x 0 : ? : -; // Preserve original behavior: hold state on CLK=0 for any current state

  // For CLK high level (D don't care)
  x 1 : ? : -; // Preserve original behavior: hold state on CLK=1 for any current state
 endtable
 endprimitive
