package Gitosis::Config::Reader;
use Moose;
extends qw(Config::INI::Reader);

sub can_ignore {
    my ( $self, $line ) = @_;
    return $line =~ /\A\s*(?:;|$|#)/ ? 1 : 0;    # Skip comments and empty lines
}

has current_key => ( isa => 'Str', is => 'rw', );

around parse_value_assignment => sub {
    my ( $next, $self ) = splice @_, 0, 2;       # pull these off @_
    if ( my ( $key, $value ) = $self->$next(@_) ) {
        $self->current_key($key);
        return ( $key, $value );
    }
    elsif ( $_[0] =~ /^\s*(\w+)\s*$/ ) {
        return $self->current_key, $1;
    }
    return;
};

no Moose;
1;
__END__
