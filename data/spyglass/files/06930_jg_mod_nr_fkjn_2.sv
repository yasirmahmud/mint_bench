module example_fork_join_2();
  reg [7:0] data_a, data_b;

  initial begin
    data_a = 8'h00;
    data_b = 8'hFF;
    fork
      begin
        #20;
        data_a = 8'hAA;
        $display("Data A updated to %h", data_a);
      end
      begin
        #10;
        data_b = 8'h55;
        $display("Data B updated to %h", data_b);
      end
    join_any // This is also a non-synthesizable fork-join construct
    $display("Fork-join_any block exited. Current data_a: %h, data_b: %h", data_a, data_b);
  end
endmodule
