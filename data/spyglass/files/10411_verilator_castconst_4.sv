module cast_const_ex4;
  class Animal;
  endclass
  class Dog extends Animal;
  endclass
  initial begin
    Dog my_dog = new();
    Animal pet;
    int success = $cast(pet, my_dog);
    if (success == 0) begin // Always succeeds
      $display("Cast failed");
    end
  end
endmodule
