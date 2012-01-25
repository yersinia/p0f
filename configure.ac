#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.63])
AC_INIT([p0f], [3.03b], [lcamtuf@coredump.cx])
AC_CONFIG_SRCDIR([readfp.h])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])

# Must come before AM_INIT_AUTOMAKE.
AC_CONFIG_AUX_DIR([build-aux])
AC_CANONICAL_HOST
AM_INIT_AUTOMAKE([1.11 color-tests -Wall -Werror foreign])

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_MAKE_SET

# Checks for libraries.
have_pcap=no
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
            [AC_MSG_ERROR([pcap library don't found
i                          hheheh
                          ])]
      )
      ]
)

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
# GNU GCC (usually "gcc")
AS_IF([test "x$GCC" != x],
 [ for c in -fno-delete-null-pointer-checks -D_FORTIFY_SOURCE=2 -fstack-protector -fexceptions -fstack-protector-all 
   do
  	p0f_CFLAGS_ADD([$c], [P0F_CFLAGS])
   done
 ])

# Finally put an AC_SUBST for all the CFLAGS and LDFLAGS above
AC_SUBST([POPT_LDFLAGS])
AC_SUBST([P0F_CFLAGS])

# Checks for header files.
AC_CHECK_HEADERS([arpa/inet.h locale.h netdb.h netinet/in.h stdint.h stdlib.h string.h sys/file.h sys/socket.h sys/time.h unistd.h])

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
                 tools/Makefile])
AC_OUTPUT
