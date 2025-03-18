%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern YY_BUFFER_STATE yy_scan_string(const char *);
extern void yy_delete_buffer(YY_BUFFER_STATE);
%}

%%
"//".*                          { printf("COMMENT\n"); }
"f"                             { printf("floatdcl id\n"); }
"i"                             { printf("intdcl id\n"); }
"p"                             { printf("print id\n"); }
"="                             { printf("assign\n"); }
"+"                             { printf("plus\n"); }
[0-9]+                          { printf("inum\n"); }
[0-9]*"."[0-9]+                 { printf("fnum\n"); }
([a-eg-zA-Z][a-zA-Z0-9]*)       { printf("id\n"); }
[ \t\n]+                        { /* Ignore whitespaces */ }

%%

int main() {
    const char *input_text =
        "// basic code\n"
        "//float b\n"
        "f b\n"
        "// integer a\n"
        "i a\n"
        "// a = 5\n"
        "a = 5\n"
        "// b = a + 3.2\n"
        "b = a + 3.2\n"
        "//print 8.5\n"
        "p b\n";

    YY_BUFFER_STATE buffer = yy_scan_string(input_text);
    yylex();
    yy_delete_buffer(buffer);

    return 0;
}

int yywrap() {
    return 1;
}