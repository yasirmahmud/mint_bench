`timescale 1ns / 1ps

module pcie_7x_0_gt_rx_valid_filter_7x #(

  parameter           CLK_COR_MIN_LAT    = 28,
  parameter           TCQ                = 1

)
(
  output  [1:0]       USER_RXCHARISK,
  output  [15:0]      USER_RXDATA,
  output              USER_RXVALID,
  output              USER_RXELECIDLE,
  output  [ 2:0]      USER_RX_STATUS,
  output              USER_RX_PHY_STATUS,
  input  [1:0]        GT_RXCHARISK,
  input  [15:0]       GT_RXDATA,
  input               GT_RXVALID,
  input               GT_RXELECIDLE,
  input  [ 2:0]       GT_RX_STATUS,
  input               GT_RX_PHY_STATUS,

  input               PLM_IN_L0,
  // Removed PLM_IN_RS: declared but not read (W240)

  input               USER_CLK,
  input               RESET

);



  localparam EIOS_DET_IDL      = 5'b00001;
  localparam EIOS_DET_NO_STR0  = 5'b00010;
  localparam EIOS_DET_STR0     = 5'b00100;
  localparam EIOS_DET_STR1     = 5'b01000;
  localparam EIOS_DET_DONE     = 5'b10000;

  localparam EIOS_COM          = 8'hBC;
  localparam EIOS_IDL          = 8'h7C;
  localparam FTSOS_COM         = 8'hBC; // FTSOS_COM is not used, but not a violation to keep.
  localparam FTSOS_FTS         = 8'h3C;

  reg    [4:0]        reg_state_eios_det;
  wire   [4:0]        state_eios_det = reg_state_eios_det; // Assigned for external use if needed, but not used internally for 'case'

  // Removed reg_eios_detected and wire eios_detected: set but not read (W528)

  reg                 reg_symbol_after_eios;
  wire                symbol_after_eios = reg_symbol_after_eios;

  // Registered GT inputs
  reg    [1:0]        gt_rxcharisk_q;
  reg    [15:0]       gt_rxdata_q;
  reg                 gt_rxvalid_q;
  reg                 gt_rxelecidle_q;

  reg    [ 2:0]       gt_rx_status_q;
  reg                 gt_rx_phy_status_q;
  // Removed gt_rx_is_skp0_q and gt_rx_is_skp1_q: set but not read (W528)

  // -- Combinational logic for next state values --
  // These registers hold the calculated next values for the current clock cycle,
  // which are then assigned to the actual registers at the positive edge of the clock.
  reg    [4:0]        next_reg_state_eios_det;
  reg                 next_reg_symbol_after_eios;
  reg                 next_gt_rxvalid_q;
  reg    [2:0]        next_gt_rx_status_q;

  always @(*) begin
    // Default assignments for next cycle's values. These can be overridden by specific logic below.
    next_reg_state_eios_det = reg_state_eios_det; // State holds by default
    next_reg_symbol_after_eios = 1'b0; // Original code clears this every cycle by default unless set in a specific state
    next_gt_rxvalid_q = GT_RXVALID; // Default to input GT_RXVALID, then apply deassertion logic

    // EIOS state machine logic to determine next state and potential overrides for next_gt_rxvalid_q
    case (reg_state_eios_det) // Use current state to determine next state and outputs
      EIOS_DET_IDL : begin
        if ((gt_rxcharisk_q[0]) && (gt_rxdata_q[7:0] == EIOS_COM) &&
            (gt_rxcharisk_q[1]) && (gt_rxdata_q[15:8] == EIOS_IDL)) begin
          next_reg_state_eios_det = EIOS_DET_NO_STR0;
        end else if ((gt_rxcharisk_q[1]) && (gt_rxdata_q[15:8] == EIOS_COM)) begin
          next_reg_state_eios_det = EIOS_DET_STR0;
        end else begin
          next_reg_state_eios_det = EIOS_DET_IDL;
        end
        // In EIOS_DET_IDL, gt_rxvalid_q is not explicitly deasserted by the state machine.
        // It follows the general deassertion rules or defaults to GT_RXVALID.
      end

      EIOS_DET_NO_STR0 : begin
        if ((gt_rxcharisk_q[0] && (gt_rxdata_q[7:0] == EIOS_IDL)) &&
            (gt_rxcharisk_q[1] && (gt_rxdata_q[15:8] == EIOS_IDL))) begin
          next_reg_state_eios_det = EIOS_DET_DONE;
          next_gt_rxvalid_q = 1'b0; // EIOS sequence detected, deassert RXVALID
        end else if (gt_rxcharisk_q[0] && (gt_rxdata_q[7:0] == EIOS_IDL)) begin
          next_reg_state_eios_det = EIOS_DET_DONE;
          next_gt_rxvalid_q = 1'b0; // EIOS sequence detected, deassert RXVALID
        end else begin
          next_reg_state_eios_det = EIOS_DET_IDL;
        end
      end

      EIOS_DET_STR0 : begin
        if ((gt_rxcharisk_q[0] && (gt_rxdata_q[7:0] == EIOS_IDL)) &&
            (gt_rxcharisk_q[1] && (gt_rxdata_q[15:8] == EIOS_IDL))) begin
          next_reg_state_eios_det = EIOS_DET_STR1;
          next_gt_rxvalid_q = 1'b0; // EIOS sequence detected, deassert RXVALID
          next_reg_symbol_after_eios = 1'b1;
        end else begin
          next_reg_state_eios_det = EIOS_DET_IDL;
        end
      end

      EIOS_DET_STR1 : begin
        if ((gt_rxcharisk_q[0]) && (gt_rxdata_q[7:0] == EIOS_IDL)) begin
          next_reg_state_eios_det = EIOS_DET_DONE;
          next_gt_rxvalid_q = 1'b0; // EIOS sequence detected, deassert RXVALID
        end else begin
          next_reg_state_eios_det = EIOS_DET_IDL;
        end
      end

      EIOS_DET_DONE : begin
        next_reg_state_eios_det = EIOS_DET_IDL;
        // In EIOS_DET_DONE, gt_rxvalid_q is not explicitly deasserted by the state machine directly.
        // It relies on the general deassertion rules for `(reg_state_eios_det == EIOS_DET_DONE) && (PLM_IN_L0)`.
      end
    endcase

    // Apply general deassertion conditions for next_gt_rxvalid_q
    // The specific deassertions within the 'case' block for EIOS sequences take precedence.
    // If next_gt_rxvalid_q has already been set to '0' by the case statement, it remains '0'.
    // Otherwise, apply the general conditions as per the original design's priority.
    if (next_gt_rxvalid_q == 1'b1) begin // Only apply if not already deasserted by EIOS sequence
      // De-assert rx_valid signal when EIOS detection is done and in L0 state
      if((next_reg_state_eios_det == EIOS_DET_DONE) && (PLM_IN_L0)) begin
        next_gt_rxvalid_q = 1'b0;
      end
      // De-assert rx_valid signal if GT_RXELECIDLE and current gt_rxvalid_q is already low
      else if (GT_RXELECIDLE && !gt_rxvalid_q) begin
        next_gt_rxvalid_q = 1'b0;
      end
      // Else, it remains GT_RXVALID from the default assignment.
    end

    // Calculate next_gt_rx_status_q, consolidating original logic.
    // Original logic: `if (gt_rxvalid_q) GT_RX_STATUS else if (!gt_rxvalid_q && PLM_IN_L0) 3'b0 else GT_RX_STATUS`
    // This simplifies to: if (!gt_rxvalid_q_computed_next && PLM_IN_L0) then 3'b0, else GT_RX_STATUS.
    if (!next_gt_rxvalid_q && PLM_IN_L0) begin
      next_gt_rx_status_q = 3'b0;
    end else begin
      next_gt_rx_status_q = GT_RX_STATUS;
    end
  end

  // -- Sequential logic block --
  always @(posedge USER_CLK) begin
    if (RESET) begin
      // All resets
      reg_state_eios_det    <= #TCQ EIOS_DET_IDL;
      reg_symbol_after_eios <= #TCQ 1'b0;

      gt_rxcharisk_q        <= #TCQ 2'b00;
      gt_rxdata_q           <= #TCQ 16'h0;
      gt_rxvalid_q          <= #TCQ 1'b0;
      gt_rxelecidle_q       <= #TCQ 1'b0;
      gt_rx_status_q        <= #TCQ 3'b000;
      gt_rx_phy_status_q    <= #TCQ 1'b0;
    end else begin
      // Register updates based on combinatorial logic or direct input piping
      reg_state_eios_det    <= #TCQ next_reg_state_eios_det;
      reg_symbol_after_eios <= #TCQ next_reg_symbol_after_eios;

      // Pipelined GT inputs
      gt_rxcharisk_q        <= #TCQ GT_RXCHARISK;
      gt_rxdata_q           <= #TCQ GT_RXDATA;
      gt_rxelecidle_q       <= #TCQ GT_RXELECIDLE;
      gt_rx_phy_status_q    <= #TCQ GT_RX_PHY_STATUS;

      // Filtered RXVALID and RX_STATUS
      gt_rxvalid_q          <= #TCQ next_gt_rxvalid_q; // Resolved STARC05-2.2.3.3 violations
      gt_rx_status_q        <= #TCQ next_gt_rx_status_q; // Consolidated logic

      // Removed gt_rx_is_skp0_q and gt_rx_is_skp1_q assignments: variables were unused (W528)
    end
  end

  // Removed rst_l: set but not read (W528)

assign USER_RXVALID = gt_rxvalid_q;
assign USER_RXCHARISK[0] = gt_rxvalid_q ? gt_rxcharisk_q[0] : 1'b0;
assign USER_RXCHARISK[1] = (gt_rxvalid_q && !symbol_after_eios) ? gt_rxcharisk_q[1] : 1'b0;
assign USER_RXDATA[7:0] = gt_rxdata_q[7:0];
assign USER_RXDATA[15:8] = gt_rxdata_q[15:8];
assign USER_RX_STATUS = gt_rx_status_q;
assign USER_RX_PHY_STATUS = gt_rx_phy_status_q;
assign USER_RXELECIDLE = gt_rxelecidle_q;


endmodule
