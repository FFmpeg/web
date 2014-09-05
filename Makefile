# ffmpeg.org HTML generation from source files

SRCS = about bugreports consulting contact donations documentation download \
       olddownload index legal shame security archive

HTML_TARGETS  = $(addsuffix .html,$(addprefix htdocs/,$(SRCS)))

RSS_FILENAME = main.rss
RSS_TARGET = htdocs/$(RSS_FILENAME)

CSS_SRCS = src/less/style.less
CSS_TARGET = htdocs/css/style.min.css
LESS_TARGET = htdocs/style.less
LESSC_OPTIONS := --clean-css

BOWER_PACKAGES = bower.json
BOWER_COMPONENTS = htdocs/components

ifdef DEV
SUFFIX = dev
TARGETS = $(BOWER_COMPONENTS) $(LESS_TARGET) $(HTML_TARGETS) $(RSS_TARGET)
else
SUFFIX = prod
TARGETS = $(HTML_TARGETS) $(CSS_TARGET) $(RSS_TARGET)
endif

DEPS = src/template_head1 src/template_head2 src/template_head3 src/template_head_$(SUFFIX) \
       src/template_footer1 src/template_footer2 src/template_footer_$(SUFFIX)

all: htdocs

htdocs: $(TARGETS)

htdocs/%.html: src/% src/%_title src/%_js $(DEPS)
	cat src/template_head1 $<_title src/template_head_$(SUFFIX) \
	src/template_head2 $<_title src/template_head3 $< \
	src/template_footer1 src/template_footer_$(SUFFIX) $<_js src/template_footer2 > $@

$(RSS_TARGET): htdocs/index.html
	echo '<?xml version="1.0" encoding="UTF-8" ?>' > $@
	echo '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">' >> $@
	echo '<channel>' >> $@
	echo '    <title>FFmpeg RSS</title>' >> $@
	echo '    <link>http://ffmpeg.org</link>' >> $@
	echo '    <description>FFmpeg RSS</description>' >> $@
	echo '    <atom:link href="http://ffmpeg.org/main.rss" rel="self" type="application/rss+xml" />' >> $@
	awk '/<a *id=".*" *> *<\/a> *<h3>.*20.., *.*<\/h3>/ { p = 1 } /<h1>Older entries are in the .*news archive/ { p = 0 } p' $< \
        | sed 'sX<a *id="\(.*\)" *> *</a> *<h3>\(.*20..\), *\(.*\)</h3>X\
        ]]></content:encoded>\
    </item>\
    <item>\
        <title>\2, \3</title>\
        <link>http://ffmpeg.org/index.html#\1</link>\
        <guid>http://ffmpeg.org/index.html#\1</guid>\
        <content:encoded><![CDATA[X' \
	| awk 'NR > 3' >> $@
	echo '        ]]></content:encoded>' >> $@
	echo '    </item>' >> $@
	echo '</channel>' >> $@
	echo '</rss>' >> $@

$(BOWER_COMPONENTS): $(BOWER_PACKAGES)
	bower install
	cp -r $(BOWER_COMPONENTS)/font-awesome/fonts htdocs/
	cp $(BOWER_COMPONENTS)/font-awesome/css/font-awesome.min.css htdocs/css/
	cp $(BOWER_COMPONENTS)/bootstrap/dist/css/bootstrap.min.css htdocs/css/
	cp $(BOWER_COMPONENTS)/bootstrap/dist/js/bootstrap.min.js htdocs/js/
	cp $(BOWER_COMPONENTS)/jquery/dist/jquery.min.js htdocs/js/

$(CSS_TARGET): $(CSS_SRCS)
	lessc $(LESSC_OPTIONS) $(CSS_SRCS) > $@

$(LESS_TARGET): $(CSS_SRCS)
	ln -sf $(CSS_SRCS) $@

clean:
	$(RM) -r $(TARGETS)

.PHONY: all clean
