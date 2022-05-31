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
            Path.getPath(user, ("name", #Path("firstName", #Type(#Text)))) == #Text("John");
        }),
    ])
]);
