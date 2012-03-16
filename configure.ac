#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.63])
AC_INIT([p0f], [3.03c], [lcamtuf@coredump.cx])
AC_CONFIG_SRCDIR([readfp.h])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])

# Must come before AM_INIT_AUTOMAKE.
AC_CONFIG_AUX_DIR([build-aux])
AC_CANONICAL_HOST
AM_INIT_AUTOMAKE([1.11 color-tests -Wall -Werror foreign])

#
AC_COPYRIGHT([Copyright (C) 2012 by Michal Zalewski <lcamtuf@coredump.cx>])

# Checks for programs.
AC_PROG_CC
gl_EARLY
AC_PROG_INSTALL
AC_PROG_MAKE_SET

# Checks for libraries.
AC_MSG_CHECKING([checking for pcap library]) 
LIB_SOCKET_NSL
have_pcap=no
AC_PATH_TOOL(PCAP_CONFIG, pcap-config)
AS_IF([test -n "$PCAP_CONFIG"],
        [
		pcap_cflags=`"$PCAP_CONFIG" --cflags`
		pcap_ldflags=`"$PCAP_CONFIG" --libs`
                p0f_CFLAGS_ADD([$pcap_cflags], [P0F_CFLAGS])
               	p0f_LDFLAGS_ADD([$pcap_ldflags], [P0F_LDFLAGS])
 	 	AC_CHECK_HEADERS([pcap.h], [],
 		[])
	        AC_CHECK_HEADERS([pcap-bpf.h], [],
                [])
        ],
        [
	###############################################################
	# We don't have pcap-config; find out any additional link flags
	# we need.  (If we have pcap-config, we assume it tells us what
	# we need.)
	###############################################################
	case "$host_os" in

	aix*)
	    ############################################################
	    # If libpcap is DLPI-based, we have to use /lib/pse.exp if
	    # present, as we use the STREAMS routines.
	    #
	    # (XXX - true only if we're linking with a static libpcap?)
	    ############################################################
	    #
	    pseexe="/lib/pse.exp"
	    AC_MSG_CHECKING(for $pseexe)
	    if test -f $pseexe ; then
		    AC_MSG_RESULT(yes)
		    pcap_ldflags="-I:$pseexe"
               	    p0f_LDFLAGS_ADD([$pcap_ldflags], [P0F_LDFLAGS])
	    fi

	    #
	    # If libpcap is BPF-based, we need "-lodm" and "-lcfg", as
	    # we use them to load the BPF module.
	    #
	    # (XXX - true only if we're linking with a static libpcap?)
	    #
	    pcap_ldflags="-lodm -lcfg"
            p0f_LDFLAGS_ADD([$pcap_ldflags], [P0F_LDFLAGS])
 	    AC_CHECK_HEADERS([pcap.h], [],
 		[])
	    AC_CHECK_HEADERS([pcap-bpf.h], [], [])
	    ;;
        *)
	AC_SEARCH_LIBS([pcap_findalldevs], [pcap],
	  [have_pcap=yes])
	AS_IF([test "x${have_pcap}" = xno],
	      [ AC_SEARCH_LIBS([pcap_findalldevs], [wpcap],
	      [have_pcap=yes])
	      AS_IF([test "x${have_pcap}" = xyes],
	            [
 	 		AC_CHECK_HEADERS([pcap.h], [],
 		        [have_pcap=no])
	                AC_CHECK_HEADERS([pcap-bpf.h], [],
	                [have_pcap=no])
	                AS_IF([test "x${have_pcap}" = xno],
	                      [AC_MSG_ERROR([pcap library don't found])]
	                )
	            ],
	            [AC_MSG_ERROR([pcap library don't found])]
	      )
	      ]
	)
        ;;
	esac
        ]
)

# 
# Check for gnulib flock replacement
#
gl_FUNC_FLOCK
if test $HAVE_FLOCK = 0; then
AC_LIBOBJ([flock])
gl_PREREQ_FLOCK
fi
gl_HEADER_SYS_FILE_MODULE_INDICATOR([flock])



# build and distribuite the optional p0f tools
AC_ARG_ENABLE([build-p0f-tools],
  [AS_HELP_STRING([--enable-build-p0f-tools],
                  [build with the auxiliary p0f tools(@<:@default=no@:>@)])],
  [case $enableval in
     yes|no) ;;
     *)      AC_MSG_ERROR([bad value $enableval for build-p0f-tools option]) ;;
   esac
   build_p0f_tools=$enableval],
  [build_p0f_tools=no]
)
AM_CONDITIONAL([BUILD_P0F_TOOLS],[test "$build_p0f_tools" = "yes"])


AC_ARG_ENABLE([debug],
  [AS_HELP_STRING([--enable-gcc-debug],
                  [turn on GCC debugging options  (for developers)@<:@default=no@:>@])],
  [case $enableval in
     yes|no) ;;
     *)      AC_MSG_ERROR([bad value $enableval for gcc-debug option]) ;;
   esac
   p0f_gcc_debug=$enableval],
  [p0f_gcc_debug=no]
)

AS_IF([test "x$p0f_gcc_debug" = xyes],
  [ 
  p0f_CFLAGS_ADD([-g], [P0F_CFLAGS])
  p0f_CFLAGS_ADD([-ggdb], [P0F_CFLAGS])
  ])


# Turn gcc warning

AC_ARG_ENABLE([gcc-warnings],
  [AS_HELP_STRING([--enable-gcc-warnings],
                  [turn on GCC warnings (for developers)@<:@default=no@:>@])],
  [case $enableval in
     yes|no) ;;
     *)      AC_MSG_ERROR([bad value $enableval for gcc-warnings option]) ;;
   esac
   p0f_gcc_warnings=$enableval],
  [p0f_gcc_warnings=no]
)

