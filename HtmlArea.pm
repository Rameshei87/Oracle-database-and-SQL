package HTML::FormHandler::Field::HtmlArea;
# ABSTRACT: input HTML in a textarea

use Moose;
extends 'HTML::FormHandler::Field::TextArea';
use HTML::Tidy;
use File::Temp;
our $VERSION = '0.01';

my $tidy;

has '+widget' => ( default => 'TextArea' );

sub validate {
    my $field = shift;

    return unless $field->next::method;

    $tidy ||= $field->tidy;
    $tidy->clear_messages;

    # parse doesn't pass the config file in HTML::Tidy.
    $tidy->clean( $field->input );

    my $ok = 1;

    for ( $tidy->messages ) {
        $field->add_error( $_->as_string );
        $ok = 0;
    }

    return $ok;
}

# Parses config file.  Do it once.

my $tidy_config;

sub tidy {
    my $field = shift;
    $tidy_config ||= $field->init_tidy;
    my $t = HTML::Tidy->new( { config_file => $tidy_config } );

    $t->ignore( text => qr/DOCTYPE/ );
    $t->ignore( text => qr/missing 'title'/ );
    # $t->ignore( type => TIDY_WARNING );

    return $t;
}

sub init_tidy {

    my $tidy_conf = <<EOF;
char-encoding: utf8
input-encoding: utf8
output-xhtml: yes
logical-emphasis: yes
quiet: yes
show-body-only: yes
wrap: 45
EOF

    my $tidy_file = File::Temp->new( UNLINK => 1 );
    print $tidy_file $tidy_conf;
    close $tidy_file;

    return $tidy_file;

}


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::HtmlArea - input HTML in a textarea

=head1 VERSION

version 0.40021

=head1 SYNOPSIS

See L<HTML::FormHandler>

=head1 DESCRIPTION

Field validates using HTML::Tidy.  A simple Tidy configuration file
is created and written to disk each time the field is validated.
Widget type is 'textarea'.

=head1 DEPENDENCIES

L<HTML::Tidy>  L<File::Temp>

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

