module StaticConfiguration
(
 
 input wire  [4:0]          			  iGpuCapabilitesAddr,
 output wire [`GPU_WORD-1:0]          oGpuCapabilitesData
 
 
 );

reg [4:0] rGpuCapabilitesData;

assign oGpuCapabilitesData = {27'b0,rGpuCapabilitesData};

always @( iGpuCapabilitesAddr )
begin
	case (iGpuCapabilitesAddr)
		5'b0: rGpuCapabilitesData  = 5'd`GPU_AABB_COUNT;
		5'b1: rGpuCapabilitesData  = 5'd`SCALE;
	default
		rGpuCapabilitesData = 5'hcaca;
		
	endcase
end
endmodule
