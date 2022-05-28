import { describe; it; Suite } = "mo:testing/Suite";

import Attribute "../src/Attribute"

let suite = Suite();

suite.run([
    describe("AttributeName", [
        it("attribute name start with an ALPHA char", func () : Bool {
            if (not Attribute.Name.valid("ValidName")) return false;
            if (not Attribute.Name.valid("a1_-")) return false;
            not Attribute.Name.valid("_invalid");
        }),
    ])
]);
