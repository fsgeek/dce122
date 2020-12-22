# Environment notes for building

The documentation doesn't really mention that there are a set of environment variables that need to be set.  They DO list some of these, but
not all of them.  I'm capturing this (informally) here; eventually, this should probably be scripted or added in the configuration or something.

## Documented
USER=tony
HOME=/home/tony
DEFTOOLBASE=/home/tony/projects/dce122/dce/tools/386bsd/bin
TARGET_SYS=386bsd
PATH=/home/tony/projects/dce122/ode/ode/tools/386bsd/bin:/home/tony/.local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/home/tony/bin
NO_RCS=1

Note that the PATH should be wherever the ODE tools have been installed; I suspect it will need to be changed to also point to wherever the dce tools are installed as well.

The NO_RCS is really just for building ODE.

# Not documented

target_machine=386bsd
NLSPATH=/usr/share/nls
TARGET_MACHINE=386bsd
context=386bsd
TARGET_OS=BSD

These values seem to be used as part of the configuration.  Since I'm just trying to get this to work, I don't really care WHAT they are - the goal here is to build _just enough_ that I can extract the bits and pieces that I want.

# Changes I've made during porting

I've mostly changed things so they build.  20+ year old code is crufty...

## GLUE

I ran into this with ODE.  It's one of the tool changes over the past 20+ years.  It seems that it was related to shared libraries.  I've just removed it and (so far) things seem to be working "as expected".

In this case I found it in four places:

```
src/lbe/mk/osf.dce.mk:357:_PICLIB_=-pic-lib ${_GENLIB_} ${_CC_LIBDIRS_} ${_LIBS_}
src/test/rpc/idl/maketest.mk:97:IDL_CC_OPT      = -cc_opt "${CFLAGS} ${_CC_OL_} -pic-lib -L/usr/shlib -ldce"
src/test/rpc/rtandidl/moretests/Makefile:401:IDL_CC_OPT      = -cc_opt "${CFLAGS} -pic-lib -L/usr/shlib -ldce"
src/test/systest/rpc/rpc.runtime.1/Makefile:122:IDL_CC_OPT      = -cc_opt "${CFLAGS} ${_CC_OL_} -pic-lib -L/usr/shlib -ldce"
```

My immediate solution is to just remove that option.

Original lines (dce/src/lbe/mk/osf.dce.mk):

``
_PICLIB_=-pic-lib ${_GENLIB_} ${_CC_LIBDIRS_} ${_LIBS_}
_GLUE_=-%ld," -warn_nopic -glue"
``

(there's a conditional for HPUX, which I've removed)

Now:

```
_SHCCDEFS_=-D_SHARED_LIBRARIES
_PICLIB_= ${_GENLIB_} ${_CC_LIBDIRS_} ${_LIBS_}
_GLUE_=
```

## Compilation

Compilers have become much fussier in the past couple decades.  Go figure.

For example:

```
../../../../../src/directory/cds/control/prs.c:3235:7: error: non-void function 'add_string' should return a value [-Wreturn-type]
                return;
```

In fact, this usually means the function should be void.  Older compilers were more tolerant of sloppiness.  I just fix these.

### IDL

This required a number of changes - types that just aren't defined, that sort of thing.

```
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:290:1: error: unknown type name 'Porting'
Porting Message:  You must provide definitions for the symbols
^
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:290:16: error: expected ';' after top level declarator
Porting Message:  You must provide definitions for the symbols
               ^
               ;
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:290:19: error: unknown type name 'You'
Porting Message:  You must provide definitions for the symbols
                  ^
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:290:27: error: expected ';' after top level declarator
Porting Message:  You must provide definitions for the symbols
                          ^
                          ;
In file included from ../../../../../src/rpc/idl/idl_compiler/acf.y:141:
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/nidl.h:139:9: error: unknown type name 'unsigned8'; did you mean 'unsigned'?
typedef unsigned8 boolean;
        ^~~~~~~~~
        unsigned
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/nidl.h:156:5: error: unknown type name 'unsigned8'; did you mean 'unsigned'?
    unsigned8       clock_seq_hi_and_reserved;
    ^~~~~~~~~
    unsigned
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/nidl.h:157:5: error: unknown type name 'unsigned8'; did you mean 'unsigned'?
    unsigned8       clock_seq_low;
    ^~~~~~~~~
    unsigned
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/nidl.h:158:5: error: unknown type name 'unsigned8'; did you mean 'unsigned'?
    unsigned8       node[6];
    ^~~~~~~~~
    unsigned
```

