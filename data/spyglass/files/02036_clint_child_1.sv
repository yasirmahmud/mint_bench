module clint (

    input wire clk,
    input wire rst,

    // from core
    input wire [7:0] int_flag_i,  // ÖÐ¶ÏÊäÈëÐÅºÅ

    // from id
    input wire [31:0] inst_i,      // Ö¸ÁîÄÚÈÝ
    input wire [31:0] inst_addr_i, // Ö¸ÁîµØÖ·

    // from ex
    input wire jump_flag_i,
    input wire [31:0] jump_addr_i,
    input wire div_started_i,

    // from ctrl
    input wire [2:0] hold_flag_i,  // Á÷Ë®ÏßÔÝÍ£±êÖ¾

    // from csr_reg
    input wire [31:0] data_i,      // CSR¼Ä´æÆ÷ÊäÈëÊý¾Ý
    input wire [31:0] csr_mtvec,   // mtvec¼Ä´æÆ÷
    input wire [31:0] csr_mepc,    // mepc¼Ä´æÆ÷
    input wire [31:0] csr_mstatus, // mstatus¼Ä´æÆ÷

    input wire global_int_en_i,  // È«¾ÖÖÐ¶ÏÊ¹ÄÜ±êÖ¾

    // to ctrl
    output wire hold_flag_o,  // Á÷Ë®ÏßÔÝÍ£±êÖ¾

    // to csr_reg
    output reg        we_o,     // Ð´CSR¼Ä´æÆ÷±êÖ¾
    output reg [31:0] waddr_o,  // Ð´CSR¼Ä´æÆ÷µØÖ·
    output reg [31:0] raddr_o,  // ¶ÁCSR¼Ä´æÆ÷µØÖ·
    output reg [31:0] data_o,   // Ð´CSR¼Ä´æÆ÷Êý¾Ý

    // to ex
    output reg [31:0] int_addr_o,   // ÖÐ¶ÏÈë¿ÚµØÖ·
    output reg        int_assert_o  // ÖÐ¶Ï±êÖ¾

);

  // Fix for W240: Input 'hold_flag_i' declared but not read.
  wire [2:0] _unused_hold_flag_i = hold_flag_i;
  // Fix for W240: Input 'data_i' declared but not read.
  wire [31:0] _unused_data_i = data_i;

  reg [3:0] int_state;
  reg [4:0] csr_state;
  reg [4:0] csr_next_state; // Added for 2-block FSM style
  reg [31:0] inst_addr;
  reg [31:0] inst_addr_next; // Added for 2-block FSM style
  reg [31:0] cause;


  assign hold_flag_o = ((int_state != 4'b0001) | (csr_state != 5'b00001)) ? 1'b1 : 1'b0;


  // ÖÐ¶ÏÖÙ²ÃÂß¼­
  always @(*) begin
    if (rst == 1'b0) begin
      int_state = 4'b0001;
    end else begin
      if (inst_i == 32'h73 || inst_i == 32'h00100073) begin
        // Èç¹ûÖ´ÐÐ½×¶ÎÄÚÈÝÎª³ý·¨Ö¸Áî£¬ÔòÏÈ²»´¦ÀíÍ¬²½ÖÐ¶Ï£¬µÈ³ý·¨Ö¸ÁîÖ´ÐÐÍêÔÙ´¦Àí
        if (div_started_i == 1'b0) begin
          int_state = 4'b0010;
        end else begin
          int_state = 4'b0001;
        end
      end else if (int_flag_i != 8'h0 && global_int_en_i == 1'b1) begin
        int_state = 4'b0100;
      end else if (inst_i == 32'h30200073) begin
        int_state = 4'b1000;
      end else begin
        int_state = 4'b0001;
      end
    end
  end

  always @(posedge clk) begin
    if (rst == 1'b0) begin
      cause <= 32'h0;
    end else if(csr_state == 5'b00001 && int_state == 4'b0010)  begin
      case (inst_i)
        32'h73: begin
          cause <= 32'd11;
        end
        32'h00100073: begin
          cause <= 32'd3;
        end
        default: begin
          cause <= 32'd10;
        end
      endcase
    end else if (int_state == 4'b0100)
      cause <= 32'h80000004;
  end

  // Combinational next-state logic for csr_state and inst_addr
  // Fix for STARC05-2.11.3.1: Splitting FSM into combinational and sequential parts
  always @(*) begin
    csr_next_state = csr_state; // Default to hold current state
    inst_addr_next = inst_addr; // Default to hold current inst_addr

    case (csr_state)
      5'b00001: begin
        // Í¬²½ÖÐ¶Ï
        if (int_state == 4'b0010) begin
          csr_next_state = 5'b00100;
          // ÔÚÖÐ¶Ï´¦Àíº¯ÊýÀï»á½«ÖÐ¶Ï·µ»ØµØÖ·¼Ó4
          if (jump_flag_i == 1'b1) begin
            inst_addr_next = jump_addr_i - 32'd4;
          end else begin
            inst_addr_next = inst_addr_i;
          end
        // Òì²½ÖÐ¶Ï
        end else if (int_state == 4'b0100) begin
          // ¶¨Ê±Æ÷ÖÐ¶Ï
          csr_next_state = 5'b00100;
          if (jump_flag_i == 1'b1) begin
            inst_addr_next = jump_addr_i;
            // Òì²½ÖÐ¶Ï¿ÉÒÔÖÐ¶Ï³ý·¨Ö¸ÁîµÄÖ´ÐÐ£¬ÖÐ¶Ï´¦ÀíÍêÔÙÖØÐÂÖ´ÐÐ³ý·¨Ö¸Áî
          end else if (div_started_i == 1'b1) begin
            inst_addr_next = inst_addr_i - 32'd4;
          end else begin
            inst_addr_next = inst_addr_i;
          end
        // ÖÐ¶Ï·µ»Ø
        end else if (int_state == 4'b1000) begin
          csr_next_state = 5'b01000;
        end
      end
      5'b00100: begin
        csr_next_state = 5'b00010;
      end
      5'b00010: begin
        csr_next_state = 5'b10000;
      end
      5'b10000: begin
        csr_next_state = 5'b00001;
      end
      5'b01000: begin
        csr_next_state = 5'b00001;
      end
      default: csr_next_state = 5'b00001;
    endcase
  end

  // Sequential update for csr_state and inst_addr
  // Fix for STARC05-2.11.3.1: Splitting FSM into combinational and sequential parts
  always @(posedge clk) begin
    if (rst == 1'b0) begin
      csr_state <= 5'b00001;
      inst_addr <= 32'h0;
    end else begin
      csr_state <= csr_next_state;
      inst_addr <= inst_addr_next;
    end
  end

  // ·¢³öÖÐ¶ÏÐÅºÅÇ°£¬ÏÈÐ´¼¸¸öCSR¼Ä´æÆ÷
  always @(posedge clk) begin
    if (rst == 1'b0) begin
      we_o <= 1'b0;
      waddr_o <= 32'h0;
      data_o <= 32'h0;
    end else begin
      case (csr_state)
        // ½«mepc¼Ä´æÆ÷µÄÖµÉèÎªµ±Ç°Ö¸ÁîµØÖ·
        5'b00100: begin
          we_o <= 1'b1;
          waddr_o <= {20'h0, 12'h341};
          data_o <= inst_addr;
        end
        // Ð´ÖÐ¶Ï²úÉúµÄÔ­Òò
        5'b10000: begin
          we_o <= 1'b1;
          waddr_o <= {20'h0, 12'h342};
          data_o <= cause;
        end
        // ¹Ø±ÕÈ«¾ÖÖÐ¶Ï
        5'b00010: begin
          we_o <= 1'b1;
          waddr_o <= {20'h0, 12'h300};
          data_o <= {csr_mstatus[31:4], 1'b0, csr_mstatus[2:0]};
        end
        // ÖÐ¶Ï·µ»Ø
        5'b01000: begin
          we_o <= 1'b1;
          waddr_o <= {20'h0, 12'h300};
          data_o <= {csr_mstatus[31:4], csr_mstatus[7], csr_mstatus[2:0]};
        end
        default: begin
          we_o <= 1'b0;
          waddr_o <= 32'h0;
          data_o <= 32'h0;
        end
      endcase
    end
  end

  // ·¢³öÖÐ¶ÏÐÅºÅ¸øexÄ£¿é
  always @(posedge clk) begin
    if (rst == 1'b0) begin
      int_assert_o <= 1'b0;
      int_addr_o   <= 32'h0;
    end else begin
      case (csr_state)
        // ·¢³öÖÐ¶Ï½øÈëÐÅºÅ.Ð´Íêmcause¼Ä´æÆ÷²ÅÄÜ·¢
        5'b10000: begin
          int_assert_o <= 1'b1;
          int_addr_o   <= csr_mtvec;
        end
        // ·¢³öÖÐ¶Ï·µ»ØÐÅºÅ
        5'b01000: begin
          int_assert_o <= 1'b1;
          int_addr_o   <= csr_mepc;
        end
        default: begin
          int_assert_o <= 1'b0;
          int_addr_o   <= 32'h0;
        end
      endcase
    end
  end

endmodule
