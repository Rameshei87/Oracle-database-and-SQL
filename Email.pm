package HTML::FormHandler::Field::Email;
# ABSTRACT: validates email using Email::Valid

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Text';
use Email::Valid;
our $VERSION = '0.02';

our $class_messages = {
    'email_format' => 'Email should be of the format [_1]',
};
has '+html5_type_attr' => ( default => 'email' );

sub get_class_messages  {
    my $self = shift;
    return {
        %{ $self->next::method },
        %$class_messages,
    }
}

apply(
    [
        {
            transform => sub { lc( $_[0] ) }
        },
        {
            check => sub {
                my ( $value, $field ) = @_;
                my $checked = Email::Valid->address( $value );
                $field->value($checked)
                    if $checked;
            },
            message => sub {
                my ( $value, $field ) = @_;
                return [$field->get_message('email_format'), 'someuser@example.com'];
            },
        }
    ]
);


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Email - validates email using Email::Valid

=head1 VERSION

version 0.40021

=head1 DESCRIPTION

Validates that the input looks like an email address uisng L<Email::Valid>.
Widget type is 'text'.

If form has 'is_html5' flag active it will render <input type="email" ... />
instead of type="text"

=head1 DEPENDENCIES

L<Email::Valid>

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

