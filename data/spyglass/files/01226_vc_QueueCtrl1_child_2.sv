module vc_QueueCtrl1
#(
  parameter p_type = 3'b000 // Default value is now a localparam
)(
  input  wire clk,
  input  wire reset,

  input  wire enq_val,        // Enqueue data is valid
  output wire enq_rdy,        // Ready for producer to do an enqueue

  output wire deq_val,        // Dequeue data is valid
  input  wire deq_rdy,        // Consumer is ready to do a dequeue

  output wire write_en,       // Write en signal to wire up to storage element
  output wire bypass_mux_sel, // Used to control bypass mux for bypass queues
  output wire num_free_entries // Either zero or one
);

  // Status register

  reg  full;
  wire full_next;

  always_ff @(posedge clk) begin
    full <= reset ? 1'b0 : full_next;
  end

  assign num_free_entries = full ? 1'b0 : 1'b1;

  // Define queue type parameters as localparams to resolve STX_VE_533 violations.
  // These were likely intended as global macros or parameters to be included.
  // By defining them as localparams and removing the backticks, the module becomes self-contained.
  localparam VC_QUEUE_NORMAL = 3'b000;
  localparam VC_QUEUE_PIPE   = 3'b001;
  localparam VC_QUEUE_BYPASS = 3'b010;

  // Determine if pipeline or bypass behavior is enabled

  localparam c_pipe_en   = |( p_type & VC_QUEUE_PIPE   );
  localparam c_bypass_en = |( p_type & VC_QUEUE_BYPASS );

  // We enq/deq only when they are both ready and valid

  wire  do_enq;
  assign do_enq = enq_rdy && enq_val;

  wire  do_deq;
  assign do_deq = deq_rdy && deq_val;

  // Determine if we have pipeline or bypass behaviour and
  // set the write enable accordingly.

  wire  empty;
  assign empty = ~full;

  wire  do_pipe;
  assign do_pipe = c_pipe_en   && full  && do_enq && do_deq;

  wire  do_bypass;
  assign do_bypass = c_bypass_en && empty && do_enq && do_deq;

  assign write_en = do_enq && ~do_bypass;

  // Regardless of the type of queue or whether or not we are actually
  // doing a bypass, if the queue is empty then we select the enq bits,
  // otherwise we select the output of the queue state elements.

  assign bypass_mux_sel = empty;

  // Ready signals are calculated from full register. If pipeline
  // behavior is enabled, then the enq_rdy signal is also calculated
  // combinationally from the deq_rdy signal. If bypass behavior is
  // enabled then the deq_val signal is also calculated combinationally
  // from the enq_val signal.

  assign enq_rdy  = ~full  || ( c_pipe_en   && full  && deq_rdy );
  assign deq_val  = ~empty || ( c_bypass_en && empty && enq_val );

  // Control logic for the full register input

  assign full_next = ( do_deq && ~do_pipe )   ? 1'b0
                   : ( do_enq && ~do_bypass ) ? 1'b1
                   :                            full;

endmodule
