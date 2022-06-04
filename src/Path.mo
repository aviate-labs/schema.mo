import Radix "mo:std/Tree/Radix";
import Text "mo:std/Text";

import Attribute "Attribute";
import Type "Type";
import Value "Value";

module {
    public type Path = (Text, SubPath);

    public type SubPath = {
        #Index : (index : Nat, path : SubPath);
        #Path  : Path;
        #Type  : Type.SingularType;
    };

    public func get(value : Value.Complex, (name, path) : Path) : Value.Value {
        switch (Radix.get(value, Text.toArray(name))) {
            case (? value) getSub(value, path);
            case (null)    #Null;
        };
    };

    private func getSub(value : Value.Value, path : SubPath) : Value.Value {
        switch (path) {
            case (#Index(index, path)) switch (value) {
                case (#MultiValued(values)) {
                    if (index >= values.size()) return #Null;
                    return getSub(values[index], path);
                };
                case (_) {};
            };
            case (#Path(path)) switch (value) {
                case (#Complex(value)) return get(value, path);
                case (_) {};
            };
            case (#Type(typ)) {
                if (Value.isType(value, typ)) return value;
            };
        };
        #Null;
    };
};