package HTML::FormHandler::Field::Duration;
# ABSTRACT: DateTime::Duration from HTML form values

use Moose;
extends 'HTML::FormHandler::Field::Compound';
use DateTime;

our $VERSION = '0.01';


our $class_messages = {
    'duration_invalid' => 'Invalid value for [_1]: [_2]',
};

sub get_class_messages  {
    my $self = shift;
    return {
        %{ $self->next::method },
        %$class_messages,
    }
}


sub validate {
    my ($self) = @_;

    my @dur_parms;
    foreach my $child ( $self->all_fields ) {
        unless ( $child->has_value && $child->value =~ /^\d+$/ ) {
            $self->add_error( $self->get_message('duration_invalid'), $self->loc_label, $child->loc_label );
            next;
        }
        push @dur_parms, ( $child->accessor => $child->value );
    }

    # set the value
    my $duration = DateTime::Duration->new(@dur_parms);
    $self->_set_value($duration);
}

__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;


__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Duration - DateTime::Duration from HTML form values

=head1 VERSION

version 0.40021

=head1 SubFields

Subfield names:

  years, months, weeks, days, hours, minutes, seconds, nanoseconds

For example:

   has 'duration' => ( type => 'Duration' );
   has 'duration.hours' => ( type => 'Int', range_start => 0,
        range_end => 23 );
   has 'duration.minutes' => ( type => 'Int', range_start => 0,
        range_end => 59 );

Customize error message 'duration_invalid' (default 'Invalid value for [_1]: [_2]')

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

