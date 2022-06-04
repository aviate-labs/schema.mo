import { describe; it; Suite } = "mo:testing/Suite";

import Schema "../src/Schema";
import Value "../src/Value";

let suite = Suite();

let userSchema = Schema.new(
    "urn:schema:example:user",
    [
        {
            name        = "userName";
            description = ?"Unique identifier for the User";
            typ         = #Text;
            multiValued = false;
        }
    ],
    [
        {
            name        = "firstName";
            description = null;
            typ         = #Text;
            multiValued = false;
        }
    ]
);

suite.run([
    describe("Schema", [
        it("check schema attribute names", func () : Bool {
            Schema.Schema.valid(userSchema);
        }),
        it("missing required attribute", func () : Bool {
            not Schema.Schema.validate(userSchema, Value.Complex.fromArray([
                ("firstName", #Text("john")),
            ]));
        }),
        it("validate attributes", func () : Bool {
            Schema.Schema.validate(userSchema, Value.Complex.fromArray([
                ("userName", #Text("jd")),
                ("firstName", #Text("john")),
            ]));
        }),
    ])
]);
