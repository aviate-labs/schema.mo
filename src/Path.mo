import Attribute "Attribute";
import Type "Type";
import Value "Value";

module {
    // TODO: multi-valued values?

    public type Path = (Text, SubPath);
    public type SubPath = {
        #Path : Path;
        #Type : Type.Type;
    };

    public func getPath(value : Value.Complex, (name, path) : Path) : Value.Value {
        for ((k, v) in value.vals()) {
            if (k == name) return getSubPath(v, path);
        };
        #Null;
    };

    private func getSubPath(value : Value.Value, path : SubPath) : Value.Value {
        switch (path) {
            case (#Type(typ)) {
                if (Value.isType(value, typ)) return value;
            };
            case (#Path(path)) switch (value) {
                case (#Complex(value)) return getPath(value, path);
                case (_) {};
            };
        };
        #Null;
    };
};