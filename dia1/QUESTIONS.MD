## Questions Day 1
**1.  How much is the current memory capacity of a canister?**
>	R:/ 8 Gigabytes 

**2.  What is the issue with the following code sample?**
~~~
actor {
  let counter : Nat = 0;
  public func increment_counter() : async () {
    counter := counter + 1;
  };
}
~~~
> R:/ The variable counter is declared with let, that means that you can´t change 
> its value.

**3.  What is the issue with the following code sample?**
~~~
actor {
  var message : Text = 0;

  public query func change_message(new_message : Text) : async () {
    message := new_message;
    return;
  };
  
  public query func see_message() : async Text {
    return(message);
  };
}
~~~
> R:/ The variable message is declared with type Text, but the value that is being assigned to it is not a text.

**4.  False or True: we can remove the keyword  *async*   for return argument of a query function since queries are faster to answer.**
> R:/ False.