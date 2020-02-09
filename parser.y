%{

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define YYSTYPE struct node*

struct node {
    YYSTYPE left;
    YYSTYPE right;
    char *token;
};

extern int yyerror (char*);
extern int yylex();
YYSTYPE mknode0(char*);
YYSTYPE mknode1(char*, YYSTYPE);
YYSTYPE mknode2(char*, YYSTYPE, YYSTYPE);
YYSTYPE mknode3(char*, YYSTYPE, YYSTYPE, YYSTYPE);
YYSTYPE mknode4(char*, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE);
YYSTYPE mknode5(char*, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE);
YYSTYPE mknode6(char*, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE);
YYSTYPE mknode7(char*, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE, YYSTYPE);

void printtree(YYSTYPE);
int main();
int printtree_level = 0;

%}

%start START
%token V
%token ART
%token CONJ_ARG0 CONJ_ARG1 CONJ_ARG2 CONJ_ARG3 CONJ_ARG4
%token CONJ_ADV0 CONJ_ADV1 CONJ_ADV2 CONJ_ADV3 CONJ_ADV4
%token CONJ_ADJ0 CONJ_ADJ1 CONJ_ADJ2 CONJ_ADJ3 CONJ_ADJ4
%token CONJ_PTCP0 CONJ_PTCP1 CONJ_PTCP2 CONJ_PTCP3 CONJ_PTCP4
%token CONJ_SENT
%token N0 N1 N2 N3 N4
%token ADJ0 ADJ1 ADJ2 ADJ3 ADJ4
%token ADV0 ADV1 ADV2 ADV3 ADV4
%token APP0 APP1 APP2 APP3 APP4
%token INF0_INTR INF0_TR
%token INF1_INTR INF1_TR
%token INF2_INTR INF2_TR
%token INF3_INTR INF3_TR
%token INF4_INTR
%token PTCP0_INTR PTCP0_TR
%token PTCP1_INTR PTCP1_TR
%token PTCP2_INTR PTCP2_TR
%token PTCP3_INTR PTCP3_TR
%token PTCP4_INTR
%token PREP
%token NUM_0 NUM_1 NUM_2 NUM_3 NUM_4 NUM_5 NUM_6 NUM_7 NUM_8 NUM_9 NUM_10
%token NUM_20 NUM_30 NUM_40 NUM_50 NUM_60 NUM_70 NUM_80 NUM_90 NUM_100
%token NUM_1E3 NUM_1E6 NUM_1E9 NUM_1E12 NUM_1E15 NUM_1E18 NUM_1E21 NUM_1E24
%token NUM_1E27 NUM_1E30 NUM_1E33 NUM_DIV NUM_PLUS NUM_POINT
%token NUM_ART0 NUM_ART1 NUM_ART2 NUM_ART3 NUM_ART4

%%

START
    : text { printtree($1); }
    ;

text
    : sentence          { $$ = mknode1("[text]", $1); }     /* s      */
    | sentence text_aux { $$ = mknode2("[text]", $1, $2); } /* s(cs)+ */
    | text_aux          { $$ = mknode1("[text]", $1); }     /* (cs)+  */
    ;

text_aux
    : CONJ_SENT sentence            { $$ = mknode2("", $1, $2); } /* token "" is dummy */
    | text_aux CONJ_SENT sentence   { $$ = mknode3("", $1, $2, $3); }
    ;

sentence
    : advp0 arg0 V advp0 { /* SV */
            $$ = mknode4("[sentence]", $1, $2, $3, $4);
        }
    | advp0 V advp0 arg0 { /* VS */
            $$ = mknode4("[sentence]", $1, $2, $3, $4);
        }
    | advp0 arg0 V advp0 arg0 { /* SVO */
            $$ = mknode5("[sentence]", $1, $2, $3, $4, $5);
        }
    | advp0 arg0 arg0 V advp0 { /* SOV */
            $$ = mknode5("[sentence]", $1, $2, $3, $4, $5);
        }
    | advp0 V advp0 arg0 arg0 { /* VSO */
            $$ = mknode5("[sentence]", $1, $2, $3, $4, $5);
        }
    ;

arg0
    : arg0_sg                       { $$ = mknode1("", $1); }     /* a      */
    | arg0_sg arg0_aux              { $$ = mknode2("", $1, $2); } /* a(ca)+ */
    ;
arg0_aux
    : CONJ_ARG0 arg0_sg           { $$ = mknode2("", $1, $2); }
    | arg0_aux CONJ_ARG0 arg0_sg  { $$ = mknode3("", $1, $2, $3); }
