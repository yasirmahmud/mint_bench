module top20;
  logic [7:0] data[0:3];
  initial begin
    int i = 0;
    while (i < 4) begin
      data[i] = 8'h88;
      i++;
    end
    $display("INFO: data initialized: %p", data);
    int read_check_sum = 0;
    for (int j = 0; j < 4; j++) begin
      read_check_sum += data[j];
    end
    $display("INFO: Data elements summed for lint resolution: %0d", read_check_sum);
  end
endmodule
