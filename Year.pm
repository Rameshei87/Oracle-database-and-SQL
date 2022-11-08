package HTML::FormHandler::Field::Year;
# ABSTRACT: year selection list

use Moose;
extends 'HTML::FormHandler::Field::IntRange';

our $VERSION = '0.01';

has '+range_start' => (
    default => sub {
        my $year = (localtime)[5] + 1900 - 5;
        return $year;
    }
);
has '+range_end' => (
    default => sub {
        my $year = (localtime)[5] + 1900 + 10;
        return $year;
    }
);


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Year - year selection list

=head1 VERSION

version 0.40021

=head1 DESCRIPTION

Provides a list of years starting five years back and extending 10 years into
the future.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