arg0_sg
    : ART np0   { $$ = mknode2("[argument, level=0]", $1, $2); }
    | np0       { $$ = mknode1("[argument, level=0]", $1); }
    | infp0     { $$ = mknode1("[argument, level=0]", $1); }
    ;

arg1
    : arg1_sg                     { $$ = mknode1("", $1); }     /* a      */
    | arg1_sg arg1_aux            { $$ = mknode2("", $1, $2); } /* a(ca)+ */
    | CONJ_ARG1 arg1_sg arg1_aux  { $$ = mknode1("", $1); }     /* ca(ca)+  */
    ;
arg1_aux
    : CONJ_ARG1 arg1_sg           { $$ = mknode2("", $1, $2); }
    | arg1_aux CONJ_ARG1 arg1_sg  { $$ = mknode3("", $1, $2, $3); }
arg1_sg
    : ART np1   { $$ = mknode2("[argument, level=1]", $1, $2); }
    | np1       { $$ = mknode1("[argument, level=1]", $1); }
    | infp1     { $$ = mknode1("[argument, level=1]", $1); }
    ;

arg2
    : arg2_sg                     { $$ = mknode1("", $1); }     /* a      */
    | arg2_sg arg2_aux            { $$ = mknode2("", $1, $2); } /* a(ca)+ */
    | CONJ_ARG2 arg2_sg arg2_aux  { $$ = mknode1("", $1); }     /* ca(ca)+  */
    ;
arg2_aux
    : CONJ_ARG2 arg2_sg           { $$ = mknode2("", $1, $2); }
    | arg2_aux CONJ_ARG2 arg2_sg  { $$ = mknode3("", $1, $2, $3); }
arg2_sg
    : ART np2   { $$ = mknode2("[argument, level=2]", $1, $2); }
    | np2       { $$ = mknode1("[argument, level=2]", $1); }
    | infp2     { $$ = mknode1("[argument, level=2]", $1); }
    ;

arg3
    : arg3_sg                     { $$ = mknode1("", $1); }     /* a      */
    | arg3_sg arg3_aux            { $$ = mknode2("", $1, $2); } /* a(ca)+ */
    | CONJ_ARG3 arg3_sg arg3_aux  { $$ = mknode1("", $1); }     /* ca(ca)+  */
    ;
arg3_aux
    : CONJ_ARG3 arg3_sg           { $$ = mknode2("", $1, $2); }
    | arg3_aux CONJ_ARG3 arg3_sg  { $$ = mknode3("", $1, $2, $3); }
arg3_sg
    : ART np3   { $$ = mknode2("[argument, level=3]", $1, $2); }
    | np3       { $$ = mknode1("[argument, level=3]", $1); }
    | infp3     { $$ = mknode1("[argument, level=3]", $1); }
    ;

arg4
    : arg4_sg                     { $$ = mknode1("", $1); }     /* a      */
    | arg4_sg arg4_aux            { $$ = mknode2("", $1, $2); } /* a(ca)+ */
    | CONJ_ARG4 arg4_sg arg4_aux  { $$ = mknode1("", $1); }     /* ca(ca)+  */
    ;
arg4_aux
    : CONJ_ARG4 arg4_sg           { $$ = mknode2("", $1, $2); }
    | arg4_aux CONJ_ARG4 arg4_sg  { $$ = mknode3("", $1, $2, $3); }
arg4_sg
    : ART np4   { $$ = mknode2("[argument, level=4]", $1, $2); }
    | np4       { $$ = mknode1("[argument, level=4]", $1); }
    | infp4     { $$ = mknode1("[argument, level=4]", $1); }
    ;

np0
    : N0 advp1 adjp0 ptcpp0 appp0 {
            $$ = mknode5("[noun phrase, level=0]", $1, $2, $3, $4, $5);
        }
	| numeral0 advp1 adjp1 ptcpp1 appp1 {
            $$ = mknode5("[noun phrase, level=0]", $1, $2, $3, $4, $5);
        }
	;

np1
    : N1 advp2 adjp1 ptcpp1 appp1 {
            $$ = mknode5("[noun phrase, level=1]", $1, $2, $3, $4, $5);
        }
	| numeral1 advp2 adjp2 ptcpp2 appp2 {
            $$ = mknode5("[noun phrase, level=1]", $1, $2, $3, $4, $5);
        }
	;

np2
    : N2 advp3 adjp2 ptcpp2 appp2 {
            $$ = mknode5("[noun phrase, level=2]", $1, $2, $3, $4, $5);
        }
	| numeral2 advp3 adjp3 ptcpp3 appp3 {
            $$ = mknode5("[noun phrase, level=2]", $1, $2, $3, $4, $5);
        }
	;

