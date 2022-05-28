module {
    public type Complex = [(Text, Value)];

    public type Value = {
        #Null;
        #Text       : Text;
        #Bool       : Bool;
        #Float      : Float;
        #Nat        : Nat;
        #Int        : Int;
        #Blob       : Blob;
        #Principal  : Principal;
        #Complex    : Complex;
        #MultiValued : [Value];
    };
};