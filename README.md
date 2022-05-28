# Schema

⚠️ **NOTE**: WIP, this is NOT optimized, just a quick implementation.

## Example

```motoko
import Schema "mo:schema/Schema"

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
```

```motoko
Schema.Schema.validate(userSchema, [
    ("firstName", #Text("john")),
]); // false (missing 'userName')

Schema.Schema.validate(userSchema, [
    ("userName", #Text("jd")),
    ("firstName", #Text("john")),
]); // true
```

## Testing

```shell
npm test
```
