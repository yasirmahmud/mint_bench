module ejector #(
  parameter WIDTH_PORT = 32,
  parameter NUM_CHANNEL = 5
) (
  input   [`NUM_CHANNEL-1:0]  localVector,
  input   [`WIDTH_PORT-1:0]   flit0,
  input   [`WIDTH_PORT-1:0]   flit1,
  input   [`WIDTH_PORT-1:0]   flit2,
  input   [`WIDTH_PORT-1:0]   flit3,
  input   [`WIDTH_PORT-1:0]   flit4,
  output  [`WIDTH_PORT-1:0]   localFlit
);

reg [`WIDTH_PORT-1:0] r_local = 0;

always @ * begin
   casex (localVector)
      // Replacing `NUM_CHANNEL'b with the resolved parameter value '5'b
      5'b1XXXX: r_local = flit4;
      5'b01XXX: r_local = flit3;
      5'b001XX: r_local = flit2;
      5'b0001X: r_local = flit1;
      5'b00001: r_local = flit0;      
      default: r_local = 0; // normally, it is impossible since conflicts have been resolved in PA.
   endcase
end

assign localFlit = r_local;


endmodule
