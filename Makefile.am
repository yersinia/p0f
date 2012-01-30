# Makefile for p03f 

ACLOCAL_AMFLAGS = -I m4
AM_CPPFLAGS = -I. -I$(top_srcdir)
AM_CFLAGS = $(P0F_CFLAGS) -I/usr/local/include/ -I/opt/local/include/ 
AM_LDFLAGS = $(P0F_LDFLAGS) -L/usr/local/lib/ -L/opt/local/lib


## begin configmake

# Retrieve values of the variables through 'configure' followed by
# 'make', not directly through 'configure', so that a user who
# sets some of these variables consistently on the 'make' command
# line gets correct results.
#
# One advantage of this approach, compared to the classical
# approach of adding -DLIBDIR=\"$(libdir)\" etc. to AM_CPPFLAGS,
# is that it protects against the use of undefined variables.
# If, say, $(libdir) is not set in the Makefile, LIBDIR is not
# defined by this module, and code using LIBDIR gives a
# compilation error.
#
# Another advantage is that 'make' output is shorter.
#
# Listed in the same order as the GNU makefile conventions.
# The Automake-defined pkg* macros are appended, in the order
# listed in the Automake 1.10a+ documentation.
configmake.h: Makefile
	$(AM_V_GEN)rm -f $@-t && \
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  echo '#define PREFIX "$(prefix)"'; \
	  echo '#define EXEC_PREFIX "$(exec_prefix)"'; \
	  echo '#define BINDIR "$(bindir)"'; \
	  echo '#define SBINDIR "$(sbindir)"'; \
	  echo '#define LIBEXECDIR "$(libexecdir)"'; \
	  echo '#define DATAROOTDIR "$(datarootdir)"'; \
	  echo '#define DATADIR "$(datadir)"'; \
	  echo '#define SYSCONFDIR "$(sysconfdir)"'; \
	  echo '#define SHAREDSTATEDIR "$(sharedstatedir)"'; \
	  echo '#define LOCALSTATEDIR "$(localstatedir)"'; \
	  echo '#define INCLUDEDIR "$(includedir)"'; \
	  echo '#define OLDINCLUDEDIR "$(oldincludedir)"'; \
	  echo '#define DOCDIR "$(docdir)"'; \
	  echo '#define INFODIR "$(infodir)"'; \
	  echo '#define HTMLDIR "$(htmldir)"'; \
	  echo '#define DVIDIR "$(dvidir)"'; \
	  echo '#define PDFDIR "$(pdfdir)"'; \
	  echo '#define PSDIR "$(psdir)"'; \
	  echo '#define LIBDIR "$(libdir)"'; \
	  echo '#define LISPDIR "$(lispdir)"'; \
	  echo '#define LOCALEDIR "$(localedir)"'; \
	  echo '#define MANDIR "$(mandir)"'; \
	  echo '#define MANEXT "$(manext)"'; \
	  echo '#define PKGDATADIR "$(pkgdatadir)"'; \
	  echo '#define P0FDATADIR "$(pkgdatadir)"'; \
	  echo '#define PKGINCLUDEDIR "$(pkgincludedir)"'; \
	  echo '#define PKGLIBDIR "$(pkglibdir)"'; \
	  echo '#define PKGLIBEXECDIR "$(pkglibexecdir)"'; \
	} | sed '/""/d' > $@-t && \
	if test -f $@ && cmp $@-t $@ > /dev/null; then \
	  rm -f $@-t; \
	  touch $@; \
	else \
	  rm -f $@; mv $@-t $@; \
	fi

BUILT_SOURCES = configmake.h
CLEANFILES = configmake.h configmake.h-t

## end configmake

SUBDIRS = . tools

bin_PROGRAMS = p0f
p0f_SOURCES = api.c fp_http.c fp_mtu.c fp_tcp.c p0f.c process.c readfp.c
noinst_HEADERS = alloc-inl.h api.h debug.h fp_http.h fp_mtu.h fp_tcp.h hash.h languages.h p0f.h process.h readfp.h system.h tcp.h types.h

p0fdir = $(pkgdatadir)
dist_p0f_DATA = p0f.fp

EXTRA_DISTS = autogen.sh README-prereq

dist_doc_DATA  = ChangeLog COPYING  README TODO docs/existential-notes.txt docs/extra-sigs.txt
#dist_man_MANS = p03f.3

