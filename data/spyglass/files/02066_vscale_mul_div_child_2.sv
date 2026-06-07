// Define common parameters/macros
// Assuming XPR_LEN is typically 32 or 64 in similar designs

module vscale_mul_div(
                      // Parameters for operand length and derived lengths
                      parameter XPR_LEN = 32,
                      parameter DOUBLE_XPR_LEN = (XPR_LEN * 2),
                      // LOG2_XPR_LEN is for the counter, which goes from XPR_LEN-1 down to 0
                      // So it needs ceil(log2(XPR_LEN)) bits. For XPR_LEN=32, log2(32)=5.
                      parameter LOG2_XPR_LEN = 5,

                      input                         clk,
                      input                         reset,
                      input                         req_valid,
                      output                        req_ready,
                      input                         req_in_1_signed,
                      input                         req_in_2_signed,
                      input [MD_OP_WIDTH-1:0]       req_op,
                      input [MD_OUT_SEL_WIDTH-1:0]  req_out_sel,
                      input [XPR_LEN-1:0]           req_in_1,
                      input [XPR_LEN-1:0]           req_in_2,
                      output                        resp_valid,
                      output [XPR_LEN-1:0]          resp_result
                      );

   localparam md_state_width = 2;
   localparam s_idle = 0;
   localparam s_compute = 1;
   localparam s_setup_output = 2;
   localparam s_done = 3;

   // Define operation codes
   // There are at least MUL and (DIV/REM). For sign logic, REM is distinct.
   // So, 3 types of operations: MUL, DIV (implicit for output sign), REM. This requires 2 bits.
   localparam MD_OP_WIDTH = 2;
   localparam MD_OP_MUL = 2'b00; // Multiplication operation
   localparam MD_OP_REM = 2'b01; // Remainder operation (output sign matches sign_in_1)
   // Any other value for `op` (e.g., 2'b10 or 2'b11) would imply Division
   // where output sign is sign_in_1 ^ sign_in_2, falling into the 'else' branch
   // for negate_output.

   // Define output selection codes
   // Options are Remainder (a), High part of result, Low part of result (default)
   // Requires 2 bits to distinguish 3 modes
   localparam MD_OUT_SEL_WIDTH = 2;
   localparam MD_OUT_REM = 2'b00; // Output the current remainder ('a')
   localparam MD_OUT_HI = 2'b01; // Output the high part of the 'result'
   // Any other value for `out_sel` (e.g., 2'b10 or 2'b11) implicitly selects the low part of 'result'.

   reg [md_state_width-1:0]                         state;
   reg [md_state_width-1:0]                         next_state;
   reg [MD_OP_WIDTH-1:0]                            op;
   reg [MD_OUT_SEL_WIDTH-1:0]                       out_sel;
   reg                                              negate_output;
   reg [DOUBLE_XPR_LEN-1:0]                         a;
   reg [DOUBLE_XPR_LEN-1:0]                         b;
   reg [LOG2_XPR_LEN-1:0]                           counter;
   reg [DOUBLE_XPR_LEN-1:0]                         result;

   wire [XPR_LEN-1:0]                               abs_in_1;
   wire                                             sign_in_1;
   wire [XPR_LEN-1:0]                               abs_in_2;
   wire                                             sign_in_2;

   wire                                             a_geq;
   wire [DOUBLE_XPR_LEN-1:0]                        result_muxed;
   wire [DOUBLE_XPR_LEN-1:0]                        result_muxed_negated;
   wire [XPR_LEN-1:0]                               final_result;

   function [XPR_LEN-1:0] abs_input;
      input [XPR_LEN-1:0]                           data;
      input                                         is_signed;
      begin
         abs_input = (data[XPR_LEN-1] == 1'b1 && is_signed) ? -data : data;
      end
   endfunction // if

   assign req_ready = (state == s_idle);
   assign resp_valid = (state == s_done);
   assign resp_result = result[XPR_LEN-1:0];

   assign abs_in_1 = abs_input(req_in_1,req_in_1_signed);
   assign sign_in_1 = req_in_1_signed && req_in_1[XPR_LEN-1];
   assign abs_in_2 = abs_input(req_in_2,req_in_2_signed);
   assign sign_in_2 = req_in_2_signed && req_in_2[XPR_LEN-1];

   assign a_geq = a >= b;
   assign result_muxed = (out_sel == MD_OUT_REM) ? a : result;
   assign result_muxed_negated = (negate_output) ? -result_muxed : result_muxed;
   assign final_result = (out_sel == MD_OUT_HI) ? result_muxed_negated[XPR_LEN+:XPR_LEN] : result_muxed_negated[0+:XPR_LEN];

   always @(posedge clk) begin
      if (reset) begin
         state <= s_idle;
      end else begin
         state <= next_state;
      end
   end

   always @(*) begin
      case (state)
        s_idle : next_state = (req_valid) ? s_compute : s_idle;
        s_compute : next_state = (counter == 0) ? s_setup_output : s_compute;
        s_setup_output : next_state = s_done;
        s_done : next_state = s_idle;
        default : next_state = s_idle;
      endcase // case (state)
   end

   always @(posedge clk) begin
      case (state)
        s_idle : begin
           if (req_valid) begin
              result <= {DOUBLE_XPR_LEN{1'b0}};
              a <= {XPR_LEN'b0,abs_in_1};
              b <= {abs_in_2,XPR_LEN'b0} >> 1;
              // Determine output negation based on operation and input signs
              negate_output <= (op == MD_OP_REM) ? sign_in_1 : sign_in_1 ^ sign_in_2;
              out_sel <= req_out_sel;
              op <= req_op;
              counter <= XPR_LEN - 1;
           end
        end
        s_compute : begin
           counter <= counter - 1;
           b <= b >> 1; // This shift happens every cycle
           if (op == MD_OP_MUL) begin
              if (a[counter]) begin
                 result <= result + b;
              end
           end else begin
              b <= b >> 1; // This second shift means b gets shifted twice per cycle for non-multiplication ops
              if (a_geq) begin
                 a <= a - b;
                 result <= (DOUBLE_XPR_LEN'b1 << counter) | result;
              end
           end
        end // case: s_compute
        s_setup_output : begin
           result <= {XPR_LEN'b0,final_result};
        end
      endcase // case (state)
   end // always @ (posedge clk)

endmodule
