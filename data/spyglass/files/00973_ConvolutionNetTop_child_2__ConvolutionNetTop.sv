module ConvolutionNetTop (
    input clk,
    input rst,
    input [7:0] d_in,
    input conv_start,
    // Added outputs to resolve W528 (set but not read) warnings
    output wire layer_1_conv_write_complete,      // Output for m_conv_1's completion
    output wire layer_1_mem_write_complete,       // Output for m_layer_input_1's completion
    output wire [7:0] layer_2_final_data_out,     // Output for final processed data
    output wire layer_2_final_data_available,   // Output for final data availability
    output wire layer_2_overall_ready           // Output for overall layer 2 readiness
);
    wire layer_0_ready;
    wire layer_1_ready;
    wire [7:0] layer_1_conv_tmp;
    wire layer_2_read_en;
    wire [7:0] layer_1_conv;
    // Original 'layer_1_write_complete' wire removed due to multiple drivers.
    // New wires to disambiguate the 'layer_1_write_complete' outputs from different modules.
    wire layer_1_write_complete_from_conv_inst;
    wire layer_1_write_complete_from_mem_inst;
    wire layer_2_relu_begin;
    wire [9:0] conv_ram_write_addr;
    wire [9:0] conv_ram_read_addr;
    wire [7:0] layer_2_max_tmp;
    wire layer_2_data_available;
    wire layer_2_ready;

    // Fix UndrivenInTerm-ML (layer_2_read_en): drive it based on layer_2_relu_begin
    assign layer_2_read_en = layer_2_relu_begin;

    // Fix W528 (set but not read): connect internal signals to external outputs
    assign layer_1_conv_write_complete = layer_1_write_complete_from_conv_inst;
    assign layer_1_mem_write_complete = layer_1_write_complete_from_mem_inst;
    assign layer_2_final_data_out = layer_2_max_tmp;
    assign layer_2_final_data_available = layer_2_data_available;
    assign layer_2_overall_ready = layer_2_ready;

    m_layer_input_0 m_layer_input_0(
        .clk(clk),
        .rst(rst),
        .d_in(d_in),
        .start(conv_start),
        .layer_0_ready(layer_0_ready)
    );

    m_conv_1 m_conv_1(
        .clk(clk),
        .rst(rst),
        .d_in(d_in),
        .start(conv_start),
        .layer_0_ready(layer_0_ready),
        .layer_1_write_complete(layer_1_write_complete_from_conv_inst), // Connect to new wire
        .ram_write_addr(conv_ram_write_addr),
        .d_out(layer_1_conv_tmp),
        .layer_1_ready(layer_1_ready)
    );

    m_layer_input_1 m_layer_input_1(
        .clk(clk),
        .rst(rst),
        .d_in(layer_1_conv_tmp),
        .wr_en(layer_1_ready),
        .rd_en(layer_2_read_en),
        .wr_addr(conv_ram_write_addr),
        .rd_addr(conv_ram_read_addr),
        .d_out(layer_1_conv),
        .layer_1_write_complete(layer_1_write_complete_from_mem_inst), // Connect to new wire
        .layer_2_relu_begin(layer_2_relu_begin)
    );

    m_max_relu_2 m_max_relu_2(
        .clk(clk),
        .rst(rst),
        .layer_2_relu_begin(layer_2_relu_begin),
        .d_in(layer_1_conv),
        .rd_en(layer_2_read_en),
        .ram_read_addr(conv_ram_read_addr),
        .d_out(layer_2_max_tmp),
        .data_available(layer_2_data_available),
        .layer_2_ready(layer_2_ready)
    );

endmodule
