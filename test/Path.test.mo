import { describe; it; Suite } = "mo:testing/Suite";

import Path "../src/Path";
import Value "../src/Value";

let suite = Suite();

suite.run([
    describe("Path", [
        it("get path", func () : Bool {
            let name = Value.Complex.fromArray([
                ("firstName", #Text("John")),
                ("lastName", #Text("Doe")),
            ]);
            let user = Value.Complex.fromArray([
                ("id", #Text("jd")),
                ("name", #Complex(name)),
            ]);
            let pathFirstName = ("name", #Path("firstName", #Type(#Text)));
            if (not Value.Value.equal(Path.get(user, pathFirstName), #Text("John"))) return false;
            let pathName = ("name", #Type(#Complex));
            Value.Value.equal(Path.get(user, pathName), #Complex(name));
        }),
        it("get path: mv", func () : Bool {
            let user = Value.Complex.fromArray([
                ("id", #Text("jd")),
                ("emails", #MultiValued([#Text("john@example.com"), #Text("jd@example.com")]))
            ]);
            let path = ("emails", #Index(1, #Type(#Text)));
            Value.Value.equal(Path.get(user, path), #Text("jd@example.com"));
        }),
    ])
]);
