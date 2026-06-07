module const_write_14;
  string NAME = "user";
  initial begin
    case(1)
      1: NAME = "admin";
    endcase
  end
endmodule
