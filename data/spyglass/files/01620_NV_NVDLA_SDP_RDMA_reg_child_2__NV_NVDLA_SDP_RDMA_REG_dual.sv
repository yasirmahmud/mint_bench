`endif // SYNTHESIS

`ifndef SYNTHESIS
// Dummy definition for NV_NVDLA_SDP_RDMA_REG_dual
module NV_NVDLA_SDP_RDMA_REG_dual (
   reg_rd_data
  ,reg_offset
  ,reg_wr_data
  ,reg_wr_en
  ,nvdla_core_clk
  ,nvdla_core_rstn
  ,bn_base_addr_high
  ,bn_base_addr_low
  ,bn_batch_stride
  ,bn_line_stride
  ,bn_surface_stride
  ,brdma_data_mode
  ,brdma_data_size
  ,brdma_data_use
  ,brdma_disable
  ,brdma_ram_type
  ,bs_base_addr_high
  ,bs_base_addr_low
  ,bs_batch_stride
  ,bs_line_stride
  ,bs_surface_stride
  ,channel
  ,height
  ,width
  ,erdma_data_mode
  ,erdma_data_size
  ,erdma_data_use
  ,erdma_disable
  ,erdma_ram_type
  ,ew_base_addr_high
  ,ew_base_addr_low
  ,ew_batch_stride
  ,ew_line_stride
  ,ew_surface_stride
  ,batch_number
  ,flying_mode
  ,in_precision
  ,out_precision
  ,proc_precision
  ,winograd
  ,nrdma_data_mode
  ,nrdma_data_size
  ,nrdma_data_use
  ,nrdma_disable
  ,nrdma_ram_type
  ,op_en_trigger
  ,perf_dma_en
  ,perf_nan_inf_count_en
  ,src_base_addr_high
  ,src_base_addr_low
  ,src_ram_type
  ,src_line_stride
  ,src_surface_stride
  ,op_en
  ,brdma_stall
  ,erdma_stall
  ,mrdma_stall
  ,nrdma_stall
  ,status_inf_input_num
  ,status_nan_input_num
  );

input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [11:0] reg_offset;
input  [31:0] reg_wr_data;
input         reg_wr_en;
input         op_en;
input  [31:0] brdma_stall;
input  [31:0] erdma_stall;
input  [31:0] mrdma_stall;
input  [31:0] nrdma_stall;
input  [31:0] status_inf_input_num;
input  [31:0] status_nan_input_num;

output [31:0] reg_rd_data;
output [31:0] bn_base_addr_high;
output [26:0] bn_base_addr_low;
output [26:0] bn_batch_stride;
output [26:0] bn_line_stride;
output [26:0] bn_surface_stride;
output        brdma_data_mode;
output        brdma_data_size;
output  [1:0] brdma_data_use;
output        brdma_disable;
output        brdma_ram_type;
output [31:0] bs_base_addr_high;
output [26:0] bs_base_addr_low;
output [26:0] bs_batch_stride;
output [26:0] bs_line_stride;
output [26:0] bs_surface_stride;
output [12:0] channel;
output [12:0] height;
output [12:0] width;
output        erdma_data_mode;
output        erdma_data_size;
output  [1:0] erdma_data_use;
output        erdma_disable;
output        erdma_ram_type;
output [31:0] ew_base_addr_high;
output [26:0] ew_base_addr_low;
output [26:0] ew_batch_stride;
output [26:0] ew_line_stride;
output [26:0] ew_surface_stride;
output  [4:0] batch_number;
output        flying_mode;
output  [1:0] in_precision;
output  [1:0] out_precision;
output  [1:0] proc_precision;
output        winograd;
output        nrdma_data_mode;
output        nrdma_data_size;
output  [1:0] nrdma_data_use;
output        nrdma_disable;
output        nrdma_ram_type;
output        op_en_trigger;
output        perf_dma_en;
output        perf_nan_inf_count_en;
output [31:0] src_base_addr_high;
output [26:0] src_base_addr_low;
output        src_ram_type;
output [26:0] src_line_stride;
output [26:0] src_surface_stride;

// Internal registers to mimic storage
reg [31:0] r_reg_data;
reg        r_op_en_trigger;

