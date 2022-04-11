library L {
    event E();
}
library S {
    event E(uint);
}
library T {
    event E();
}
interface I {
    event E();
}
library Y {
    event E() anonymous;
}

contract D {
    event F();
}

contract C is D {
    function test1() external pure returns (bytes4, bytes4, bytes4, bytes4) {
        assert(L.E.selector == T.E.selector);
        assert(I.E.selector == L.E.selector);
        assert(Y.E.selector == L.E.selector);

        assert(L.E.selector != S.E.selector);
        assert(T.E.selector != S.E.selector);
        assert(I.E.selector != S.E.selector);
        assert(Y.E.selector != S.E.selector);

        return (L.E.selector, S.E.selector, I.E.selector, Y.E.selector);
    }

    bytes4 s1 = L.E.selector;
    bytes4 s2 = S.E.selector;
    bytes4 s3 = T.E.selector;
    bytes4 s4 = I.E.selector;
    bytes4 s5 = Y.E.selector;
    function test2() external returns (bytes4, bytes4, bytes4, bytes4, bytes4) {
        return (s1, s2, s3, s4, s5);
    }

    function test3() external returns (bytes4) {
        return (F.selector);
    }
}
// ====
// compileViaYul: also
// ----
// test1() -> 0x92bbf6e800000000000000000000000000000000000000000000000000000000, 0x2ff06700000000000000000000000000000000000000000000000000000000, 0x92bbf6e800000000000000000000000000000000000000000000000000000000, 0x92bbf6e800000000000000000000000000000000000000000000000000000000
// test2() -> 0x92bbf6e800000000000000000000000000000000000000000000000000000000, 0x2ff06700000000000000000000000000000000000000000000000000000000, 0x92bbf6e800000000000000000000000000000000000000000000000000000000, 0x92bbf6e800000000000000000000000000000000000000000000000000000000, 0x92bbf6e800000000000000000000000000000000000000000000000000000000
// test3() -> 0x28811f5900000000000000000000000000000000000000000000000000000000
