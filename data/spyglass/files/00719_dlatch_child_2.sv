module dlatch  (
  input d, 
  input en, 
  input rst, 
  output reg q
);

  
  // This module is intended to be a D-latch, as described in the natural-language description.
  // The SpyGlass "InferLatch" violation correctly identifies that a latch is inferred.
  // Changing the RTL to avoid latch inference would convert the design into a flip-flop
  // or combinational logic, thereby altering its functional behavior from a level-sensitive latch
  // to an edge-sensitive flip-flop or purely combinational output. This would violate
  // the requirement to "preserve the functional behavior of the design as described in the
  // natural-language description". Therefore, no RTL change is needed as the current RTL
  // correctly implements the specified D-latch behavior.
  always@(d,en,rst)
    begin
    	if(rst)
      		q<=0;
  	else
      		if(en)
        		q<=d;
    end
  
endmodule
