package HTML::FormHandler::Field::MonthName;
# ABSTRACT: select list with month names

use Moose;
extends 'HTML::FormHandler::Field::Select';
our $VERSION = '0.01';

sub build_options {
    my $i      = 1;
    my @months = qw/
        January
        February
        March
        April
        May
        June
        July
        August
        September
        October
        November
        December
        /;
    return [ map { { value => $i++, label => $_ } } @months ];
}


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::MonthName - select list with month names

=head1 VERSION

version 0.40021

=head1 DESCRIPTION

Generates a list of English month names.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

