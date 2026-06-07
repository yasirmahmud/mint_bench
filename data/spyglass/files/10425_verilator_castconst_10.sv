module cast_const_ex10;
  class Animal;
  endclass
  class Dog extends Animal;
  endclass
  initial begin
    Animal pet = new();
    Dog my_dog;
    int success = $cast(my_dog, pet);
    if (success == 1) begin // Always fails
      $display("Cast succeeded");
    end
  end
endmodule
