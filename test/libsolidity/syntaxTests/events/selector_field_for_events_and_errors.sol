interface MyInterface {
    event someEvent();
    error someError();
    function someFunction() external;
}

contract Test {
    function nameIsIrrelevant() pure public {
        MyInterface.someFunction.selector; // This works
        MyInterface.someEvent.selector; // This doesn't, that is what I'd like to add
        MyInterface.someError.selector; // This doesn't, that is what I'd like to add
    }
}
// ----
// Warning 6133: (181-214): Statement has no effect.
