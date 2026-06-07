module NV_NVDLA_SDP_MRDMA_EG_DOUT_pipe_p1 (
   nvdla_core_clk               //|< i
  ,nvdla_core_rstn              //|< i
  ,dat_pd                       //|< w
  ,dat_vld                      //|< w
  ,sdp_mrdma2cmux_ready         //|< i
  ,dat_rdy                      //|> w
  ,sdp_mrdma2cmux_pd            //|> o
  ,sdp_mrdma2cmux_valid         //|> o
  );

// Inferred data width from instantiation
localparam DATA_WIDTH = 514;

input  nvdla_core_clk;
input  nvdla_core_rstn;
input  [DATA_WIDTH-1:0] dat_pd;
input  dat_vld;
input  sdp_mrdma2cmux_ready;
output dat_rdy;
output [DATA_WIDTH-1:0] sdp_mrdma2cmux_pd;
output sdp_mrdma2cmux_valid;

reg  [DATA_WIDTH-1:0] pipe_data_reg;
reg  pipe_valid_reg;

// Output assignments to external ports
assign sdp_mrdma2cmux_pd    = pipe_data_reg;
assign sdp_mrdma2cmux_valid = pipe_valid_reg;

// Input ready logic for the upstream producer
// The pipeline stage is ready if its internal register is empty (!pipe_valid_reg)
// OR if its internal register contains valid data (pipe_valid_reg) AND the downstream consumer is ready to accept it (sdp_mrdma2cmux_ready).
assign dat_rdy = sdp_mrdma2cmux_ready || !pipe_valid_reg;

// Register update logic
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    pipe_data_reg  <= '0;
    pipe_valid_reg <= 1'b0;
  end else begin
    // If the upstream has valid data AND this stage is ready to accept it
    if (dat_vld && dat_rdy) begin
      pipe_data_reg  <= dat_pd;
      pipe_valid_reg <= 1'b1;
    end
    // Else, if this stage holds valid data AND the downstream is ready to consume it
    // This condition is mutually exclusive with the first 'if' due to 'else if'.
    // If a new valid input is accepted, it takes precedence.
    // If no new input is accepted, but existing data is consumed, the valid bit is cleared.
    else if (pipe_valid_reg && sdp_mrdma2cmux_ready) begin
      pipe_valid_reg <= 1'b0;
    end
  end
end

endmodule
