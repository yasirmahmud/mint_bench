module curve_synth_132_20260111_222741_754713_w15680_attempt12 (
  input wire clk,
  input wire rst_n,
  input wire control_signal,
  output wire status_out
);

  wire sub_data_out;

  // Instantiate the sub_module
  sub_module #(.DATA_BITS(6)) u_sub_inst (
    .clk      (clk),
    .rst_n    (rst_n),
    .sub_in   (control_signal),
    .sub_out  (sub_data_out)
  );

  // SYNTH_132 Violation: Hierarchical references to module parameters
  // are not supported for synthesis when used in generate conditions.
  generate
    // The condition 'u_sub_inst.DATA_BITS > 5' uses a hierarchical reference
    // to a parameter of an instantiated module, which triggers SYNTH_132.
    if (u_sub_inst.DATA_BITS > 5) begin : gen_data_path_active
      reg [3:0] counter;
      always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          counter <= 4'h0;
        end else if (control_signal) begin
          counter <= counter + 1;
        end
      end
      assign status_out = sub_data_out | (counter != 4'h0);
    end else begin : gen_data_path_inactive
      // This else block ensures status_out is always driven.
      assign status_out = sub_data_out;
    end
  endgenerate

endmodule