AS_IF([test "x$p0f_gcc_warnings" = xyes],
  [ # Add/Delete as needed
  p0f_CFLAGS_ADD([-Wall], [P0F_CFLAGS])
  p0f_CFLAGS_ADD([-pedantic], [P0F_CFLAGS])
  p0f_CFLAGS_ADD([-Wextra], [P0F_CFLAGS])
  p0f_CFLAGS_ADD([-Wformat-y2k], [P0F_CFLAGS])
  p0f_CFLAGS_ADD([-fdiagnostics-show-option],[P0F_CFLAGS])
  p0f_CFLAGS_ADD([-funit-at-a-time],[P0F_CFLAGS])
  p0f_CFLAGS_ADD([-fstrict-aliasing],[P0F_CFLAGS])
  p0f_CFLAGS_ADD([-Wstrict-overflow],[P0F_CFLAGS])
  p0f_CFLAGS_ADD([-fstrict-overflow],[P0F_CFLAGS])
  p0f_CFLAGS_ADD([-Wpointer-arith],[P0F_CFLAGS])
  p0f_CFLAGS_ADD([-Wno-format],[P0F_CFLAGS])
  ])


# build p0f with mudflap instrumentation (GCC only)
p0f_gcc_mudflap=no
AC_ARG_ENABLE([mudflap],
 [AS_HELP_STRING([--enable-mudflap],
                  [build P0F with mudflap instrumentation (@<:@default=no@:>@) (with GCC only) (EXPERIMENTAL)])],
 [case $enableval in
     yes|no) ;;
     *)      AC_MSG_ERROR([bad value $enableval for mudflap option]) ;;
   esac
   p0f_gcc_mudflap=$enableval],
[ p0f_gcc_mudflap=no ])

AS_IF([ test x"$p0f_gcc_mudflap" = x"yes" ], 
  [
        AS_IF([test "x$GCC" != x],
              [ 
		old_CFLAGS="$CFLAGS"
		CFLAGS="$CFLAGS -fmudflap"
		old_LDFLAGS="$LDFLAGS"
		LDFLAGS="$LDFLAGS -lmudflap"
		AC_LINK_IFELSE([AC_LANG_PROGRAM([[]], [[]])],[p0f_gcc_mudflap=yes],[p0f_gcc_mudflap=fail])
		CFLAGS="$old_CFLAGS"
		LDFLAGS="$old_LDFLAGS"
		AS_IF([ test "$p0f_gcc_mudflap" = fail ],
                      [
 	  	       AC_MSG_WARN([--enable-mudflap requires a compiler which understands this option.])
                      ],
                      [
                        p0f_CFLAGS_ADD([-fmudflap], [P0F_CFLAGS])
                	p0f_LDFLAGS_ADD([-lmudflap], [P0F_LDFLAGS])
                        # XXX: memory leak ?
                        #MUDFLAP_OPTIONS="-mode-check -abbreviate -viol-abort -check-initialization -print-leaks"
                        MUDFLAP_OPTIONS="-mode-check -abbreviate -check-initialization"
			AC_SUBST([MUDFLAP_OPTIONS])
                      ])
              ],
              [ AC_MSG_WARN([--enable-mudflap requires GCC])]
        )
  ])
     

# build p0f instrumented for -fPIE (GCC only)
AC_ARG_ENABLE([build-pie],
  [AS_HELP_STRING([--enable-build-pie],
                  [build p0f as Position Independent Executable (PIE) (@<:@default=yes@:>@ with GCC only)])],
  [case $enableval in
     yes|no) ;;
     *)      AC_MSG_ERROR([bad value $enableval for build-pie option]) ;;
   esac
   p0f_gcc_pie=$enableval],
  [p0f_gcc_pie=yes]
)
AS_IF([test "x$p0f_gcc_pie" = xyes],
  [
        AS_IF([test "x$GCC" != x],
              [ p0f_CFLAGS_ADD([-fpie], [P0F_CFLAGS])
                p0f_LDFLAGS_ADD([-pie], [P0F_LDFLAGS])
              ],
              [ AC_MSG_WARN([--enable-build-pie requires GCC])]
        )
   ])


# build p0f instrumented for extra optimization/security (GCC only)
# -fno-delete-null-pointer as the kernel does http://patchwork.kernel.org/patch/36060/
# add relro 
# GNU GCC (usually "gcc")
AS_IF([test "x$GCC" != x],
 [ for c in -fno-delete-null-pointer-checks -D_FORTIFY_SOURCE=2 -fstack-protector -fexceptions -fstack-protector-all 
   do
  	p0f_CFLAGS_ADD([$c], [P0F_CFLAGS])
   done
   p0f_LDFLAGS_ADD([-Wl,-z,relro], [P0F_LDFLAGS])
 ])

# Finally put an AC_SUBST for all the CFLAGS and LDFLAGS above
AC_SUBST([POPT_LDFLAGS])
AC_SUBST([P0F_CFLAGS])

# Checks for header files.
AC_CHECK_HEADERS([arpa/inet.h getopt.h limits.h locale.h netdb.h sys/file.h netinet/in.h stdint.h stdlib.h string.h sys/socket.h net/bpf.h sys/time.h unistd.h])

# for gnulib
gl_INIT

# Checks for typedefs, structures, and compiler characteristics.
AC_C_INLINE
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_INT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_TYPE_UINT8_T

# Checks for library functions.
AC_CHECK_FUNCS([fork malloc mktime realloc dup2 memmove memset setlocale socket strcasecmp strchr strncasecmp strstr tzset])

AC_CONFIG_FILES([Makefile
                 tools/Makefile
                 lib/Makefile])
AC_OUTPUT
