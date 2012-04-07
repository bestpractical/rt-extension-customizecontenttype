use warnings;
use strict;

package RT::Extension::CustomizeContentType;

our $VERSION = "0.01";
use RT::Attachment;

package RT::Attachment;

sub ContentType {
    my $self = shift;

    my $content_type = $self->_Value('ContentType');
    return $content_type unless $content_type;

    return $content_type
      unless $self->Filename && $self->Filename =~ /\.(\w+)$/;
    my $ext    = $1;

    my $config = RT->Config->Get('ContentTypes') or return $content_type;
    return $config->{$ext} || $content_type;
}

1;
__END__

=head1 NAME

RT::Extension::CustomizeContentType - Customize Attachments' ContentType

=head1 VERSION

Version 0.01

=head1 INSTALLATION

To install this module, run the following commands:

    perl Makefile.PL
    make
    make install

add RT::Extension::CustomizeContentType to @Plugins in RT's etc/RT_SiteConfig.pm:

    Set( @Plugins, qw(... RT::Extension::CustomizeContentType) );
    Set(
        %ContentTypes,
        (
            't'    => 'text/x-perl-script',
            'psgi' => 'text/x-perl-script',
        )
    );

=head1 AUTHOR

sunnavy, <sunnavy at bestpractical.com>


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Best Practical Solutions, LLC.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

