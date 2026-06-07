module star_05_2_3_6_1_ex2(input clk, input rst_n, input data_in1, input data_in2, output reg q1, output reg q2);

  // q1 has an asynchronous reset, as per original design
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q1 <= 1'b0;
    end else begin
      q1 <= data_in1;
    end
  end

  // q2 does not have an asynchronous reset. It only updates when rst_n is high.
  // This resolves the STARC05-1.3.1.3 violation by separating the reset logic.
  always @(posedge clk) begin
    if (rst_n) begin // q2 updates only when rst_n is not asserted (active high enable)
      q2 <= data_in2;
    end
  end

endmodule
