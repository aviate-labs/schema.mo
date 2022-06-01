module {
    public type SingularType = {
        #Text;
        #Bool;
        #Float;
        #Nat;
        #Int;
        #Blob;
        #Principal;
        #Complex;
    };

    public type Type = SingularType or {
        #MultiValued : Type;
    };
}