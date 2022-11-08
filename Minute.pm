package HTML::FormHandler::Field::Minute;
# ABSTRACT: input range from 0 to 59

use Moose;
extends 'HTML::FormHandler::Field::IntRange';
our $VERSION = '0.01';

has '+range_start'  => ( default => 0 );
has '+range_end'    => ( default => 59 );
has '+label_format' => ( default => '%02d' );


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Minute - input range from 0 to 59

=head1 VERSION

version 0.40021

=head1 DESCRIPTION

Generate a select list for entering a minute value.
Widget type is 'select'.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

