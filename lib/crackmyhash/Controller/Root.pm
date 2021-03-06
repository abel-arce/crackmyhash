package crackmyhash::Controller::Root;
use Moose;
use namespace::autoclean;
use crackmyhash::Schema;
use Digest::MD5 qw(md5 md5_hex md5_base64);


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
   #my $schema = crackmyhash::Schema->connect('dbi:mysql:dbname=crackmyhash', 'crackmyhash', 'aa062016');
   #my $name_rs = $schema->resultset('User')->find({ id => 1 });
    my ( $self, $c ) = @_;

    # Hello World
    my $ip = $c->request->address;
    $c->stash(template => 'index.tt', ip => $ip);
    #$c->stash->{template} = 'index.tt';
}

=head2 admin
# Admin page
=cut
sub login : Path('login') {              # Admin Page
    my ( $self, $c ) = @_;
    my $epass;    

    my $user = $c->request->params->{email} || 'N/A';
    my $pass = $c->request->params->{pass} || 'N/A';
    
    my $schema = crackmyhash::Schema->connect('dbi:mysql:dbname=crackmyhash', 'crackmyhash', 'aa062016');
    my $name_rs = $schema->resultset('User')->find({ email => $user });
   
    #Admin Page!
    if($name_rs){
	$epass = md5_hex($pass);
	if($name_rs->email eq $user && $name_rs->pass eq $epass){
    		$c->stash(template => 'admin.tt', user => $name_rs->name);
	}else{
		my $ip = $name_rs->pass;
		$c->stash(template => 'index.tt',ip => "Usuario o clave invalida");
	}
    }else{
	#$c->stash(template => 'index.tt', ip => $c->request->address);
	$c->res->redirect('/');
    }
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
