# p0f.m4 serial 1
dnl Copyright (C) Elia Pinto (yersinia.spiros@gmail.org)
dnl Inspired from gnulib warning.m4 and other
dnl but not from ac_archive 


# p0f_AS_VAR_APPEND(VAR, VALUE)
# ----------------------------
# Provide the functionality of AS_VAR_APPEND if Autoconf does not have it.
m4_ifdef([AS_VAR_APPEND],
[m4_copy([AS_VAR_APPEND], [p0f_AS_VAR_APPEND])],
[m4_define([p0f_AS_VAR_APPEND],
[AS_VAR_SET([$1], [AS_VAR_GET([$1])$2])])])

# p0f_CFLAGS_ADD(PARAMETER, [VARIABLE = P0F_CFLAGS])
# ------------------------------------------------
# Adds parameter to P0F_CFLAGS if the compiler supports it.  For example,
# p0f_CFLAGS_ADD([-Wall],[P0F_CFLAGS]).
AC_DEFUN([p0f_CFLAGS_ADD],
[AS_VAR_PUSHDEF([p0f_my_cflags], [p0f_cv_warn_$1])dnl
AC_CACHE_CHECK([whether compiler handles $1], [p0f_my_cflags], [
  save_CFLAGS="$CFLAGS"
  CFLAGS="${CFLAGS} $1"
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],
                    [AS_VAR_SET([p0f_my_cflags], [yes])],
                    [AS_VAR_SET([p0f_my_cflags], [no])])
  CFLAGS="$save_CFLAGS"
])
AS_VAR_PUSHDEF([p0f_cflags], m4_if([$2], [], [[P0F_CFLAGS]], [[$2]]))dnl
AS_VAR_IF([p0f_my_cflags], [yes], [p0f_AS_VAR_APPEND([p0f_cflags], [" $1"])])
AS_VAR_POPDEF([p0f_cflags])dnl
AS_VAR_POPDEF([p0f_my_cflags])dnl
m4_ifval([$2], [AS_LITERAL_IF([$2], [AC_SUBST([$2])], [])])dnl
])

# p0f_LDFLAGS_ADD(PARAMETER, [VARIABLE = P0F_LDFLAGS])
# ------------------------------------------------
# Adds parameter to P0F_LDFLAGS if the compiler supports it.  For example,
# p0f_LDFLAGS_ADD([-Wall],[P0F_LDFLAGS]).
AC_DEFUN([p0f_LDFLAGS_ADD],
[AS_VAR_PUSHDEF([p0f_my_ldflags], [p0f_cv_warn_$1])dnl
AC_CACHE_CHECK([whether compiler handles $1], [p0f_my_ldflags], [
  save_LDFLAGS="$LDFLAGS"
  LDFLAGS="${LDFLAGS} $1"
  AC_LINK_IFELSE([AC_LANG_PROGRAM([])],
                    [AS_VAR_SET([p0f_my_ldflags], [yes])],
                    [AS_VAR_SET([p0f_my_ldflags], [no])])
  LDFLAGS="$save_LDFLAGS"
])
AS_VAR_PUSHDEF([p0f_ldflags], m4_if([$2], [], [[P0F_LDFLAGS]], [[$2]]))dnl
AS_VAR_IF([p0f_my_ldflags], [yes], [p0f_AS_VAR_APPEND([p0f_ldflags], [" $1"])])
AS_VAR_POPDEF([p0f_ldflags])dnl
AS_VAR_POPDEF([p0f_my_ldflags])dnl
m4_ifval([$2], [AS_LITERAL_IF([$2], [AC_SUBST([$2])], [])])dnl
])



