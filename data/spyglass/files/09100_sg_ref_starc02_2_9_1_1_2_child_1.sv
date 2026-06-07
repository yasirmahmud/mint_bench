module complex_for_ex2();
 reg [7:0] data_vec = 8'h00; // Initialized to the final state determined by the original 'initial' block
 // The 'initial' block and 'integer i' were removed because 'initial' blocks are ignored for synthesis.
 // The original 'initial' block sequence:
 // 1. data_vec = 8'hAA (binary 10101010)
 // 2. Loop shifts bits: data_vec[i+1] = data_vec[i]
 //    Tracing the loop with blocking assignments:
 //    - i=0: data_vec[1] = data_vec[0] (0) => data_vec becomes 10101000
 //    - i=1: data_vec[2] = data_vec[1] (0) => data_vec becomes 10100000
 //    - i=2: data_vec[3] = data_vec[2] (0) => data_vec becomes 10100000 (no change, bit already 0)
 //    - i=3: data_vec[4] = data_vec[3] (0) => data_vec becomes 10000000
 //    - i=4: data_vec[5] = data_vec[4] (0) => data_vec becomes 10000000 (no change, bit already 0)
 //    - i=5: data_vec[6] = data_vec[5] (0) => data_vec becomes 10000000 (no change, bit already 0)
 //    - i=6: data_vec[7] = data_vec[6] (0) => data_vec becomes 00000000
 // The final value of data_vec after the 'initial' block executes at time 0 is 8'h00.
 // This synthesizable initialization preserves that final power-up state.
endmodule
