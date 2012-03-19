# Makefile for p0f 

ACLOCAL_AMFLAGS = -I m4
AM_CPPFLAGS = -I. -I$(top_srcdir)
AM_CFLAGS = $(P0F_CFLAGS)

if BUILD_P0F_TOOLS

bin_PROGRAMS = p0f-client p0f-sendsyn6  p0f-sendsyn
p0f_client_SOURCES   = p0f-client.c
p0f_sendsyn6_SOURCES = p0f-sendsyn6.c
p0f_sendsyn_SOURCES  = p0f-sendsyn.c

EXTRA_DIST = README-TOOLS

endif

