# ffmpeg.org HTML generation from source files

SRCS = about bugreports consulting contact donations documentation download \
       olddownload index legal projects shame security archive

TARGETS = $(addsuffix .html,$(addprefix htdocs/,$(SRCS))) htdocs/main.rss

PAGE_DEPS = src/template_head1 src/template_head2 src/template_footer


all: $(TARGETS)

clean:
	rm -f $(TARGETS)

htdocs/%.html: src/% src/%_title $(PAGE_DEPS)
	cat src/template_head1 $<_title src/template_head2 $< \
	src/template_footer > $@

htdocs/main.rss: htdocs/index.html htdocs/archive.html
	./rss-gen.sh start $@
	$(foreach html, $^, ./rss-gen.sh middle $@ $(html);)
	./rss-gen.sh end   $@

.PHONY: all clean
