%option c++
%option noyywrap


/* Headers - Declarations - Definitions*/
%{
    enum tokentype{
        NUMBER = 1,
        SUM,
        SUB,
        MULT,
        DIV,
        ABS,
        ENDLINE
    };

    int yval {0};
%}

/* Tokens rules (RE)*/

%%
"+"         { return SUM; }
"-"         { return SUB; }
"*"         { return MULT; }
"/"         { return DIV; }
"|"         { return ABS; }
"\n"        { return ENDLINE; }
[ \t]+      {  }
[0-9]+      { yval = atoi(yytext); return NUMBER; }
.           {}
%%


/* User function */

int 
main(void)
{
    FlexLexer* scanner = new yyFlexLexer;
    int token{};

    while ((token = scanner->yylex()))
    {
        if (token == NUMBER){
            std::cout<<"operand: "<<yval<<'\n';
        }
        else if (token == ENDLINE){
            std::cout<<"endline\n";
        }
        else { // En C++ el lexema actual se obtiene con YYText()
            std::cout<<"operator: "<<scanner->YYText() <<'\n';
        }
    }

    delete scanner;
    return 0;
}