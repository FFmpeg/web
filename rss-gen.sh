#!/bin/sh

die() {
    cat <<EOT >&2
Usage: $0 <mode> <htdocs/output.rss> [<input.html>]

This utility parses & converts generated FFmpeg news HTML page into RSS format.
"mode" can be begin, middle, or end. If mode is middle, then input HTML is
required.
EOT
    exit 1
}

# Sanity checks and parsing command line

MODE=$1
RSS=$2
HTML=$3

HTML_NODIR=${HTML##*/}

if test $# -lt 2; then
    echo 'Too few arguments' >&2
    die
elif test $# -gt 3; then
    echo 'Too many arguments' >&2
    die
elif test $MODE = "middle" && test $# -ne 3; then
    echo 'No HTML specified' >&2
    die
fi

if test $MODE = "start"; then
    cat << EOT > $RSS
<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
    <title>FFmpeg RSS</title>
    <link>http://ffmpeg.org</link>
    <description>FFmpeg RSS</description>
    <atom:link href="http://ffmpeg.org/main.rss" rel="self" type="application/rss+xml" />
EOT
elif test $MODE = "middle"; then
    grep '<a *id=".*" *></a><h3>.*20..,.*</h3>' $HTML | sed 'sX<a *id="\(.*\)" *> *</a> *<h3>\(.*20..\), *\(.*\)</h3>X\
    <item>\
        <title>\2, \3</title>\
        <link>http://ffmpeg.org/'$HTML_NODIR'#\1</link>\
        <guid>http://ffmpeg.org/'$HTML_NODIR'#\1</guid>\
    </item>\
X' >> $RSS
elif test $MODE = "end"; then
    cat << EOT >> $RSS
</channel>
</rss>
EOT
else
    echo 'Unknown mode' >&2
    die
fi
