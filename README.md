# Perl-switch

Simple, but useful C/C++ switch emulation in Perl. No surprises, I hope.

License: CC0

Usage example:

```perl
    {
        $sw->switch_string($c);
        if ($sw->case("A")) {
            print("It was definitely A! ");
        }
        if ($sw->case("B")) {
            print("Or it was B?\n");
            last;
        }
        c_default:
        if ($sw->case()) {
            # This is a default case placed in the middle
            print("Some unknown letter: ", $c, "\n");
            last;
        }
        if ($sw->case("D", "E")) {
            print("Some weird letter like ", $c, "\n");
            last;
        }
        if ($sw->case(undef)) {
            print("Oops...\n");
            die("Something wrong...");
        }
        if ($sw->case("F")) {
            print("This won't be printed, because there is no F in the word...\n");
        }
        goto c_default if ($sw->default());
    }
```

## MANUAL

* The first statement (switch_string or switch_number) saves the value of its argument and decides the type of comparison (== for numbers, „eq“ for strings or defined() if the argument is „undef“).
* You use a sequence of if(case()) statements to define cases.
* You can use multiple arguments (or even arrays of values) in one case() call. The first matching value starts execution (and a possible fall-through).
* Most blocks will be terminated by „last“, „return“, „goto“ or similar statement; if not, the execution will fall through to the next case. Just like in C.
* The default() method is an exception − it only switches the fall-through flag, so the „default“ block will be executed, only when no comparison in any case() call has succeeded yet.
* The case() method can be called with no arguments to test if a fall-through has been activated.
* Switch-object could be easily reused.
* You can place the „default“ case in the middle of the switch by using „goto“, but the call to default() method must stay at the end.

## CAVEATS

* Arguments of case() method are not checked to be unique.
* The only valid place for calling „default()“ is after all the cases and **you can't fall-through to the default branch** if guarded by „if“ statement (but you can simply remove „if“ statement from the default branch to allow fall-through).
