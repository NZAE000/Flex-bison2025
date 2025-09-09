%option c++
/*%option noyywrap*/

/* Headers - Declarations - definitions */
%{
    uint32_t n_lines{};
    uint32_t n_words{};
    uint32_t n_numbers{};
    uint32_t n_chars{};
    uint32_t n_spaces {};
    uint32_t n_others {};
%}

/* Token detection rules (RE) */

word [a-zA-Z_][a-zA-Z0-9_]*
number [0-9]+"."[0-9]+|[0-9]+

%%
{word}      { ++n_words;   n_chars += yyleng; }
{number}    { ++n_numbers; n_chars += yyleng; }
[\n]        { ++n_lines;  ++n_chars; }
[ \t]       { ++n_spaces; ++n_chars; }
.           { ++n_others; ++n_chars; }              /*other*/
%%

/* Functions */


int yyFlexLexer::yywrap() {
    return 1; //  There are not more inputs.
}


int main()
{
    //yylex();
    FlexLexer* lexer = new yyFlexLexer;
    int ret{};
    while ((ret = lexer->yylex()) != 0){ std::cout<<"ret: "<<ret<<'\n'; }

    std::cout<<"Lines: "<<n_lines<<'\n';
    std::cout<<"Words: "<<n_words<<'\n';
    std::cout<<"Numbers: "<<n_numbers<<'\n';
    std::cout<<"Characters: "<<n_chars<<'\n';
    std::cout<<"Spaces: "<<n_spaces<<'\n';
    std::cout<<"Others: "<<n_others<<'\n';

    delete lexer;

    return 0;
}