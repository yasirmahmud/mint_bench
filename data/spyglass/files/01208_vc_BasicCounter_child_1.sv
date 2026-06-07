module vc_BasicCounter
#(
  parameter p_count_nbits       = 3,
  parameter p_count_clear_value = 0,
  parameter p_count_max_value   = 4
)(
  input  wire                      clk,
  input  wire                      reset,

  // Operations

  input  wire                      clear,
  input  wire                      increment,
  input  wire                      decrement,

  // Outputs

  output wire [p_count_nbits-1:0] count,
  output wire                     count_is_zero,
  output wire                     count_is_max

);

  //----------------------------------------------------------------------
  // State
  //----------------------------------------------------------------------

  wire [p_count_nbits-1:0] count_next;

  vc_ResetReg#( p_count_nbits, p_count_clear_value ) count_reg
  (
    .clk   (clk),
    .reset (reset),
    .d     (count_next),
    .q     (count)
  );

  //----------------------------------------------------------------------
  // Combinational Logic
  //----------------------------------------------------------------------

  wire do_increment;
  assign do_increment = ( increment && (count < p_count_max_value) );

  wire do_decrement;
  assign do_decrement = ( decrement && (count > 0) );

  assign count_next
    = clear        ? (p_count_clear_value)
    : do_increment ? (count + 1)
    : do_decrement ? (count - 1)
    : count;

  assign count_is_zero = (count == 0);
  assign count_is_max  = (count == p_count_max_value);

  //----------------------------------------------------------------------
  // Assertions
  //----------------------------------------------------------------------

  /*
  always_ff @( posedge clk ) begin
    if ( !reset ) begin
      `VC_ASSERT_NOT_X( increment );
      `VC_ASSERT_NOT_X( decrement );
    end
  end
  */

endmodule
