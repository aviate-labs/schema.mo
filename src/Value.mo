import Radix "mo:std/Tree/Radix";
import Text "mo:std/Text";

import Type "Type";

module {
    public type Complex = Radix.Tree<Value>;

    public module Complex = {
        public func fromArray(fields : [(Text, Value)]) : Complex {
            let tree = Radix.new<Value>();
            for ((t, v) in fields.vals()) ignore Radix.insert<Value>(tree, Text.toArray(t), v);
            tree;
        };
    };

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

    public module Value = {
        public func equal(x : Value, y : Value) : Bool {
            switch (x, y) {
                case (#Null, #Null) true;
                case (#Text(x), #Text(y)) x == y;
                case (#Bool(x), #Bool(y)) x == y;
                case (#Float(x), #Float(y)) x == y;
                case (#Nat(x), #Nat(y)) x == y;
                case (#Int(x), #Int(y)) x == y;
                case (#Blob(x), #Blob(y)) x == y;
                case (#Principal(x), #Principal(y)) x == y;
                case (#Complex(x), #Complex(y)) {
                    if (x.size != y.size) return false;
                    let xs = Radix.toArray(x);
                    var invalid = false;
                    var i = 0;
                    Radix.walk(y.root, func (key : [Char], value : Value) : Bool {
                        if (key != xs[i].0 or not equal(xs[i].1, value)) invalid := true;
                        i += 1;
                        invalid;
                    });
                    not invalid;
                };
                case (#MultiValued(xs), #MultiValued(ys)) {
                    if (xs.size() != ys.size()) return false;
                    var i = 0;
                    for (x in xs.vals()) {
                        if (not equal(x, ys[i])) return false;
                        i += 1;
                    };
                    true;
                };
                case (_) false;
            };
        };
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
            case (#MultiValued(typ)) switch (value) {
                case (#MultiValued(values)) {
                    for (value in values.vals()) {
                        if (not isType(value, typ)) return false;
                    };
                    true;
                };
                case (_) false;
            };
        };
    };
};