I made this build once before, but this time I'm going to try and find a way to define the flags properly, which should make doing all the other bits "easier" as well... famous last words.

There are multiple levels at which switches like this are defined.  For example, there is a rule that says:

```
.if exists(${TARGET_MACHINE}/machdep.mk)
.include "${TARGET_MACHINE}/machdep.mk"
.endif
```

(dce/src/dce/Makefile).

But this is invoked in every directory where something is built; it's not about global options.  Globally, there seems to be one header file that controls this: `dce.h`.  Look in dce/src/dce/**ARCH** and you can find a header file there.  Perhaps that's the right way to fix some of these issues?

Just like with `compile_et` (described below) I ended up just making this use specfic definitions.  The actual yacc grammar is likely 30+ years old, since it was inherited from Apollo Computer's work.  The parser is constructed to be re-entrant, but not pure, and thus is dependent on the template used.  It _should_ be possible to build this as a pure grammar, which allows re-entrancy, withouth the hacky code.  That's the path I'm heading down now, but of course that's not going to be painless.

I'm now at the point where I'm colliding on the existing re-entrant bits.

Fixing this is going to be a bit of a project.  I think the _right_ way to fix it is convert to a pure parser model, which would eliminate the need for the re-entrancy.  There are four shift-reduce conflicts:

```
nidl.y: warning: 4 shift/reduce conflicts [-Wconflicts-sr]
```

I generated a detailed machine output, showing the source of the conflicts:

```
State 40 conflicts: 2 shift/reduce
State 91 conflicts: 2 shift/reduce
```

And the detail for State 40:

```
State 40

   11 interface_body: optional_imports . exports extraneous_semi

    error       shift, and go to state 63
    CONST_KW    shift, and go to state 64
    TYPEDEF_KW  shift, and go to state 65
    LBRACKET    shift, and go to state 5

    error        [reduce using rule 197 (attributes)]
    BYTE_KW      reduce using rule 197 (attributes)
    CHAR_KW      reduce using rule 197 (attributes)
    CONST_KW     [reduce using rule 197 (attributes)]
    ENUM_KW      reduce using rule 197 (attributes)
    FLOAT_KW     reduce using rule 197 (attributes)
    HYPER_KW     reduce using rule 197 (attributes)
    INT_KW       reduce using rule 197 (attributes)
    LONG_KW      reduce using rule 197 (attributes)
    PIPE_KW      reduce using rule 197 (attributes)
    SMALL_KW     reduce using rule 197 (attributes)
    STRUCT_KW    reduce using rule 197 (attributes)
    UNION_KW     reduce using rule 197 (attributes)
    UNSIGNED_KW  reduce using rule 197 (attributes)
    SHORT_KW     reduce using rule 197 (attributes)
    VOID_KW      reduce using rule 197 (attributes)
    DOUBLE_KW    reduce using rule 197 (attributes)
    BOOLEAN_KW   reduce using rule 197 (attributes)
    HANDLE_T_KW  reduce using rule 197 (attributes)
    STATIC_KW    reduce using rule 197 (attributes)
    IDENTIFIER   reduce using rule 197 (attributes)

    exports           go to state 66
    export            go to state 67
    const_dcl         go to state 68
    type_dcl          go to state 69
    operation_dcl     go to state 70
    attribute_opener  go to state 71
    attributes        go to state 72
```

It looks like error and CONST_KW are the conflicts for this rule.  For Rule 91:

```
State 91

   11 interface_body: optional_imports exports extraneous_semi .
   23 exports: exports extraneous_semi . export

    error       shift, and go to state 63
    CONST_KW    shift, and go to state 64
    TYPEDEF_KW  shift, and go to state 65
    LBRACKET    shift, and go to state 5

    error        [reduce using rule 197 (attributes)]
    BYTE_KW      reduce using rule 197 (attributes)
    CHAR_KW      reduce using rule 197 (attributes)
    CONST_KW     [reduce using rule 197 (attributes)]
    ENUM_KW      reduce using rule 197 (attributes)
    FLOAT_KW     reduce using rule 197 (attributes)
    HYPER_KW     reduce using rule 197 (attributes)
    INT_KW       reduce using rule 197 (attributes)
    LONG_KW      reduce using rule 197 (attributes)
    PIPE_KW      reduce using rule 197 (attributes)
    SMALL_KW     reduce using rule 197 (attributes)
    STRUCT_KW    reduce using rule 197 (attributes)
    UNION_KW     reduce using rule 197 (attributes)
    UNSIGNED_KW  reduce using rule 197 (attributes)
    SHORT_KW     reduce using rule 197 (attributes)
    VOID_KW      reduce using rule 197 (attributes)
    DOUBLE_KW    reduce using rule 197 (attributes)
    BOOLEAN_KW   reduce using rule 197 (attributes)
    HANDLE_T_KW  reduce using rule 197 (attributes)
    STATIC_KW    reduce using rule 197 (attributes)
    RBRACE       reduce using rule 11 (interface_body)
    IDENTIFIER   reduce using rule 197 (attributes)

    export            go to state 180
    const_dcl         go to state 68
    type_dcl          go to state 69
    operation_dcl     go to state 70
    attribute_opener  go to state 71
    attributes        go to state 72
```

