## Questions Day 4
**1. Is the heap memory saved when upgrading a canister? How much heap memory does a canister has?**
>R:/ No, the heap memory doesn't save when upgrading a canister. A canister has 4gb of Heap Memory

**2. How much accounts can a unique Principal own?**
>R:/ A Principal can have atleast unlimited number of Accounts

**3. Can we safely upgrade a canister from interface A to interface B?**

Interface A
~~~
actor {
  public func greet(surname : Text, firstname : Text) : async Text {
    return "Hello" # firstname # surname # " !";
  };
}
~~~
Interface B
~~~
actor {
  public func greet(firstname : Text) : async Text {
    return "Hello" # firstname # " !";
  };
}
~~~

>R:/ In this case yes, because there's no information being saved in the memory of the canister, so upgrading is safe because you won't lose anything if you don't have nothing.