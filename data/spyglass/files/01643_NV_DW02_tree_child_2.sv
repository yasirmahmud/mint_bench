module NV_DW02_tree(
    INPUT,
    OUT0,
    OUT1
);

parameter num_inputs = 8;
parameter input_width = 8;

input [num_inputs*input_width-1 : 0]    INPUT;
output [input_width-1:0]        OUT0, OUT1;

// Maximum number of elements in any stage's buffer. Max is `num_inputs`.
localparam MAX_NUM_ELEMENTS = num_inputs;

// Define a sufficiently large number of stages to unroll the iterative reduction.
// For num_inputs up to 128, 12 stages are sufficient (e.g., 128 -> 86 -> 58 -> 39 -> 26 -> 18 -> 12 -> 8 -> 6 -> 4 -> 3 -> 2 takes 11 reductions).
localparam MAX_GEN_STAGES = 12;

// Wire arrays to store the results of each reduction stage.
// stage_output_arrays[0] holds the initial sliced inputs.
// stage_output_arrays[k+1] holds the result of applying reduction logic to stage_output_arrays[k].
wire [input_width-1 : 0] stage_output_arrays[MAX_GEN_STAGES+1][MAX_NUM_ELEMENTS-1 : 0];

// Localparams to pre-calculate the number of active elements for each stage.
// This is required for Verilog-2001 generate blocks to handle parameter-dependent loop bounds correctly.
localparam stage_0_num_in = num_inputs;
localparam stage_1_num_in = (stage_0_num_in > 2) ? (2*(stage_0_num_in/3) + (stage_0_num_in%3)) : stage_0_num_in;
localparam stage_2_num_in = (stage_1_num_in > 2) ? (2*(stage_1_num_in/3) + (stage_1_num_in%3)) : stage_1_num_in;
localparam stage_3_num_in = (stage_2_num_in > 2) ? (2*(stage_2_num_in/3) + (stage_2_num_in%3)) : stage_2_num_in;
localparam stage_4_num_in = (stage_3_num_in > 2) ? (2*(stage_3_num_in/3) + (stage_3_num_in%3)) : stage_3_num_in;
localparam stage_5_num_in = (stage_4_num_in > 2) ? (2*(stage_4_num_in/3) + (stage_4_num_in%3)) : stage_4_num_in;
localparam stage_6_num_in = (stage_5_num_in > 2) ? (2*(stage_5_num_in/3) + (stage_5_num_in%3)) : stage_5_num_in;
localparam stage_7_num_in = (stage_6_num_in > 2) ? (2*(stage_6_num_in/3) + (stage_6_num_in%3)) : stage_6_num_in;
localparam stage_8_num_in = (stage_7_num_in > 2) ? (2*(stage_7_num_in/3) + (stage_7_num_in%3)) : stage_7_num_in;
localparam stage_9_num_in = (stage_8_num_in > 2) ? (2*(stage_8_num_in/3) + (stage_8_num_in%3)) : stage_8_num_in;
localparam stage_10_num_in = (stage_9_num_in > 2) ? (2*(stage_9_num_in/3) + (stage_9_num_in%3)) : stage_9_num_in;
localparam stage_11_num_in = (stage_10_num_in > 2) ? (2*(stage_10_num_in/3) + (stage_10_num_in%3)) : stage_10_num_in;
localparam stage_12_num_in = (stage_11_num_in > 2) ? (2*(stage_11_num_in/3) + (stage_11_num_in%3)) : stage_11_num_in;

// Determine the index of the stage that holds the final two outputs.
localparam FINAL_RESULT_STAGE_IDX = (stage_0_num_in <= 2) ? 0 :
                                     (stage_1_num_in <= 2) ? 1 :
                                     (stage_2_num_in <= 2) ? 2 :
                                     (stage_3_num_in <= 2) ? 3 :
                                     (stage_4_num_in <= 2) ? 4 :
                                     (stage_5_num_in <= 2) ? 5 :
                                     (stage_6_num_in <= 2) ? 6 :
                                     (stage_7_num_in <= 2) ? 7 :
                                     (stage_8_num_in <= 2) ? 8 :
                                     (stage_9_num_in <= 2) ? 9 :
                                     (stage_10_num_in <= 2) ? 10 :
                                     (stage_11_num_in <= 2) ? 11 :
                                     MAX_GEN_STAGES; // Fallback to last stage if num_inputs is very large

genvar stage_idx, elem_idx;

