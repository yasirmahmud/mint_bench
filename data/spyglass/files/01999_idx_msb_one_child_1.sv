module inner_idx_msb_one#(
    parameter E_SZ_IN = 2,      // Total bit width of each element in data_i (index_width + 1)
    parameter NUM_E_IN = 32,    // Number of elements in data_i
    parameter E_SZ_OUT = 3,     // Total bit width of each element in intermediate output (index_width + 1)
    parameter NUM_E_OUT = 16,   // Number of elements in intermediate output
    parameter FIN_CNT_SZ = 7    // Final index output size (index_width + 1)
)(
    input  [(E_SZ_IN * NUM_E_IN) - 1 : 0] data_i,
    output [FIN_CNT_SZ - 1 : 0]          idx_o
);

    localparam W_IN = E_SZ_IN - 1;   // Index width for input elements
    localparam W_OUT = E_SZ_OUT - 1; // Index width for output elements of this stage

    // Base case: If only one element in input, this is the final result.
    // The `data_i` itself is already in the `FIN_CNT_SZ` format (index + valid bit).
    if (NUM_E_IN == 1) begin : gen_base_case
        assign idx_o = data_i;
    end else begin : gen_recursive_case
        // Recursive stage: Combine pairs of input elements into new output elements
        wire [(E_SZ_OUT * NUM_E_OUT) - 1 : 0] next_level_data_i;

        genvar i;
        generate
            for (i = 0; i < NUM_E_OUT; i = i + 1) begin : loop_combine_elements
                // Each output element combines two input elements
                // `element_upper` covers the higher group of elements (higher original indices)
                // `element_lower` covers the lower group of elements (lower original indices)
                wire [E_SZ_IN - 1 : 0] element_upper;
                wire [E_SZ_IN - 1 : 0] element_lower;

                assign element_upper = data_i[((2*i+1)*E_SZ_IN) + E_SZ_IN - 1 : (2*i+1)*E_SZ_IN];
                assign element_lower = data_i[((2*i)*E_SZ_IN) + E_SZ_IN - 1 : (2*i)*E_SZ_IN];

                // Extract valid bit (LSB) and index (MSB part) from current level elements
                wire valid_upper = element_upper[0];
                wire valid_lower = element_lower[0];

                // Index part is from bit 1 to E_SZ_IN-1, having a width of W_IN bits
                wire [W_IN-1 : 0] idx_upper = element_upper[E_SZ_IN - 1 : 1];
                wire [W_IN-1 : 0] idx_lower = element_lower[E_SZ_IN - 1 : 1];

                wire [E_SZ_OUT - 1 : 0] combined_element;

                // Calculate the valid bit for the combined element
                wire new_valid = valid_upper | valid_lower;

                // Calculate the index for the combined element
                // The offset is the span of the lower element in terms of original bit positions.
                // This is `2**W_IN` (number of original bits represented by one `W_IN`-bit index).
                wire [W_OUT-1 : 0] offset_val = 1 << W_IN;

                // Zero-extend idx_upper and idx_lower to W_OUT bits for addition
                wire [W_OUT-1 : 0] idx_upper_ext = {{W_OUT-W_IN{1'b0}}, idx_upper};
                wire [W_OUT-1 : 0] idx_lower_ext = {{W_OUT-W_IN{1'b0}}, idx_lower};

                wire [W_OUT-1 : 0] combined_idx;
                assign combined_idx = valid_upper ? (offset_val + idx_upper_ext) : idx_lower_ext;

                // The output element format is {index[W_OUT-1:0], valid_bit[0]}
                assign combined_element = {combined_idx, new_valid};
                assign next_level_data_i[(i*E_SZ_OUT) + E_SZ_OUT - 1 : (i*E_SZ_OUT)] = combined_element;
            end
        endgenerate

        // Recursive call with updated parameters
        inner_idx_msb_one#(
            .E_SZ_IN(E_SZ_OUT),             // Input elements for next stage are outputs of current stage
            .NUM_E_IN(NUM_E_OUT),           // Number of input elements for next stage
            .E_SZ_OUT(E_SZ_OUT + 1),        // Index width increases by 1 for next stage, so E_SZ_OUT increases by 1
            .NUM_E_OUT(NUM_E_OUT / 2),      // Number of output elements halves
            .FIN_CNT_SZ(FIN_CNT_SZ)         // Final count size remains constant
        ) next_level_inst (
            .data_i(next_level_data_i),
            .idx_o(idx_o)
        );
    end

endmodule
