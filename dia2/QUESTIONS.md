## Questions Day 2

**1.  Who controls the ledger canister?**
>	R:/ The NNS (Network Neuronal System)

**2.  What is the subnet of the canister with the id:  *mwrha-maaaa-aaaab-qabqq-cai*? How much nodes are running this subnet?**
> R:/ The subnet of that canister is *pae4o-o6dxf-xki7q-ezclx-znyd6-fnk6w-vkv5z-5lfwh-xym2i-otrrw-fqe* and it has 16 Nodes running in it.

**3. I have a neuron with 1O ICPs locked with a dissolve delay of 4 years - my neuron has been locked for 2 years. What is my expected voting power?**
> R:/ My expected voting power is 9.375

**4. What is wrong with the following code?**
~~~
actor {
  let n : Nat = 50;
  let t : Text = "Hello";

  public func convert_to_text(m : Nat) : async Text {
    Nat.toText(m);
  };
 
}
~~~
> R:/ Nat Type is not imported, so the function .toText(m) can't be used.

**5.  What is wrong with the following code?**
~~~
actor {
  var languages : [var Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [var Text] {
    return (languages);
  };
 
}
~~~
> R:/ Public functions can't return mutable variables.

**6. What is wrong with the following code?**
~~~
actor {
  var languages : [Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func add_language(new_language: Text) : async [Text] {
    languages := Array.append<Text>(languages, [new_language]);
    return (languages);
  };
 
}
~~~
>R:/ Array Types is not being imported, so the function .append can't be used.