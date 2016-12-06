package crackmyhash::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

crackmyhash::Controller::Root - Root Controller for crackmyhash

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) { 		# HOME
    my ( $self, $c ) = @_;

    # Hello World
    my $ip = $c->request->address;
    $c->stash(template => 'index.tt', ip => $ip);
}

=head2 admin
# Admin page
=cut
sub admin : Path('admin') {              # Admin Page
    my ( $self, $c ) = @_;

    #Admin Page!
    $c->stash(template => 'admin.tt');
}     

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
