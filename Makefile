# ffmpeg.org HTML generation from source files

SRCS = about bugreports consulting contact donations documentation download \
       index legal projects shame security archive

TARGETS = $(addsuffix .html,$(addprefix htdocs/,$(SRCS))) htdocs/main.rss

PAGE_DEPS = src/template_head1 src/template_head2 src/template_footer


all: $(TARGETS)

clean:
	rm -f $(TARGETS)

htdocs/%.html: src/% src/%_title $(PAGE_DEPS)
	cat src/template_head1 $<_title src/template_head2 $< \
	src/template_footer > $@

htdocs/main.rss: htdocs/index.html
	echo '<?xml version="1.0" encoding="UTF-8" ?>' > $@
	echo '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' >> $@
	echo '<channel>' >> $@
	echo '    <title>FFmpeg RSS</title>' >> $@
	echo '    <link>http://ffmpeg.org</link>' >> $@
	echo '    <description>FFmpeg RSS</description>' >> $@
	echo '    <atom:link href="http://ffmpeg.org/main.rss" rel="self" type="application/rss+xml" />' >> $@
	grep '<a *id=".*" *></a><h3>.*20..,.*</h3>' $< | sed 'sX<a *id="\(.*\)" *> *</a> *<h3>\(.*20..\), *\(.*\)</h3>X\
    <item>\
        <title>\2, \3</title>\
        <link>http://ffmpeg.org/index.html#\1</link>\
        <guid>http://ffmpeg.org/index.html#\1</guid>\
    </item>\
X' >> $@
	echo '</channel>' >> $@
	echo '</rss>' >> $@


.PHONY: all clean
