#lang scribble/doc

@(require scribble/manual)

@title{@bold{Unicode Chars}}

@author[(author+email "John Clements" "clements@racket-lang.org")]

@(require (for-label racket
                     "main.rkt"))

@defmodule[unicode]{This package provides definitions for several unicode character 
 properties defined by Unicode Technical Report #44, 
 @link["http://www.unicode.org/reports/tr44/"]{Unicode Character Database}.
 
 Currently, it includes three properties: XID_Start, XID_Continue, and Bidi_Mirrored.
 
 In addition to these, though, it is built upon an auto-extraction mechanism that can
 download and update the given properties or any other binary property from the canonical
 unicode sources.
 
}

@section{Built-in properties}

The following three properties are built-in. Of course, it's easy to change this set....

@defproc[(bidi-mirrored? [codepoint exact-nonnegative-integer?]) boolean?]{
 given a number representing a unicode code point, return @racket[true] when this code point
 has the "Bidi_Mirrored" property.
}

@defproc[(xid-start? [codepoint exact-nonnegative-integer?]) boolean?]{
 given a number representing a unicode code point, return @racket[true] when this code point
 has the "XID_Start" property.
}

@defproc[(xid-continue? [codepoint exact-nonnegative-integer?]) boolean?]{
 given a number representing a unicode code point, return @racket[true] when this code point
 has the "XID_Continue" property.
}

@section{Auto Update}

This package contains code that automatically downloads and extracts updated versions of these
(or other) properties from the canonical database.  

In order to run this auto-update, evaluate the file @filepath["compute-prop.rkt"]. In order to change
the set of properties that is automatically derived, edit the definition of @racket[prop-files]
contained in @filepath["compute-prop.rkt"].
