import List "mo:base/List";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";

actor{
    type List<T> = List.List<T>;

    // 1. Write a function unique that takes a list l of type List and returns a new list with all duplicate elements removed.
    // public func unique<T>(l : List<T>) :async List<T>{
    //     var out : List<T> = List.nil<T>();
    //     for(value in l.toIter()){
    //         if(contains(l, value)){
    //             out := List.push<T>(value, out);
    //         };
    //     };
    //     return out;
    // };

    // 2. Write a function reverse that takes l of type List and returns the reversed list.
    // public func reverse<T>(l: List<T>) : async List<T>{
    //     return List.reverse<T>(l);
    // };

    // 3. Write a function is_anonymous that takes no arguments but returns a Boolean indicating if the caller is anonymous or not.
    public shared ({caller = us}) func is_anonymous() : async Bool{
        Principal.isAnonymous(us);
    };

    // 4. Write a function find_in_buffer that takes two arguments, buf of type Buffer and val of type T, and returns the optional index of the first occurrence of "val" in "buf".
    public func find_in_buffer<T>(buf : Buffer.Buffer<T>, val : T) : async ?Nat{
        Buffer.indexof<T>(buf, val);
    };

    // 5.Add a function called get_usernames that will return an array of tuples (Principal, Text) which contains all the entries in usernames.
    let usernames = HashMap.HashMap<Principal, Text>(0, Principal.equal, Principal.hash);
    type X = (Principal, Text);
    public shared ({ caller }) func add_username(name : Text) : async () {
    usernames.put(caller, name);
    };

    public func get_usernames() : async [(Principal, Text)] {
    var e = Iter.toArray<X>(usernames.entries());

    return e;
    };
}   