It looks like, once again, it is `error` and `CONST_KW`.  The default here will be to shift, rather than reduce.  I'm going to go with the default (shift) behavior for now, keeping in mind that it may not work right.  I suspect the issue is already there (with yacc) but not reported.  If that's the case, the default should be correct.

So, I forged ahead and just commented out state.  I seriously doubt that the idl compiler will work as intended.  From where I'm at the moment, I think my choices are:

* Figure out how to save/restore the state "as intended" with the current template
* Move to a pure (re-entrant) parser, changing the parser/lexer.

Neither of these looks to be particularly simple: there are _two_ lexers and _two_ parsers, and the implementation here merges state between at least the two lexers, which seems pretty crazy, so state preservation/restoration relies upon maintaining common state.  A re-entrant parser fixes the "need to save state" issue but doesn't address the merged state assumptions.  Thus, this likely involves understanding the intent of the front end and idl parser modules and then re-writing them to "work correctly".

But I'm going to see what I get out of the current tool...


# compile_et

This is actually one of the tools I need; everything uses these error catalogs; this is based upon the Kerberos tool.  The yacc grammar code doesn't quite declare things properly, so a bit of hacking is needed:  I've declared `yyerror` and converted one of the functions that's void but not explicitly declared to be so.  I may have changed a few declarations as well... I'd really forgotten about the old-style listing between function name and opening bracket (which _mostly_ works still).

I've given up.  I don't know where it is pulling definitions from.  So I've just changed the makefile to set the BSD flag.  Let's see what that does.  Nope.  It STILL doesn't pick it up, even when I hammer it in the Makefile it _still_ fails.  I have zero idea why at this point:

```
cc -c    -D_SHARED_LIBRARIES -O   -DMIA -DBSD -D_BSD    -I. -I/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler -I/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler   -I/usr/home/tony/projects/dce122/dce/external/386bsd/usr/include   -L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/shlib -L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/shlib -L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/lib     -L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/lib -L/usr/home/tony/projects/dce122/dce/external/386bsd/usr/shlib -L/usr/home/tony/projects/dce122/dce/external/386bsd/usr/lib      acf_y_tab.c
cc: warning: argument unused during compilation: '-L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/shlib' [-Wunused-command-line-argument]
cc: warning: argument unused during compilation: '-L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/shlib' [-Wunused-command-line-argument]
cc: warning: argument unused during compilation: '-L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/lib' [-Wunused-command-line-argument]
cc: warning: argument unused during compilation: '-L/usr/home/tony/projects/dce122/dce/export/386bsd/usr/lib' [-Wunused-command-line-argument]
cc: warning: argument unused during compilation: '-L/usr/home/tony/projects/dce122/dce/external/386bsd/usr/shlib' [-Wunused-command-line-argument]
cc: warning: argument unused during compilation: '-L/usr/home/tony/projects/dce122/dce/external/386bsd/usr/lib' [-Wunused-command-line-argument]
In file included from ../../../../../src/rpc/idl/idl_compiler/acf.y:141:
In file included from /usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/nidl.h:129:
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:741:1: error: unknown type name 'Porting'
Porting Message:  Due to differences between implementations of the
^
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:741:16: error: expected ';' after top level declarator
Porting Message:  Due to differences between implementations of the
               ^
               ;
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:741:19: error: unknown type name 'Due'
Porting Message:  Due to differences between implementations of the
                  ^
/usr/home/tony/projects/dce122/dce/src/rpc/idl/idl_compiler/sysdep.h:741:25: error: expected ';' after top level declarator
Porting Message:  Due to differences between implementations of the
```

So, I can _see_ that it passs it in on the `CC` command line, yet it refuses to use the definition (that error is around the `#else` clause!)

Actually putting it directly in the Makefile works.  It won't be any good for "backwards compatibility" but oh well.

With that, compile_et at least _builds_. I had it working on Linux (where the awk script they've replaced it with _does not work_), so I suspect it will work here on FreeBSD as well.






