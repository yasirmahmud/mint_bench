module MissingTrigger1 (
  input wire a,
  output reg b
);

  always begin
    b = a;
  end

endmodule
