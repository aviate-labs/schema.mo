import { describe; it; Suite } = "mo:testing/Suite";
import Text "mo:std/Text";

import Attribute "../src/Attribute"

let suite = Suite();

suite.run([
    describe("AttributeName", [
        it("attribute name start with an ALPHA char", func () : Bool {
            if (not Attribute.Name.valid(Text.toArray("ValidName"))) return false;
            if (not Attribute.Name.valid(Text.toArray("a1_-"))) return false;
            not Attribute.Name.valid(Text.toArray("_invalid"));
        }),
    ])
]);