generate
    // --- Stage 0: Initialize stage_output_arrays[0] with the actual inputs ---
    // Each element of stage_output_arrays[0] is assigned exactly once from INPUT.
    for (elem_idx = 0; elem_idx < num_inputs; elem_idx = elem_idx + 1) begin : init_first_stage
        assign stage_output_arrays[0][elem_idx] = INPUT[elem_idx*input_width +: input_width];
    end
    // Fill unused elements in the first stage's output with 0 to avoid 'x' propagation (NoAssignX-ML).
    for (elem_idx = num_inputs; elem_idx < MAX_NUM_ELEMENTS; elem_idx = elem_idx + 1) begin : fill_unused_first_stage
        assign stage_output_arrays[0][elem_idx] = {input_width{'b0}};
    end

    // --- Iterative Reduction Stages (unrolled using generate) ---
    // Each iteration 'stage_idx' represents one combinational reduction stage.
    for (stage_idx = 0; stage_idx < MAX_GEN_STAGES; stage_idx = stage_idx + 1) begin : reduction_stage
        // Determine the number of active inputs for the current stage.
        // This selection logic resolves W415a by ensuring each wire element is assigned once.
        localparam CURRENT_STAGE_IN_COUNT = (stage_idx == 0) ? stage_0_num_in :
                                            (stage_idx == 1) ? stage_1_num_in :
                                            (stage_idx == 2) ? stage_2_num_in :
                                            (stage_idx == 3) ? stage_3_num_in :
                                            (stage_idx == 4) ? stage_4_num_in :
                                            (stage_idx == 5) ? stage_5_num_in :
                                            (stage_idx == 6) ? stage_6_num_in :
                                            (stage_idx == 7) ? stage_7_num_in :
                                            (stage_idx == 8) ? stage_8_num_in :
                                            (stage_idx == 9) ? stage_9_num_in :
                                            (stage_idx == 10) ? stage_10_num_in :
                                            (stage_idx == 11) ? stage_11_num_in :
                                            stage_12_num_in; // Should not be reached for stage_idx < MAX_GEN_STAGES

        // Calculate the number of active elements that will be output by this stage.
        localparam NEXT_STAGE_IN_COUNT = (CURRENT_STAGE_IN_COUNT > 2) ? (2*(CURRENT_STAGE_IN_COUNT/3) + (CURRENT_STAGE_IN_COUNT%3)) : CURRENT_STAGE_IN_COUNT;

        // The logic for this stage: reads from `stage_output_arrays[stage_idx]` and writes to `stage_output_arrays[stage_idx+1]`.
        if (CURRENT_STAGE_IN_COUNT > 2) begin : active_reduction_logic
            // Process groups of three inputs into two outputs (partial sum and shifted carry).
            for (elem_idx = 0; elem_idx < (CURRENT_STAGE_IN_COUNT/3); elem_idx = elem_idx + 1) begin : group_calc
                wire [input_width-1 : 0] term0 = stage_output_arrays[stage_idx][elem_idx*3];
                wire [input_width-1 : 0] term1 = stage_output_arrays[stage_idx][elem_idx*3+1];
                wire [input_width-1 : 0] term2 = stage_output_arrays[stage_idx][elem_idx*3+2];

                wire [input_width-1 : 0] ps_val = term0 ^ term1 ^ term2;
                wire [input_width-1 : 0] sc_val = ((term0 & term1) | (term1 & term2) | (term0 & term2)) << 1;

                assign stage_output_arrays[stage_idx+1][elem_idx*2] = ps_val;
                assign stage_output_arrays[stage_idx+1][elem_idx*2+1] = sc_val;
            end

            // Pass through any remaining inputs that didn't form a group of three.
            if ((CURRENT_STAGE_IN_COUNT % 3) > 0) begin : pass_remaining
                for (elem_idx = 0 ; elem_idx < (CURRENT_STAGE_IN_COUNT % 3) ; elem_idx = elem_idx + 1) begin
                    assign stage_output_arrays[stage_idx+1][2 * (CURRENT_STAGE_IN_COUNT/3) + elem_idx] = stage_output_arrays[stage_idx][3 * (CURRENT_STAGE_IN_COUNT/3) + elem_idx];
                end
            end
            // Fill unused elements for this stage's output with 0 to prevent 'x' (NoAssignX-ML).
            for (elem_idx = NEXT_STAGE_IN_COUNT; elem_idx < MAX_NUM_ELEMENTS; elem_idx = elem_idx + 1) begin : fill_unused_output
                assign stage_output_arrays[stage_idx+1][elem_idx] = {input_width{'b0}};
            end
        end else begin : bypass_or_finished_logic
            // If the current stage has 2 or fewer inputs, it means the reduction is complete or not needed.
            // Just pass the current stage's inputs directly to the next stage's outputs.
            for (elem_idx = 0; elem_idx < CURRENT_STAGE_IN_COUNT; elem_idx = elem_idx + 1) begin : bypass_elements
                assign stage_output_arrays[stage_idx+1][elem_idx] = stage_output_arrays[stage_idx][elem_idx];
            end
            // Fill unused elements with 0 (NoAssignX-ML).
            for (elem_idx = CURRENT_STAGE_IN_COUNT; elem_idx < MAX_NUM_ELEMENTS; elem_idx = elem_idx + 1) begin : fill_unused_bypass
                assign stage_output_arrays[stage_idx+1][elem_idx] = {input_width{'b0}};
            end
        end
    end // end reduction_stage loop
endgenerate

// Assign the final outputs from the buffer that holds the result of the last active stage.
assign OUT0 = stage_output_arrays[FINAL_RESULT_STAGE_IDX][0];
assign OUT1 = stage_output_arrays[FINAL_RESULT_STAGE_IDX][1];

endmodule
