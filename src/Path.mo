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
        for ((k, v) in value.vals()) {
            if (k == name) return getSub(v, path);
        };
        #Null;
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