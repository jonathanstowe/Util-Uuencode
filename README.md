# Util::Uuencode

uuencode/uudecode for Raku

![Build Status](https://github.com/jonathanstowe/Util-Uuencode/workflows/CI/badge.svg)

## Synopsis

   use Util::Uuencode;

   my $image = "some-image.jpg".IO.slurp(:bin);

   my $encoded = uuencode($image);

   # now $encoded can be sent or stored as text safely

   $image = uudecode($encoded);

   # now have the image back as binary

## Description

[uuencode](https://en.wikipedia.org/wiki/Uuencoding) is a binary to text encoding mechanism designed for sending binary files across computer boundaries where the transport mechanism may not be 8 bit clean, such as e-mail, usenet or uucp. It has largely been obsoleted by MIME (and Base64 encoding,) and the advent of ubiquitous 8 bit clean networking.

This module provides routines for uuencoding (`uuencode`) and decoding (`uudecode`) which will round trip data between binary and text encoded representations. `uuencode` will quite happily encode plain text but as the effect is to make it a third larger there isn't much point doing that ( I guess at a push it could be used to preserve some unicode encoding across some boundary that doesn't deal with that well.)

The  POSIX commands [uuencode and uudecode](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/uuencode.html) expect some additional header and trailer information which this module doesn't deal with, so if you expect your data to be processed by these tools you will need to add this to your encoded output and remove it from the input for correct processing.

## Installation

Assuming you have a working Rakudo installation then this can be installed by `zef` :

    zef install Util::Uuencode

    # Or from a local clone

    zef install .

There are no depenencies.

## Support

This is one of those things that either works or it doesn't but if you have a problem or suggestions please report them on [Github](https://github.com/jonathanstowe/Util-Uuencode/issues).

## Licence

This is free software.

Please see the [LICENCE](LICENCE) file in the distribution.

© Jonathan Stowe 2020

