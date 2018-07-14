ffmpeg.org official website


GENERATE THE WEBSITE
--------------------

`lessc` is required to generate CSS of the website.[1]

Type `make` to generate the website.
Type `make clean` to remove the generated files.


GENERATE THE DOCUMENTATION
--------------------------

/!\ None of the generated versions of the website contain the documentation.

To generate the documentation pages, just `./generate-doc.sh <ffmpeg-src>`.

In case of a major CSS update, please also update the `style.min.css` file in
the main FFmpeg repo
  $ cp htdocs/css/{bootstrap.min.css,style.min.css} /path/to/ffmpeg/doc/



WEBSITE DEVELOPERS INSTRUCTIONS
-------------------------------

npm, lessc and bower are required to generate the website in development.[2]

Type `make DEV=1` to generate the website for development.
Type `make clean DEV=1` to remove the generated files.

In development mode, the external dependencies are downloaded through bower.

Thanks to lessc, you can edit the *.less sources and see the changes on your
browser without having to reload it.


-----

[1] lessc is available on the packages of some distributions.
Otherwise, follow the instructions in [2].
lessc depends on lots of stuff including npm, so if you wish to use a lighter version,
you might want to check out the C++ version: http://www.vanderkroef.net/clessc.html

[2] Install instructions, 2 methods:

- Install everything globally (root required)
  - Install npm from the packages or the sources: http://nodejs.org/
  - Install lessc and bower using npm:
    $ sudo npm install -g bower less

- Install only npm globally
  - Install npm from the packages or the sources: http://nodejs.org/
  - Install lessc and bower in the current directory using npm:
    $ npm install bower less
  - Add the path to your environment:
    $ export PATH=`pwd`/node_modules/bower/bin:`pwd`/node_modules/less/bin:$PATH
