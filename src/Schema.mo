import Attribute "Attribute";
import Value "Value";

module {
    public type Schema = {
        id          : Text;
        name        : ?Text;
        description : ?Text;
        requiredAttributes : [Attribute.Attribute];
        optionalAttributes : [Attribute.Attribute];
    };

    public module Schema {
        public func valid(schema : Schema) : Bool {
            switch (schema.name) {
                case (? name) if (not Attribute.Name.valid(name)) return false;
                case (_) {};
            };
            for (attribute in schema.requiredAttributes.vals()) {
                if (not Attribute.Name.valid(attribute.name)) return false;
            };
            for (attribute in schema.optionalAttributes.vals()) {
                if (not Attribute.Name.valid(attribute.name)) return false;
            };
            true;
        };

        private func searchRequiredAttribute(value : Value.Complex, attributeName : Text) : ?Value.Value {
            for ((name, value) in value.vals()) {
                if (name == attributeName) return ?value;
            };
            null;
        };

        private func searchOptionalAttribute(schema : Schema, name : Text) : ?Attribute.Attribute {
            for (attribute in schema.optionalAttributes.vals()) {
                if (attribute.name == name) return ?attribute;
            };
            null;
        };

        public func validate(schema : Schema, value : Value.Complex) : Bool {
            for (attribute in schema.requiredAttributes.vals()) {
                switch (searchRequiredAttribute(value, attribute.name)) {
                    case (null) return false;
                    case (? value) {
                        if (not Attribute.Attribute.validate(attribute, value)) {
                            return false;
                        };
                    };
                };
            };
            for ((name, value) in value.vals()) {
                switch (searchOptionalAttribute(schema, name)) {
                    case (? attribute) {
                        if (not Attribute.Attribute.validate(attribute, value)) {
                            return false;
                        };
                    };
                    case (null) {};
                };
            };
            true;
        };
    }
};
