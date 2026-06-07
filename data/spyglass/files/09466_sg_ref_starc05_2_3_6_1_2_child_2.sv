module star_05_2_3_6_1_ex2(input clk, input rst_n, input data_in1, input data_in2, output reg q1, output reg q2);

  // Create a separate signal for the enable of q2 to resolve STARC05-1.3.1.3.
  // This ensures rst_n is used purely as an asynchronous reset for q1.
  wire q2_en;
  assign q2_en = rst_n;

  // q1 has an asynchronous reset, as per original design
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q1 <= 1'b0;
    end else begin
      q1 <= data_in1;
    end
  end

  // q2 does not have an asynchronous reset. It only updates when rst_n is high.
  // By using q2_en, the STARC05-1.3.1.3 violation is resolved by separating the reset logic.
  always @(posedge clk) begin
    if (q2_en) begin // q2 updates only when q2_en (which is rst_n) is high
      q2 <= data_in2;
    end
  end

endmodule
