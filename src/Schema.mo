import Prim "mo:⛔";

import Radix "mo:std/Tree/Radix";
import Text "mo:std/Text";

import Attribute "Attribute";
import Value "Value";

module {
    public type Schema = {
        id       : Text;
        required : Radix.Tree<Attribute.Data>;
        optional : Radix.Tree<Attribute.Data>;
    };

    public func new(id : Text, required : [Attribute.Attribute], optional : [Attribute.Attribute]) : Schema {
        let requiredTree = Radix.new<Attribute.Data>();
        for (value in required.vals()) ignore Radix.insert<Attribute.Data>(requiredTree, Text.toArray(value.name), value);
        let optionalTree = Radix.new<Attribute.Data>();
        for (value in optional.vals()) ignore Radix.insert<Attribute.Data>(optionalTree, Text.toArray(value.name), value);
        {
            id;
            required = requiredTree;
            optional = optionalTree;
        };
    };

    public module Schema {
        public func valid(schema : Schema) : Bool {
            var invalid = false;
            Radix.walk(schema.required.root, func (name : [Char], _ : Attribute.Data) : Bool {
                if (not Attribute.Name.valid(name)) invalid := true; // stop walk.
                invalid;
            });
            if (invalid) return false;
            Radix.walk(schema.optional.root, func (name : [Char], _ : Attribute.Data) : Bool {
                if (not Attribute.Name.valid(name)) invalid := true; // stop walk.
                invalid;
            });
            not invalid;
        };

        public func validate(schema : Schema, value : Value.Complex) : Bool {
            var invalid = false;
            Radix.walk(schema.required.root, func (name : [Char], data : Attribute.Data) : Bool {
                switch (Radix.get<Value.Value>(value, name)) {
                    case (null) invalid := true;
                    case (? value) {
                        if (not Attribute.Data.validate(data, value)) invalid := true;
                    };
                };
                invalid;
            });
            if (invalid) return false;
            Radix.walk(value.root, func (name : [Char], value : Value.Value) : Bool {
                switch (Radix.get<Attribute.Data>(schema.optional, name)) {
                    case (null) {};
                    case (? data) {
                        if (not Attribute.Data.validate(data, value)) invalid := true;
                    };
                };
                invalid;
            });
            not invalid;
        };
    }
};
