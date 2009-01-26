use strict;
use warnings;

package Module::Install::PRIVATE::Pigment;

use base qw/Module::Install::Base/;

use Gtk2::CodeGen;
use Glib::MakeHelper;
use ExtUtils::Depends;
use ExtUtils::PkgConfig;
use File::Spec::Functions qw/catfile rel2abs/;

sub pigment {
    my ($self) = @_;

    mkdir 'build';

    my %pkgconfig;
    eval {
        %pkgconfig = ExtUtils::PkgConfig->find('pigment-0.3');
    };

    if (my $error = $@) {
        print STDERR $error;
        return;
    }

    Gtk2::CodeGen->parse_maps('pigment');
    Gtk2::CodeGen->write_boot(ignore => qr/^Pigment$/);

    our @xs_files = <xs/*.xs>;

    our $pigment = ExtUtils::Depends->new('Pigment', 'Gtk2');
    $pigment->set_inc($pkgconfig{cflags});
    $pigment->set_libs($pkgconfig{libs});
    $pigment->add_xs(@xs_files);
    $pigment->add_c('perl_pigment.c');
    $pigment->add_pm('lib/Pigment.pm' => '$(INST_LIBDIR)/Pigment.pm');
    $pigment->add_typemaps(rel2abs(catfile(qw/build pigment.typemap/)));
    $pigment->install(catfile(qw/build pigment-autogen.h/));
    $pigment->save_config(catfile(qw/build IFiles.pm/));

    $self->makemaker_args(
        $pigment->get_makefile_vars,
        XSPROTOARG => '-noprototypes',
    );

    $self->postamble(Glib::MakeHelper->postamble_clean);

    return 1;
}

1;
