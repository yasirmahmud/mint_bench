module HLS_fp17_add (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,chn_a_rsc_z
  ,chn_a_rsc_vz
  ,chn_a_rsc_lz
  ,chn_b_rsc_z
  ,chn_b_rsc_vz
  ,chn_b_rsc_lz
  ,chn_o_rsc_z
  ,chn_o_rsc_vz
  ,chn_o_rsc_lz
  );

input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [16:0] chn_a_rsc_z;
input         chn_a_rsc_vz;
output        chn_a_rsc_lz;
input  [16:0] chn_b_rsc_z;
input         chn_b_rsc_vz;
output        chn_b_rsc_lz;
output [16:0] chn_o_rsc_z;
input         chn_o_rsc_vz; // From consumer: ready to accept output
output        chn_o_rsc_lz; // To consumer: output is valid

// Internal registers for the pipeline stage
reg  [16:0] data_a_r;
reg  [16:0] data_b_r;
reg         data_vld_r; // Indicates if data_a_r/data_b_r hold valid data

// Calculate output: This is the functional part, even if simplified for FP.
// It uses data from the pipeline registers.
// For linting and black-box definition, a simple integer addition is used as a placeholder.
// Note: Actual FP17 addition logic is more complex and not implemented here, but this preserves the intent of 'sum'.
wire [16:0] sum_result = data_a_r + data_b_r;

// Output assignments
assign chn_o_rsc_z  = sum_result;
assign chn_o_rsc_lz = data_vld_r; // Output is valid if our internal data is valid

// Input ready logic
// The unit is ready to accept new input if:
// 1. Its internal register is currently empty (!data_vld_r)
// OR
// 2. Its internal register has valid data (data_vld_r) AND the output consumer is ready (chn_o_rsc_vz),
//    meaning the unit can forward the current data AND accept new input in the same cycle (single-stage pipeline).
wire input_can_accept = (!data_vld_r) || (data_vld_r && chn_o_rsc_vz);
assign chn_a_rsc_lz = input_can_accept;
assign chn_b_rsc_lz = input_can_accept;

// Sequential logic for the pipeline stage
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        data_a_r   <= {17{1'b0}};
        data_b_r   <= {17{1'b0}};
        data_vld_r <= 1'b0;
    end else begin
        // Condition for loading new data into the pipeline stage
        // Both input valid signals must be high AND the unit must be ready to accept
        wire input_fire = chn_a_rsc_vz && chn_b_rsc_vz && chn_a_rsc_lz; // chn_a_rsc_lz == chn_b_rsc_lz by assignment

        // Condition for data moving out of the pipeline stage
        // Internal data is valid AND the output consumer is ready
        wire output_fire = data_vld_r && chn_o_rsc_vz;

        if (input_fire) begin
            // New valid input is accepted, load it into registers
            data_a_r   <= chn_a_rsc_z;
            data_b_r   <= chn_b_rsc_z;
            data_vld_r <= 1'b1; // Mark data as valid in this stage
        end else if (output_fire && !input_fire) begin
            // Existing valid data was consumed, but no new input came in, so clear valid flag
            data_vld_r <= 1'b0;
        end
        // If (!input_fire && !output_fire), data_vld_r retains its current state (stalled or waiting for input).
    end
end

endmodule