np3
    : N3 advp4 adjp3 ptcpp3 appp3 {
            $$ = mknode5("[noun phrase, level=3]", $1, $2, $3, $4, $5);
        }
	| numeral3 advp4 adjp4 ptcpp4 appp4 {
            $$ = mknode5("[noun phrase, level=3]", $1, $2, $3, $4, $5);
        }
	;

np4
    : N4 adjp4 ptcpp4 appp4 {
            $$ = mknode4("[noun phrase, level=4]", $1, $2, $3, $4);
        }
	| numeral4 adjp4 ptcpp4 appp4 {
            $$ = mknode4("[noun phrase, level=4]", $1, $2, $3, $4);
        }
	;

infp0
    : INF0_INTR advp1 {
            $$ = mknode2("[infinitive phrase, level=0]", $1, $2);
        }
    | INF0_TR advp1 arg1 {
            $$ = mknode3("[infinitive phrase, level=0]", $1, $2, $3);
        }
    ;

infp1
    : INF1_INTR advp2 {
            $$ = mknode2("[infinitive phrase, level=1]", $1, $2);
        }
    | INF1_TR advp2 arg2 {
            $$ = mknode3("[infinitive phrase, level=1]", $1, $2, $3);
        }
    ;

infp2
    : INF2_INTR advp3 {
            $$ = mknode2("[infinitive phrase, level=2]", $1, $2);
        }
    | INF2_TR advp3 arg3 {
            $$ = mknode3("[infinitive phrase, level=2]", $1, $2, $3);
        }
    ;

infp3
    : INF3_INTR advp4 {
            $$ = mknode2("[infinitive phrase, level=3]", $1, $2);
        }
    | INF3_TR advp4 arg4 {
            $$ = mknode3("[infinitive phrase, level=3]", $1, $2, $3);
        }
    ;

infp4
    : INF4_INTR {
            $$ = mknode1("[infinitive phrase, level=4]", $1);
        }
    ;

advp0
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | advp0_sg                      { $$ = mknode1("", $1); }         /* a       */
    | advp0_sg advp0_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADV0 advp0_sg advp0_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
advp0_aux2
    : CONJ_ADV0 advp0_sg            { $$ = mknode2("", $1, $2); }
    | advp0_aux2 CONJ_ADV0 advp0_sg { $$ = mknode3("", $1, $2, $3); }
    ;
advp0_sg
    : ADV0 advp1 {
            $$ = mknode2("[adverb phrase, level=0]", $1, $2);
        }
    | PREP advp1 arg1 {
            $$ = mknode3("[prepositional phrase, level=0]", $1, $2, $3);
        }
    ;

advp1
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | advp1_sg                      { $$ = mknode1("", $1); }         /* a       */
    | advp1_sg advp1_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADV1 advp1_sg advp1_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
advp1_aux2
    : CONJ_ADV1 advp1_sg            { $$ = mknode2("", $1, $2); }
    | advp1_aux2 CONJ_ADV1 advp1_sg { $$ = mknode3("", $1, $2, $3); }
    ;
advp1_sg
    : ADV1 advp2 {
            $$ = mknode2("[adverb phrase, level=1]", $1, $2);
        }
    | PREP advp2 arg2 {
            $$ = mknode3("[prepositional phrase, level=1]", $1, $2, $3);
        }
    ;

advp2
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | advp2_sg                      { $$ = mknode1("", $1); }         /* a       */
    | advp2_sg advp2_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADV2 advp2_sg advp2_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
advp2_aux2
    : CONJ_ADV2 advp2_sg            { $$ = mknode2("", $1, $2); }
    | advp2_aux2 CONJ_ADV2 advp2_sg { $$ = mknode3("", $1, $2, $3); }
    ;
advp2_sg
    : ADV2 advp3 {
            $$ = mknode2("[adverb phrase, level=2]", $1, $2);
        }
    | PREP advp3 arg3 {
            $$ = mknode3("[prepositional phrase, level=2]", $1, $2, $3);
        }
    ;

advp3
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | advp3_sg                      { $$ = mknode1("", $1); }         /* a       */
    | advp3_sg advp3_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADV3 advp3_sg advp3_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
advp3_aux2
    : CONJ_ADV3 advp3_sg            { $$ = mknode2("", $1, $2); }
    | advp3_aux2 CONJ_ADV3 advp3_sg { $$ = mknode3("", $1, $2, $3); }
    ;
