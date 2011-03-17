# ffmpeg.org HTML generation from source files

SRCS = about bugreports consulting contact documentation download \
       index legal projects shame

TARGETS = $(addsuffix .html,$(addprefix htdocs/,$(SRCS)))

PAGE_DEPS = src/template_head1 src/template_head2 src/template_footer sed_commands


all: $(TARGETS)

clean:
	rm -f $(TARGETS)

htdocs/%.html: src/% src/%_title $(PAGE_DEPS)
	sed -f sed_commands $< | \
	cat src/template_head1 $<_title src/template_head2 - \
	src/template_footer > $@

.PHONY: all clean