reg [31:0] r_bn_base_addr_high;
reg [26:0] r_bn_base_addr_low;
reg [26:0] r_bn_batch_stride;
reg [26:0] r_bn_line_stride;
reg [26:0] r_bn_surface_stride;
reg        r_brdma_data_mode;
reg        r_brdma_data_size;
reg  [1:0] r_brdma_data_use;
reg        r_brdma_disable;
reg        r_brdma_ram_type;
reg [31:0] r_bs_base_addr_high;
reg [26:0] r_bs_base_addr_low;
reg [26:0] r_bs_batch_stride;
reg [26:0] r_bs_line_stride;
reg [26:0] r_bs_surface_stride;
reg [12:0] r_channel;
reg [12:0] r_height;
reg [12:0] r_width;
reg        r_erdma_data_mode;
reg        r_erdma_data_size;
reg  [1:0] r_erdma_data_use;
reg        r_erdma_disable;
reg        r_erdma_ram_type;
reg [31:0] r_ew_base_addr_high;
reg [26:0] r_ew_base_addr_low;
reg [26:0] r_ew_batch_stride;
reg [26:0] r_ew_line_stride;
reg [26:0] r_ew_surface_stride;
reg  [4:0] r_batch_number;
reg        r_flying_mode;
reg  [1:0] r_in_precision;
reg  [1:0] r_out_precision;
reg  [1:0] r_proc_precision;
reg        r_winograd;
reg        r_nrdma_data_mode;
reg        r_nrdma_data_size;
reg  [1:0] r_nrdma_data_use;
reg        r_nrdma_disable;
reg        r_nrdma_ram_type;
reg        r_perf_dma_en;
reg        r_perf_nan_inf_count_en;
reg [31:0] r_src_base_addr_high;
reg [26:0] r_src_base_addr_low;
reg        r_src_ram_type;
reg [26:0] r_src_line_stride;
reg [26:0] r_src_surface_stride;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        r_reg_data <= 32'b0;
        r_op_en_trigger <= 1'b0; // Default reset for op_en_trigger

        r_bn_base_addr_high <= 32'b0;
        r_bn_base_addr_low <= 27'b0;
        r_bn_batch_stride <= 27'b0;
        r_bn_line_stride <= 27'b0;
        r_bn_surface_stride <= 27'b0;
        r_brdma_data_mode <= 1'b0;
        r_brdma_data_size <= 1'b0;
        r_brdma_data_use <= 2'b0;
        r_brdma_disable <= 1'b0;
        r_brdma_ram_type <= 1'b0;
        r_bs_base_addr_high <= 32'b0;
        r_bs_base_addr_low <= 27'b0;
        r_bs_batch_stride <= 27'b0;
        r_bs_line_stride <= 27'b0;
        r_bs_surface_stride <= 27'b0;
        r_channel <= 13'b0;
        r_height <= 13'b0;
        r_width <= 13'b0;
        r_erdma_data_mode <= 1'b0;
        r_erdma_data_size <= 1'b0;
        r_erdma_data_use <= 2'b0;
        r_erdma_disable <= 1'b0;
        r_erdma_ram_type <= 1'b0;
        r_ew_base_addr_high <= 32'b0;
        r_ew_base_addr_low <= 27'b0;
        r_ew_batch_stride <= 27'b0;
        r_ew_line_stride <= 27'b0;
        r_ew_surface_stride <= 27'b0;
        r_batch_number <= 5'b0;
        r_flying_mode <= 1'b0;
        r_in_precision <= 2'b0;
        r_out_precision <= 2'b0;
        r_proc_precision <= 2'b0;
        r_winograd <= 1'b0;
        r_nrdma_data_mode <= 1'b0;
        r_nrdma_data_size <= 1'b0;
        r_nrdma_data_use <= 2'b0;
        r_nrdma_disable <= 1'b0;
        r_nrdma_ram_type <= 1'b0;
        r_perf_dma_en <= 1'b0;
        r_perf_nan_inf_count_en <= 1'b0;
        r_src_base_addr_high <= 32'b0;
        r_src_base_addr_low <= 27'b0;
        r_src_ram_type <= 1'b0;
        r_src_line_stride <= 27'b0;
        r_src_surface_stride <= 27'b0;
    end else begin
        if (reg_wr_en) begin
            r_reg_data <= reg_wr_data; // Store the last written data for general readback
            // Simplified update for op_en_trigger: always trigger when op_en is written to 1
            if (reg_offset == 12'h010) begin // Example: assuming OP_EN is at 0x010
                r_op_en_trigger <= reg_wr_data[0];
            end
            
            // In a real module, each reg_offset would map to specific registers
            case (reg_offset)
                12'h000: r_bn_base_addr_high <= reg_wr_data;
                12'h004: r_bn_base_addr_low  <= reg_wr_data[26:0];
                12'h008: r_bn_batch_stride   <= reg_wr_data[26:0];
                12'h00C: r_bn_line_stride    <= reg_wr_data[26:0];
                12'h010: r_bn_surface_stride <= reg_wr_data[26:0]; // Example address
                12'h014: r_batch_number      <= reg_wr_data[4:0];
                12'h018: r_flying_mode       <= reg_wr_data[0];
                12'h01C: r_in_precision      <= reg_wr_data[1:0];
                12'h020: r_out_precision     <= reg_wr_data[1:0];
                12'h024: r_proc_precision    <= reg_wr_data[1:0];
                12'h028: r_winograd          <= reg_wr_data[0];
                default: ; // Retain values for other registers not explicitly mapped
            endcase
        end else begin
            r_op_en_trigger <= 1'b0; // Ensure trigger is not always high if not written
        end
    end
end

assign reg_rd_data = r_reg_data;
assign op_en_trigger = r_op_en_trigger; // Dummy op_en_trigger driven

assign bn_base_addr_high = r_bn_base_addr_high;
assign bn_base_addr_low = r_bn_base_addr_low;
assign bn_batch_stride = r_bn_batch_stride;
assign bn_line_stride = r_bn_line_stride;
assign bn_surface_stride = r_bn_surface_stride;
assign brdma_data_mode = r_brdma_data_mode;
assign brdma_data_size = r_brdma_data_size;
assign brdma_data_use = r_brdma_data_use;
assign brdma_disable = r_brdma_disable;
assign brdma_ram_type = r_brdma_ram_type;
assign bs_base_addr_high = r_bs_base_addr_high;
assign bs_base_addr_low = r_bs_base_addr_low;
assign bs_batch_stride = r_bs_batch_stride;
assign bs_line_stride = r_bs_line_stride;
assign bs_surface_stride = r_bs_surface_stride;
assign channel = r_channel;
assign height = r_height;
assign width = r_width;
assign erdma_data_mode = r_erdma_data_mode;
assign erdma_data_size = r_erdma_data_size;
assign erdma_data_use = r_erdma_data_use;
assign erdma_disable = r_erdma_disable;
assign erdma_ram_type = r_erdma_ram_type;
assign ew_base_addr_high = r_ew_base_addr_high;
assign ew_base_addr_low = r_ew_base_addr_low;
assign ew_batch_stride = r_ew_batch_stride;
assign ew_line_stride = r_ew_line_stride;
assign ew_surface_stride = r_ew_surface_stride;
assign batch_number = r_batch_number;
assign flying_mode = r_flying_mode;
assign in_precision = r_in_precision;
assign out_precision = r_out_precision;
assign proc_precision = r_proc_precision;
assign winograd = r_winograd;
assign nrdma_data_mode = r_nrdma_data_mode;
assign nrdma_data_size = r_nrdma_data_size;
assign nrdma_data_use = r_nrdma_data_use;
assign nrdma_disable = r_nrdma_disable;
assign nrdma_ram_type = r_nrdma_ram_type;
assign perf_dma_en = r_perf_dma_en;
assign perf_nan_inf_count_en = r_perf_nan_inf_count_en;
assign src_base_addr_high = r_src_base_addr_high;
assign src_base_addr_low = r_src_base_addr_low;
assign src_ram_type = r_src_ram_type;
assign src_line_stride = r_src_line_stride;
assign src_surface_stride = r_src_surface_stride;

endmodule