advp3_sg
    : ADV3 advp4 {
            $$ = mknode2("[adverb phrase, level=3]", $1, $2);
        }
    | PREP advp4 arg4 {
            $$ = mknode3("[prepositional phrase, level=3]", $1, $2, $3);
        }
    ;

advp4
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | advp4_sg                      { $$ = mknode1("", $1); }         /* a       */
    | advp4_sg advp4_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADV4 advp4_sg advp4_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
advp4_aux2
    : CONJ_ADV4 advp4_sg            { $$ = mknode2("", $1, $2); }
    | advp4_aux2 CONJ_ADV4 advp4_sg { $$ = mknode3("", $1, $2, $3); }
    ;
advp4_sg
    : ADV4 {
            $$ = mknode1("[adverb phrase, level=4]", $1);
        }
    ;

adjp0
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | adjp0_aux                     { $$ = mknode1("", $1); }         /* a+      */
    | adjp0_sg adjp0_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADJ0 adjp0_sg adjp0_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
adjp0_aux
    : adjp0_sg              { $$ = mknode1("", $1); }
    | adjp0_aux adjp0_sg    { $$ = mknode2("", $1, $2); }
    ;
adjp0_aux2
    : CONJ_ADJ0 adjp0_sg            { $$ = mknode2("", $1, $2); }
    | adjp0_aux2 CONJ_ADJ0 adjp0_sg { $$ = mknode3("", $1, $2, $3); }
    ;
adjp0_sg
    : ADJ0 advp1 {
            $$ = mknode2("[adjective phrase, level=0]", $1, $2);
        }
    ;

adjp1
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | adjp1_aux                     { $$ = mknode1("", $1); }         /* a+      */
    | adjp1_sg adjp1_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADJ1 adjp1_sg adjp1_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
adjp1_aux
    : adjp1_sg              { $$ = mknode1("", $1); }
    | adjp1_aux adjp1_sg    { $$ = mknode2("", $1, $2); }
    ;
adjp1_aux2
    : CONJ_ADJ1 adjp1_sg            { $$ = mknode2("", $1, $2); }
    | adjp1_aux2 CONJ_ADJ1 adjp1_sg { $$ = mknode3("", $1, $2, $3); }
    ;
adjp1_sg
    : ADJ1 advp2 {
            $$ = mknode2("[adjective phrase, level=1]", $1, $2);
        }
    ;

adjp2
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | adjp2_aux                     { $$ = mknode1("", $1); }         /* a+      */
    | adjp2_sg adjp2_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADJ2 adjp2_sg adjp2_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
adjp2_aux
    : adjp2_sg              { $$ = mknode1("", $1); }
    | adjp2_aux adjp2_sg    { $$ = mknode2("", $1, $2); }
    ;
adjp2_aux2
    : CONJ_ADJ2 adjp2_sg            { $$ = mknode2("", $1, $2); }
    | adjp2_aux2 CONJ_ADJ2 adjp2_sg { $$ = mknode3("", $1, $2, $3); }
    ;
adjp2_sg
    : ADJ2 advp3 {
            $$ = mknode2("[adjective phrase, level=2]", $1, $2);
        }
    ;

adjp3
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | adjp3_aux                     { $$ = mknode1("", $1); }         /* a+      */
    | adjp3_sg adjp3_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADJ3 adjp3_sg adjp3_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
adjp3_aux
    : adjp3_sg              { $$ = mknode1("", $1); }
    | adjp3_aux adjp3_sg    { $$ = mknode2("", $1, $2); }
    ;
adjp3_aux2
    : CONJ_ADJ3 adjp3_sg            { $$ = mknode2("", $1, $2); }
    | adjp3_aux2 CONJ_ADJ3 adjp3_sg { $$ = mknode3("", $1, $2, $3); }
    ;
adjp3_sg
    : ADJ3 advp4 {
            $$ = mknode2("[adjective phrase, level=3]", $1, $2);
        }
    ;

