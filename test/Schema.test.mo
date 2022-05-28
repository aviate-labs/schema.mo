import { describe; it; Suite } = "mo:testing/Suite";

import Prim "mo:⛔";

import Schema "../src/Schema"

let suite = Suite();

let userSchema : Schema.Schema = {
    id          = "urn:schema:example:user";
    name        = ?"User";
    description = null;
    requiredAttributes = [
        {
            name        = "userName";
            description = ?"Unique identifier for the User";
            typ         = #Text;
            multiValued = false;
        }
    ];
    optionalAttributes = [
        {
            name        = "firstName";
            description = null;
            typ         = #Text;
            multiValued = false;
        }
    ];
};

suite.run([
    describe("Schema", [
        it("check schema attribute names", func () : Bool {
            Schema.Schema.valid(userSchema);
        }),
        it("missing required attribute", func () : Bool {
            not Schema.Schema.validate(userSchema, [
                ("firstName", #Text("john")),
            ]);
        }),
        it("validate attributes", func () : Bool {
            Schema.Schema.validate(userSchema, [
                ("userName", #Text("jd")),
                ("firstName", #Text("john")),
            ]);
        }),
    ])
]);
