import { describe; it; Suite } = "mo:testing/Suite";

import Path "../src/Path";
import Value "../src/Value";

let suite = Suite();

suite.run([
    describe("Path", [
        it("get path", func () : Bool {
            let user : Value.Complex = [
                ("id", #Text("jd")),
                ("name", #Complex([
                    ("firstName", #Text("John")),
                    ("lastName", #Text("Doe")),
                ]))
            ];
            Path.get(user, ("name", #Path("firstName", #Type(#Text)))) == #Text("John");
        }),
        it("get path: mv", func () : Bool {
            let user : Value.Complex = [
                ("id", #Text("jd")),
                ("emails", #MultiValued([#Text("john@example.com"), #Text("jd@example.com")]))
            ];
            Path.get(user, ("emails", #Index(1, #Type(#Text)))) == #Text("jd@example.com");
        }),
    ])
]);
