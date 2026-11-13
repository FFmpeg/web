<!-- This file is passed to all stages: triage, draft reviews, combining, vetting and issue investigation. Use it only for facts that are true for all of them, not for instructions specific to a subset. -->
<!-- The file is always read from the default branch, not from the pull request head: this avoids prompt injection and applies the latest facts to old branches too. -->
##FFmpeg website (ffmpeg-web) project facts:

This repository is the source of the https://ffmpeg.org website.
Pages are assembled by ``make``: each page is src/<name> (HTML body) plus src/<name>_title and src/<name>_js, concatenated with the shared src/template_* files into htdocs/<name>.html.
CSS comes from src/less/style.less, compiled with ``lessc --clean-css`` into htdocs/css/style.min.css; lessc and clean-css are required to build. ``make DEV=1`` builds the development variant (needs bower).
The RSS feed htdocs/main.rss is generated from the news entries in src/index; news entries are <h3 id="..."> headings there and the feed generation depends on that exact shape.
The documentation pages are NOT in this repository and are not part of the generated site; they are generated from the main FFmpeg source tree with generate-doc.sh.
After a major CSS update, htdocs/css/bootstrap.min.css and htdocs/css/style.min.css must also be copied into the main FFmpeg repository's doc/ directory, or the two drift apart.
src/security is the security page listing the CVEs fixed in each release; entries are appended per release and accuracy matters.
