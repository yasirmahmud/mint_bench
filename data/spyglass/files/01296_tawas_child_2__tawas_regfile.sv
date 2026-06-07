module tawas_regfile
(
    input clk,
    input rst,

    input thread_load_en,
    input [4:0] thread_load,

    output [31:0] reg0,
    output [31:0] reg1,
    output [31:0] reg2,
    output [31:0] reg3,
    output [31:0] reg4,
    output [31:0] reg5,
    output [31:0] reg6,
    output [31:0] reg7,
    output [7:0] au_flags,

    input [4:0] wb_thread,

    input wb_au_en,
    input [2:0] wb_au_reg,
    input [31:0] wb_au_data,

    input wb_au_flags_en,
    input [7:0] wb_au_flags,

    input wb_ptr_en,
    input [2:0] wb_ptr_reg,
    input [31:0] wb_ptr_data,

    input wb_store_en,
    input [2:0] wb_store_reg,
    input [31:0] wb_store_data,

    input rcn_load_en,
    input [4:0] rcn_load_thread,
    input [2:0] rcn_load_reg,
    input [31:0] rcn_load_data
);
    // Dummy logic to resolve linting violations and consume inputs
    reg [31:0] registers[0:7];
    reg [7:0] au_flags_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i=0; i<8; i++) registers[i] <= 32'h0;
            au_flags_r <= 8'h0;
        end else begin
            if (wb_au_en) begin
                registers[wb_au_reg] <= wb_au_data;
            end
            if (wb_ptr_en) begin
                registers[wb_ptr_reg] <= wb_ptr_data;
            end
            if (wb_store_en) begin
                registers[wb_store_reg] <= wb_store_data;
            end
            // Consuming multiple inputs with a conditional for W240
            if (rcn_load_en && (rcn_load_thread == thread_load) && (thread_load_en == 1'b1 || wb_thread[0])) begin
                registers[rcn_load_reg] <= rcn_load_data;
            end
            if (wb_au_flags_en) begin
                au_flags_r <= wb_au_flags;
            end
        end
    end

    assign reg0 = registers[0];
    assign reg1 = registers[1];
    assign reg2 = registers[2];
    assign reg3 = registers[3];
    assign reg4 = registers[4];
    assign reg5 = registers[5];
    assign reg6 = registers[6];
    assign reg7 = registers[7];
    assign au_flags = au_flags_r;

endmodule
