import Type "Type";
import Value "Value";

module Attribute {
    public type Attribute = {
        name        : Text;
        description : ?Text;
        typ         : Type.Type;
        multiValued : Bool;
    };

    public module Attribute {
        public func validate(attribute : Attribute, value : Value.Value) : Bool {
            if (not attribute.multiValued) return Value.isType(value, attribute.typ);
            switch (value) {
                case (#MultiValued(values)) {
                    for (value in values.vals()) {
                        if (not Value.isType(value, attribute.typ)) {
                            return false;
                        }
                    };
                    true;
                };
                case (_) false;
            };
        };
    };

    // Attribute names are case insensitive and are often "camel-cased" (e.g., "camelCase").
    public type Name = Text;

    public module Name {
        private func isAlpha(c : Char) : Bool {
            ('a' <= c and c <= 'z' or 'A' <= c and c <= 'Z'); 
        };

        private func isDigit(c : Char) : Bool {
            ('0' <= c and c <= '9');
        };

        // Checks whether the given attribute name is valid.
        // Attribute names MUST conform to the following ABNF rules:
        //      attributeName = ALPHA *(nameCharacter)
        //      nameCharacter = "-" / "_" / DIGIT / ALPHA
        public func valid(name : Name) : Bool {
            if (name.size() == 0) return false;
            var i = 0;
            for (c in name.chars()) {
                switch (i) {
                    case (0) {
                        if (not isAlpha(c)) return false;
                        i += 1; // can be done once.
                    };
                    case (_) if (not (isAlpha(c) or isDigit(c) or c == '_' or c == '-')) return false;
                };
            };
            return true;
        };
    };
};