adjp4
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | adjp4_aux                     { $$ = mknode1("", $1); }         /* a+      */
    | adjp4_sg adjp4_aux2           { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_ADJ4 adjp4_sg adjp4_aux2 { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
adjp4_aux
    : adjp4_sg              { $$ = mknode1("", $1); }
    | adjp4_aux adjp4_sg    { $$ = mknode2("", $1, $2); }
    ;
adjp4_aux2
    : CONJ_ADJ4 adjp4_sg            { $$ = mknode2("", $1, $2); }
    | adjp4_aux2 CONJ_ADJ4 adjp4_sg { $$ = mknode3("", $1, $2, $3); }
    ;
adjp4_sg
    : ADJ4 {
            $$ = mknode1("[adjective phrase, level=4]", $1);
        }
    ;

ptcpp0
    : /* empty */                       { $$ = mknode0(""); }             /* ()      */
    | ptcpp0_aux                        { $$ = mknode1("", $1); }         /* a+      */
    | ptcpp0_sg ptcpp0_aux2             { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_PTCP0 ptcpp0_sg ptcpp0_aux2  { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
ptcpp0_aux
    : ptcpp0_sg             { $$ = mknode1("", $1); }
    | ptcpp0_aux ptcpp0_sg  { $$ = mknode2("", $1, $2); }
    ;
ptcpp0_aux2
    : CONJ_PTCP0 ptcpp0_sg              { $$ = mknode2("", $1, $2); }
    | ptcpp0_aux2 CONJ_PTCP0 ptcpp0_sg  { $$ = mknode3("", $1, $2, $3); }
    ;
ptcpp0_sg
    : PTCP0_INTR advp1 {
            $$ = mknode2("[participial phrase, level=0]", $1, $2);
        }
    | PTCP0_TR advp1 arg1 {
            $$ = mknode3("[participial phrase, level=0]", $1, $2, $3);
        }
    ;

ptcpp1
    : /* empty */                       { $$ = mknode0(""); }             /* ()      */
    | ptcpp1_aux                        { $$ = mknode1("", $1); }         /* a+      */
    | ptcpp1_sg ptcpp1_aux2             { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_PTCP1 ptcpp1_sg ptcpp1_aux2  { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
ptcpp1_aux
    : ptcpp1_sg             { $$ = mknode1("", $1); }
    | ptcpp1_aux ptcpp1_sg  { $$ = mknode2("", $1, $2); }
    ;
ptcpp1_aux2
    : CONJ_PTCP1 ptcpp1_sg              { $$ = mknode2("", $1, $2); }
    | ptcpp1_aux2 CONJ_PTCP1 ptcpp1_sg  { $$ = mknode3("", $1, $2, $3); }
    ;
ptcpp1_sg
    : PTCP1_INTR advp2 {
            $$ = mknode2("[participial phrase, level=1]", $1, $2);
        }
    | PTCP1_TR advp2 arg2 {
            $$ = mknode3("[participial phrase, level=1]", $1, $2, $3);
        }
    ;

ptcpp2
    : /* empty */                       { $$ = mknode0(""); }             /* ()      */
    | ptcpp2_aux                        { $$ = mknode1("", $1); }         /* a+      */
    | ptcpp2_sg ptcpp2_aux2             { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_PTCP2 ptcpp2_sg ptcpp2_aux2  { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
ptcpp2_aux
    : ptcpp2_sg             { $$ = mknode1("", $1); }
    | ptcpp2_aux ptcpp2_sg  { $$ = mknode2("", $1, $2); }
    ;
ptcpp2_aux2
    : CONJ_PTCP2 ptcpp2_sg              { $$ = mknode2("", $1, $2); }
    | ptcpp2_aux2 CONJ_PTCP2 ptcpp2_sg  { $$ = mknode3("", $1, $2, $3); }
    ;
ptcpp2_sg
    : PTCP2_INTR advp3 {
            $$ = mknode2("[participial phrase, level=2]", $1, $2);
        }
    | PTCP2_TR advp3 arg3 {
            $$ = mknode3("[participial phrase, level=2]", $1, $2, $3);
        }
    ;

ptcpp3
    : /* empty */                       { $$ = mknode0(""); }             /* ()      */
    | ptcpp3_aux                        { $$ = mknode1("", $1); }         /* a+      */
    | ptcpp3_sg ptcpp3_aux2             { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_PTCP3 ptcpp3_sg ptcpp3_aux2  { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
ptcpp3_aux
    : ptcpp3_sg             { $$ = mknode1("", $1); }
    | ptcpp3_aux ptcpp3_sg  { $$ = mknode2("", $1, $2); }
    ;
ptcpp3_aux2
    : CONJ_PTCP3 ptcpp3_sg              { $$ = mknode2("", $1, $2); }
    | ptcpp3_aux2 CONJ_PTCP3 ptcpp3_sg  { $$ = mknode3("", $1, $2, $3); }
    ;
ptcpp3_sg
    : PTCP3_INTR advp4 {
            $$ = mknode2("[participial phrase, level=3]", $1, $2);
        }
    | PTCP3_TR advp4 arg4 {
            $$ = mknode3("[participial phrase, level=3]", $1, $2, $3);
        }
    ;

ptcpp4
    : /* empty */                       { $$ = mknode0(""); }             /* ()      */
    | ptcpp4_aux                        { $$ = mknode1("", $1); }         /* a+      */
    | ptcpp4_sg ptcpp4_aux2             { $$ = mknode2("", $1, $2); }     /* a(ca)+  */
    | CONJ_PTCP4 ptcpp4_sg ptcpp4_aux2  { $$ = mknode3("", $1, $2, $3); } /* ca(ca)+ */
    ;
ptcpp4_aux
    : ptcpp4_sg             { $$ = mknode1("", $1); }
    | ptcpp4_aux ptcpp4_sg  { $$ = mknode2("", $1, $2); }
    ;
ptcpp4_aux2
    : CONJ_PTCP4 ptcpp4_sg              { $$ = mknode2("", $1, $2); }
    | ptcpp4_aux2 CONJ_PTCP4 ptcpp4_sg  { $$ = mknode3("", $1, $2, $3); }
    ;
ptcpp4_sg
    : PTCP4_INTR {
            $$ = mknode1("[participial phrase, level=4]", $1);
        }
    ;

appp0
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | appp0_aux                     { $$ = mknode1("", $1); }         /* a+      */
    ;
appp0_aux
    : appp0_sg              { $$ = mknode1("", $1); }
    | appp0_aux appp0_sg    { $$ = mknode2("", $1, $2); }
    ;
appp0_sg
    : APP0 advp1 adjp0 ptcpp0 {
            $$ = mknode4("[appositive phrase, level=0]", $1, $2, $3, $4);
        }
    ;

appp1
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | appp1_aux                     { $$ = mknode1("", $1); }         /* a+      */
    ;
appp1_aux
    : appp1_sg              { $$ = mknode1("", $1); }
    | appp1_aux appp1_sg    { $$ = mknode2("", $1, $2); }
    ;
appp1_sg
    : APP1 advp2 adjp1 ptcpp1 {
            $$ = mknode4("[appositive phrase, level=1]", $1, $2, $3, $4);
        }
    ;

appp2
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | appp2_aux                     { $$ = mknode1("", $1); }         /* a+      */
    ;
appp2_aux
    : appp2_sg              { $$ = mknode1("", $1); }
    | appp2_aux appp2_sg    { $$ = mknode2("", $1, $2); }
    ;
appp2_sg
    : APP2 advp3 adjp2 ptcpp2 {
            $$ = mknode4("[appositive phrase, level=2]", $1, $2, $3, $4);
        }
    ;

appp3
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | appp3_aux                     { $$ = mknode1("", $1); }         /* a+      */
    ;
appp3_aux
    : appp3_sg              { $$ = mknode1("", $1); }
    | appp3_aux appp3_sg    { $$ = mknode2("", $1, $2); }
    ;
appp3_sg
    : APP3 advp4 adjp3 ptcpp3 {
            $$ = mknode4("[appositive phrase, level=3]", $1, $2, $3, $4);
        }
    ;

appp4
    : /* empty */                   { $$ = mknode0(""); }             /* ()      */
    | appp4_aux                     { $$ = mknode1("", $1); }         /* a+      */
    ;
appp4_aux
    : appp4_sg              { $$ = mknode1("", $1); }
    | appp4_aux appp4_sg    { $$ = mknode2("", $1, $2); }
    ;
appp4_sg
    : APP4 adjp4 ptcpp4 {
            $$ = mknode3("[appositive phrase, level=4]", $1, $2, $3);
        }
    ;

numeral0
    : NUM_ART0 natural      { $$ = mknode2("[natural numeral, level=0]", $1, $2); }
    | NUM_ART0 decimal      { $$ = mknode2("", $1, $2); }
    | NUM_ART0 fractional   { $$ = mknode2("", $1, $2); }
    ;

numeral1
    : NUM_ART1 natural      { $$ = mknode2("[natural numeral, level=1]", $1, $2); }
    | NUM_ART1 decimal      { $$ = mknode2("", $1, $2); }
    | NUM_ART1 fractional   { $$ = mknode2("", $1, $2); }
    ;

numeral2
    : NUM_ART2 natural      { $$ = mknode2("[natural numeral, level=2]", $1, $2); }
    | NUM_ART2 decimal      { $$ = mknode2("", $1, $2); }
    | NUM_ART2 fractional   { $$ = mknode2("", $1, $2); }
    ;

numeral3
    : NUM_ART3 natural      { $$ = mknode2("[natural numeral, level=3]", $1, $2); }
    | NUM_ART3 decimal      { $$ = mknode2("", $1, $2); }
    | NUM_ART3 fractional   { $$ = mknode2("", $1, $2); }
    ;

numeral4
    : NUM_ART4 natural      { $$ = mknode2("[natural numeral, level=4]", $1, $2); }
    | NUM_ART4 decimal      { $$ = mknode2("", $1, $2); }
    | NUM_ART4 fractional   { $$ = mknode2("", $1, $2); }
    ;

decimal
    : natural NUM_POINT digits  { $$ = mknode3("[decimal numeral]", $1, $2, $3); }
    ;

digits
    : n_0_9         { $$ = mknode1("", $1); }
    | digits n_0_9  { $$ = mknode2("", $1, $2); }
    ;

fractional
    : natural NUM_DIV natural {
            $$ = mknode3("[fractional numeral]", $1, $2, $3);
        }
    | natural NUM_PLUS natural NUM_DIV natural {
            $$ = mknode5("[compound fractional numeral]", $1, $2, $3, $4, $5);
        }
    ;

natural
    : n_0_999    { $$ = mknode1("", $1); }
    | n1e3       { $$ = mknode1("", $1); }
    | n1e6       { $$ = mknode1("", $1); }
    | n1e9       { $$ = mknode1("", $1); }
    | n1e12      { $$ = mknode1("", $1); }
    | n1e15      { $$ = mknode1("", $1); }
    | n1e18      { $$ = mknode1("", $1); }
    | n1e21      { $$ = mknode1("", $1); }
    | n1e24      { $$ = mknode1("", $1); }
    | n1e27      { $$ = mknode1("", $1); }
    | n1e30      { $$ = mknode1("", $1); }
    | n1e33      { $$ = mknode1("", $1); }
    ;

n_0_999
    : NUM_0     { $$ = mknode1("", $1); }
    | n_1_999   { $$ = mknode1("", $1); }
    ;

n_1_999
    : n_1_9                             { $$ = mknode1("", $1); }
    | n_10_90                           { $$ = mknode1("", $1); }
    | n_10_90 n_0_9                     { $$ = mknode2("", $1, $2); }
    | n_1_9 NUM_100                     { $$ = mknode2("", $1, $2); }
    | n_1_9 NUM_100 n_0_9               { $$ = mknode3("", $1, $2, $3); }
    | n_1_9 NUM_100 n_10_90             { $$ = mknode3("", $1, $2, $3); }
    | n_1_9 NUM_100 n_10_90 n_0_9       { $$ = mknode4("", $1, $2, $3, $4); }
    ;

n_0_9
    : NUM_0     { $$ = mknode1("", $1); }
    | n_1_9     { $$ = mknode1("", $1); }
    ;

n_1_9
    : NUM_1     { $$ = mknode1("", $1); }
    | NUM_2     { $$ = mknode1("", $1); }
    | NUM_3     { $$ = mknode1("", $1); }
    | NUM_4     { $$ = mknode1("", $1); }
    | NUM_5     { $$ = mknode1("", $1); }
    | NUM_6     { $$ = mknode1("", $1); }
    | NUM_7     { $$ = mknode1("", $1); }
    | NUM_8     { $$ = mknode1("", $1); }
    | NUM_9     { $$ = mknode1("", $1); }
    ;

n_10_90
    : NUM_10     { $$ = mknode1("", $1); }
    | NUM_20     { $$ = mknode1("", $1); }
    | NUM_30     { $$ = mknode1("", $1); }
    | NUM_40     { $$ = mknode1("", $1); }
    | NUM_50     { $$ = mknode1("", $1); }
    | NUM_60     { $$ = mknode1("", $1); }
    | NUM_70     { $$ = mknode1("", $1); }
    | NUM_80     { $$ = mknode1("", $1); }
    | NUM_90     { $$ = mknode1("", $1); }
    ;

n1e3
    : n_1_999 NUM_1E3           { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E3 n_0_999   { $$ = mknode3("", $1, $2, $3); }
    ;

n1e6
    : n_1_999 NUM_1E6           { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E6 n_0_999   { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E6 n1e3      { $$ = mknode3("", $1, $2, $3); }
    ;

n1e9
    : n_1_999 NUM_1E9           { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E9 n_0_999   { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E9 n1e3      { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E9 n1e6      { $$ = mknode3("", $1, $2, $3); }
    ;

n1e12
    : n_1_999 NUM_1E12          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E12 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E12 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E12 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E12 n1e9     { $$ = mknode3("", $1, $2, $3); }
    ;

n1e15
    : n_1_999 NUM_1E15          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E15 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E15 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E15 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E15 n1e9     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E15 n1e12    { $$ = mknode3("", $1, $2, $3); }
    ;

n1e18
    : n_1_999 NUM_1E18          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E18 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E18 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E18 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E18 n1e9     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E18 n1e12    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E18 n1e15    { $$ = mknode3("", $1, $2, $3); }
    ;

n1e21
    : n_1_999 NUM_1E21          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E21 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E21 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E21 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E21 n1e9     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E21 n1e12    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E21 n1e15    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E21 n1e18    { $$ = mknode3("", $1, $2, $3); }
    ;

n1e24
    : n_1_999 NUM_1E24          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E24 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E24 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E24 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E24 n1e9     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E24 n1e12    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E24 n1e15    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E24 n1e18    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E24 n1e21    { $$ = mknode3("", $1, $2, $3); }
    ;

n1e27
    : n_1_999 NUM_1E27          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E27 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e9     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e12    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e15    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e18    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e21    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E27 n1e24    { $$ = mknode3("", $1, $2, $3); }
    ;

n1e30
    : n_1_999 NUM_1E30          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E30 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e9     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e12    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e15    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e18    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e21    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e24    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E30 n1e27    { $$ = mknode3("", $1, $2, $3); }
    ;

n1e33
    : n_1_999 NUM_1E33          { $$ = mknode2("", $1, $2); }
    | n_1_999 NUM_1E33 n_0_999  { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e3     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e6     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e9     { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e12    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e15    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e18    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e21    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e24    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e27    { $$ = mknode3("", $1, $2, $3); }
    | n_1_999 NUM_1E33 n1e30    { $$ = mknode3("", $1, $2, $3); }
    ;

%%

YYSTYPE
mknode2(char *token, YYSTYPE left, YYSTYPE right) {
    YYSTYPE newnode;
    char *newtoken;
    if ((newnode = (YYSTYPE)malloc(sizeof(struct node))) == NULL) {
        fprintf(stderr, "warning: not enough memory\n");
        abort();
    }
    if ((newtoken = (char*)malloc(strlen(token) + 1)) == NULL) {
        fprintf(stderr, "warning: not enough memory\n");
        abort();
    }
    strcpy(newtoken, token);
    newnode->left = left;
    newnode->right = right;
    newnode->token = newtoken;
    return newnode;
}

YYSTYPE
mknode0(char *token) {
    return mknode2(token, NULL, NULL);
}

YYSTYPE
mknode1(char *token, YYSTYPE node) {
    return mknode2(token, node, NULL);
}

YYSTYPE
mknode3(char *token, YYSTYPE node1, YYSTYPE node2, YYSTYPE node3) {
    return mknode2(token, node1, mknode2("", node2, node3));
}

YYSTYPE
mknode4(char *token, YYSTYPE node1, YYSTYPE node2, YYSTYPE node3,
        YYSTYPE node4) {
    return mknode2(token, node1, mknode3("", node2, node3, node4));
}

YYSTYPE
mknode5(char *token, YYSTYPE node1, YYSTYPE node2, YYSTYPE node3,
        YYSTYPE node4, YYSTYPE node5) {
    return mknode2(token, node1, mknode4("", node2, node3, node4, node5));
}

YYSTYPE
mknode6(char *token, YYSTYPE node1, YYSTYPE node2, YYSTYPE node3,
        YYSTYPE node4, YYSTYPE node5, YYSTYPE node6) {
    return mknode2(token, node1, mknode5("", node2, node3, node4, node5,
        node6));
}

YYSTYPE
mknode7(char *token, YYSTYPE node1, YYSTYPE node2, YYSTYPE node3,
        YYSTYPE node4, YYSTYPE node5, YYSTYPE node6, YYSTYPE node7) {
    return mknode2(token, node1, mknode6("", node2, node3, node4, node5,
        node6, node7));
}

void
printtree(YYSTYPE tree) {
    if (NULL == tree) {
        return;
    }
    if (NULL == tree->token) {
        return;
    }
    int i;
    /* token "" is dummy, so don't print it and don't shift level */
    if (strcmp(tree->token, "")) {
        for (i = 0; i < printtree_level; i++) {
            printf("    ");
        }
        printf("%s\n", tree->token);
        if (NULL != tree->left || NULL != tree->right) {
            printtree_level++;
        }
    }
    printtree(tree->left);
    printtree(tree->right);
    if (strcmp(tree->token, "")) {
        if (NULL != tree->left || NULL != tree->right) {
            printtree_level--;
        }
    }
}

int
main() {
    return yyparse();
}
