# Copyright (c) 2020 Singularis
# Published under Creative Commons CC0 1.0 Universal License

package PerlSwitch;

use strict;
use warnings;
use utf8;
use English;

# PUBLIC METHODS

sub new {
    my $class = shift(@ARG);
    my $self = { "value", undef, "case", \&_uninic };
    bless($self, $class);
    return $self;
}

sub switch_string {
    my $self = shift(@ARG);
    my $argument = shift(@ARG);
    if (!defined($argument)) {
        undef($self->{"value"});
        $self->{"case"} = \&_undef;
    } else {
        $self->{"value"} = $argument;
        $self->{"case"} = \&_string;
    }
    return 0 == 0;
}

sub switch_number {
    my $self = shift(@ARG);
    my $argument = shift(@ARG);
    if (!defined($argument)) {
        undef($self->{"value"});
        $self->{"case"} = \&_undef;
    } else {
        $self->{"value"} = $argument;
        $self->{"case"} = \&_number;
    }
    return 0 == 0;
}

sub case {
    return $ARG[0]->{"case"}(@ARG);
}

sub default {
    my $self = shift(@ARG);
    my $result = !$self->{"case"}();
    $self->{"case"} = \&_fall if ($result);
    return $result;
}

# ALIASES

sub switch {return switch_string(@ARG)}
sub kdyz {return case(@ARG)}
sub prepinat_retezec {return switch_string(@ARG)}
sub prepinat_cislo {return switch_number(@ARG)}

# PRIVATE METHODS

sub _neinic {die("PerlSwitch used uninitialized!")}
sub _fall {return 0 == 0}

sub _found {
    $ARG[0]->{"case"} = \&_fall;
    return 0 == 0;
}

sub _string {
    my $self = shift(@ARG);
    my $value = $self->{"value"};
    foreach my $argument (@ARG) {
        return _found($self) if (defined($argument) && $argument eq $value);
    }
    return 0 != 0;
}

sub _number {
    my $self = shift(@ARG);
    my $value = $self->{"value"};
    foreach my $argument (@ARG) {
        return _found($self) if (defined($argument) && $argument == $value);
    }
    return 0 != 0;
}

sub _undef {
    my $self = shift(@ARG);
    foreach my $argument (@ARG) {
        return _found($self) if (!defined($argument));
    }
    return 0 != 0;
}

1;
