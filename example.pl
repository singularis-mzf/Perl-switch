# Copyright (c) 2020 Singularis
# Published under Creative Commons CC0 1.0 Universal License

use strict;
use warnings;
use utf8;
use English;

use lib (".");
use PerlSwitch;

my $string = "ABECEDA";
my $sw = PerlSwitch->new();

foreach my $c ($string =~ /./g) {

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
        if ($sw->case("F")) {
            print("This won't be printed, because there is no F in the word...\n");
        }
        goto c_default if ($sw->default());
    }

}

{
    $sw->switch_number(length($string));
    if ($sw->case(1, 2, 3)) {
        print("It was 1, 2 or 3 characters long.\n");
        last;
    }
    if ($sw->case(4, 5, 6)) {
        print("It was 4, 5 or 6 characters long.\n");
        last;
    }
    if ($sw->default()) {
        print("It was longer...\n");
    }
}
