module day15 #(
  parameter NUM=4)
  (
    input wire[NUM-1:0] req_i,   // ith request
    output wire[NUM-1:0] grant_o  // grant access
    
  );
  
  assign grant_o[0] = req_i[0];
  
  genvar i;
  for(i= 1 ; i<NUM; i=i+1)begin
    assign grant_o[i] = req_i[i] & ~(|grant_o[i-1:0]);
  end
endmodule
