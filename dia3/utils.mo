import Array "mo:base/Array";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";

actor{
    public func second_maximum(array : [Int]) : async Int{
        var newArr = Array.sort<Int>(array, Int.compare);
        return newArr[newArr.size() - 1];
    };

    let f = func (val : Nat) : Bool{
        if(val % 2 != 0){
            return true
        }
        else{
            return false
        }
    };

    public func remove_even(array : [Nat]) : async [Nat]{
        var newArr = Array.filter<Nat>(array, f);
        newArr;
    };

    // public func drop<T>(xs : [T], n : Nat): async [T]{
    //     let arrBuff = Buffer.fromArray<T>(xs);
    //     let subBuff = Buffer.subBuffer<T>(arrBuff, 0, arrBuff.size() - n);
    //     let arr = Buffer.toArray(subBuff);
    //     let out = Array.reverse(arr);
    //     out;
    // };
}