import Array "mo:base/Array";
import Text "mo:base/Text";
import Char "mo:base/Char";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";

// import Char "mo:base/Char";
actor {
  // 1. Write a function average_array that takes an array of integers and returns the average value of the elements in the array.
  public func average_array(numbers : [Nat]) : async Nat {
    var prom : Nat = 0;
    for (number in numbers.vals()) {
      prom := prom + number;
    };
    prom / numbers.size();
  };

  // 2. Character count: Write a function that takes in a string and a character, and returns the number of occurrences of that character in the string.
  public func count_character(t: Text, c : Char) : async Nat {
    var chars : Nat = 0;
    for(string in Text.toIter(t)){
      if(Char.equal(string, c)){
        chars := chars + 1;
      };
    };
    chars;
  };

  // 3. Write a function factorial that takes a natural number n and returns the factorial of n.
  public func factorial(n : Nat) : async Nat{
    var counter : Nat = 1;
    var fact : Nat = 1;
    loop{
      if(counter <= n){
        fact := fact * counter;
        counter := counter + 1;
      }
      else{
        return fact;
      };
    };
  };

  // 4. Write a function number_of_words that takes a sentence and returns the number of words in the sentence.
  type Pattern = Text.Pattern;
  let char : Pattern = #char(' ');
  public func number_of_words(t : Text) : async Nat{
    var num = Text.split(t, char);
    var txtArr = Iter.toArray(num);
    var sum = txtArr.size();
    sum;
  };

  // 5. Write a function find_duplicates that takes an array of natural numbers and returns a new array containing all duplicate numbers. The order of the elements in the returned array should be the same as the order of the first occurrence in the input array.
  public func find_duplicates(a : [Nat]) : async [Nat]{
    var numbers = Buffer.Buffer<Nat>(0);
    var repeat : Nat = 0;
    var contain : Bool = false;
    for(num in a.vals()){
      for(num2 in a.vals()){
        if(num == num2){
          repeat := repeat + 1;
        };
      };
      if(repeat > 1){
        contain := Buffer.contains<Nat>(numbers, num, func (x : Nat, y: Nat) : Bool {x==y});
        repeat := 0;
        if(contain != true){
            numbers.add(num);
        }; 
      };
      repeat := 0;
    };
    return Buffer.toArray(numbers);
  };

  // 6. Write a function convert_to_binary that takes a natural number n and returns a string representing the binary representation of n.
  public func convert_to_binary(n : Nat) : async Text{
    var num : Text = Nat.toText(n);
    var blob : Blob = Text.encodeUtf8(num);
    Debug.print(debug_show(blob));
    return debug_show(blob);
  };
};
