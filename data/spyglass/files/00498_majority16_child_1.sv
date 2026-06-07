module majority16 (Out, Data);
  input [0:15] Data;
  output Out;
  reg [0:4] count; // 'count' will be assigned once
  integer i; // Fixes W480: Loop index 'i' is now of type integer

  assign Out = count > 5'b1000 ? 1 : 0;

  always @ (Data) begin
    reg [0:4] temp_count; // Local variable to accumulate count, fixes W415a
    temp_count = 5'b0; // Initialize local counter
    for (i=0; i<= 15; i=i+1) begin // 'i' is now integer
      if (Data[i] == 1) 
        temp_count = temp_count + 1;
    end
    count = temp_count; // Assign final value to 'count' once
  end
endmodule
