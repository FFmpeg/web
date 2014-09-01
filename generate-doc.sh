#!/bin/sh
#
# Copyright (c) 2014 Tiancheng "Timothy" Gu.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
# OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

die() {
    echo $1
    exit 1
}

if [ $# != 1 ]; then
    die "Usage: $0 <ffmpeg-source>"
fi

src=$1
current_dir=$(pwd)

export FFMPEG_HEADER1="$(cat src/template_head1)"
export FFMPEG_HEADER2="$(cat src/template_head_prod src/template_head2)"
export FFMPEG_HEADER3="$(cat src/template_head3)"
export FFMPEG_FOOTER="$(cat src/template_footer1 src/template_footer_prod src/template_footer2)"

rm -rf build-doc
mkdir build-doc && cd build-doc
$src/configure --enable-gpl --disable-yasm || die "configure failed"
make doc || die "doc not made"
cp doc/*.html ../htdocs/ || die "copy failed"

cd ..
rm -rf build-doc