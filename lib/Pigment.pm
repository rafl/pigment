use strict;
use warnings;

package Pigment;

use parent qw/DynaLoader/;
use Gtk2;

our $VERSION = '0.01';

sub dl_load_flags { 0x01 };

__PACKAGE__->bootstrap($VERSION);

sub import {
    my ($class, @args) = @_;

    my $init = 1;

    for my $arg (@args) {
        if (/^-?no_?init$/) {
            $init = 0;
        }
    }

    $class->init if $init;
    return;
}

1;
