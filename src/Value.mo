import Type "Type";

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

    public func isType(value : Value, typ : Type.Type) : Bool {
        switch (typ) {
            case (#Text) switch (value) {
                case (#Text(_)) true;
                case (_) false;
            };
            case (#Bool) switch (value) {
                case (#Bool(_)) true;
                case (_) false;
            };
            case (#Float) switch (value) {
                case (#Float(_)) true;
                case (_) false;
            };
            case (#Nat) switch (value) {
                case (#Nat(_)) true;
                case (_) false;
            };
            case (#Int) switch (value) {
                case (#Int(_)) true;
                case (_) false;
            };
            case (#Blob) switch (value) {
                case (#Blob(_)) true;
                case (_) false;
            };
            case (#Principal) switch (value) {
                case (#Principal(_)) true;
                case (_) false;
            };
            case (#Complex) switch (value) {
                case (#Complex(_)) true;
                case (_) false;
            };
        };
    };
};