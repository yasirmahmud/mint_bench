module NV_NVDLA_SDP_CMUX_pipe_p2 (
   nvdla_core_clk        //|< i
  ,nvdla_core_rstn       //|< i
  ,cmux2dp_pd            //|< i
  ,cmux2dp_pvld          //|< i
  ,sdp_cmux2dp_ready     //|< i
  ,cmux2dp_prdy          //|> o
  ,sdp_cmux2dp_pd        //|> o
  ,sdp_cmux2dp_valid     //|> o
  );

input  nvdla_core_clk;
input  nvdla_core_rstn;
input  [511:0] cmux2dp_pd; // Pipe input data
input  cmux2dp_pvld; // Pipe input valid
input  sdp_cmux2dp_ready; // Downstream ready for pipe output
output cmux2dp_prdy; // Pipe ready for its input
output [511:0] sdp_cmux2dp_pd; // Pipe output data
output sdp_cmux2dp_valid; // Pipe output valid

reg    [511:0] pipe_data_reg;
reg    pipe_valid_reg;

// Input side handshake signals
wire   pipe_in_fire = cmux2dp_pvld && cmux2dp_prdy;
// Output side handshake signals
wire   pipe_out_fire = sdp_cmux2dp_valid && sdp_cmux2dp_ready;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    pipe_data_reg <= {512{1'b0}};
    pipe_valid_reg <= 1'b0;
  end else begin
    if (pipe_out_fire) begin // Downstream consumes data, clear valid
      pipe_valid_reg <= 1'b0;
    end
    if (pipe_in_fire) begin // Upstream sends data, register it
      pipe_data_reg <= cmux2dp_pd;
      pipe_valid_reg <= 1'b1;
    end
  end
end

// Pipe is ready to accept input if its output is empty or is being consumed
assign cmux2dp_prdy      = !pipe_valid_reg || pipe_out_fire;
assign sdp_cmux2dp_pd    = pipe_data_reg;
assign sdp_cmux2dp_valid = pipe_valid_reg;

endmodule
