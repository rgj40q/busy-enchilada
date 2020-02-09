%{

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define YYSTYPE struct node *

struct node {
    YYSTYPE left;
    YYSTYPE right;
    char *token;
};

#include "y.tab.h"

extern YYSTYPE mknode0(char*);
extern YYSTYPE yylval;

int yywrap();
int yyerror (char*);
void wrong_word();
int check_numeral();
char* strjoin(char*, char*);

%}

%%

(le|un) {
    yylval = mknode0(strjoin(yytext, ": article"));
    return ART;
}
(an|annon|atcue|aut|comocuncue|donec|dum|duncue|e|et|etsi|igitur|itacue|ma|mais|malgrado|nam|ne|nec|necue|ni|nisi|o|percue|pois|porcue|postcuam|cuam|cuando|cuandocuncue|cue|cuia|cuo|cuod|sed|si|sinon|sive|ubi|ubicuncue|utrum|vel) {
    yylval = mknode0(strjoin(yytext, ": conjunction for sentence"));
    return CONJ_SENT;
}
(a|ab|ad|adverso|ante|apud|circum|cis|clam|con|concernente|contra|coram|cum|de|desde|detra|decstra|durante|el|erga|ecs|ecscepte|in|infra|inter|intra|jucsta|malgre|nonobstante|ob|per|por|pre|presso|preter|pro|prope|propter|re|salvo|secun|secundo|sin|sub|super|supra|sur|tra|trans|traverso|ultra|uscue|verso|via|viste) {
    yylval = mknode0(strjoin(yytext, ": preposition"));
    return PREP;
}
(ee|oe) {
    yylval = mknode0(strjoin(yytext, ": conjunction for argument, level=0"));
    return CONJ_ARG0;
}
(ei|oi) {
    yylval = mknode0(strjoin(yytext, ": conjunction for argument, level=1"));
    return CONJ_ARG1;
}
(eo|oo) {
    yylval = mknode0(strjoin(yytext, ": conjunction for argument, level=2"));
    return CONJ_ARG2;
}
(eu|ou) {
    yylval = mknode0(strjoin(yytext, ": conjunction for argument, level=3"));
    return CONJ_ARG3;
}
(eia|oia) {
    yylval = mknode0(strjoin(yytext, ": conjunction for argument, level=4"));
    return CONJ_ARG4;
}
(eem|oem) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adverb, level=0"));
    return CONJ_ADV0;
}
(eim|oim) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adverb, level=1"));
    return CONJ_ADV1;
}
(eom|oom) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adverb, level=2"));
    return CONJ_ADV2;
}
(eum|oum) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adverb, level=3"));
    return CONJ_ADV3;
}
(eiam|oiam) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adverb, level=4"));
    return CONJ_ADV4;
}
(eel|oel) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adjective, level=0"));
    return CONJ_ADJ0;
}
(eil|oil) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adjective, level=1"));
    return CONJ_ADJ1;
}
(eol|ool) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adjective, level=2"));
    return CONJ_ADJ2;
}
(eul|oul) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adjective, level=3"));
    return CONJ_ADJ3;
}
(eial|oial) {
    yylval = mknode0(strjoin(yytext, ": conjunction for adjective, level=4"));
    return CONJ_ADJ4;
}
(eet|oet) {
    yylval = mknode0(strjoin(yytext, ": conjunction for participle, level=0"));
    return CONJ_PTCP0;
}
(eit|oit) {
    yylval = mknode0(strjoin(yytext, ": conjunction for participle, level=1"));
    return CONJ_PTCP1;
}
(eot|oot) {
    yylval = mknode0(strjoin(yytext, ": conjunction for participle, level=2"));
    return CONJ_PTCP2;
}
(eut|out) {
    yylval = mknode0(strjoin(yytext, ": conjunction for participle, level=3"));
    return CONJ_PTCP3;
}
(eiat|oiat) {
    yylval = mknode0(strjoin(yytext, ": conjunction for participle, level=4"));
    return CONJ_PTCP4;
}
zero {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 0"));
    return NUM_0;
}
uni {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1"));
    return NUM_1;
}
duo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 2"));
    return NUM_2;
}
tres {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 3"));
    return NUM_3;
}
quatro {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 4"));
    return NUM_4;
}
cinque {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 5"));
    return NUM_5;
}
sex {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 6"));
    return NUM_6;
}
septe {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 7"));
    return NUM_7;
}
octo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 8"));
    return NUM_8;
}
nove {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 9"));
    return NUM_9;
}
dece {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 10"));
    return NUM_10;
}
vinti {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 20"));
    return NUM_20;
}
trenta {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 30"));
    return NUM_30;
}
quaranta {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 40"));
    return NUM_40;
}
cinquanta {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 50"));
    return NUM_50;
}
sexanta {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 60"));
    return NUM_60;
}
septanta {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 70"));
    return NUM_70;
}
octanta {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 80"));
    return NUM_80;
}
novanta {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 90"));
    return NUM_90;
}
cento {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 100"));
    return NUM_100;
}
mille {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e3"));
    return NUM_1E3;
}
million {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e6"));
    return NUM_1E6;
}
milliardo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e9"));
    return NUM_1E9;
}
billion {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e12"));
    return NUM_1E12;
}
billiardo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e15"));
    return NUM_1E15;
}
trillion {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e18"));
    return NUM_1E18;
}
trilliardo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e21"));
    return NUM_1E21;
}
quatrillion {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e24"));
    return NUM_1E24;
}
quatrilliardo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e27"));
    return NUM_1E27;
}
quintillion {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e30"));
    return NUM_1E30;
}
quintilliardo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, 1e33"));
    return NUM_1E33;
}
lu {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, article, level=0"));
    return NUM_ART0;
}
lui {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, article, level=1"));
    return NUM_ART1;
}
luo {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, article, level=2"));
    return NUM_ART2;
}
luu {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, article, level=3"));
    return NUM_ART3;
}
luai {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, article, level=4"));
    return NUM_ART4;
}
di {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, divided by"));
    return NUM_DIV;
}
plus {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, and"));
    return NUM_PLUS;
}
comma {
    yylval = mknode0(strjoin(yytext, ": \tnumeral, comma"));
    return NUM_POINT;
}
[a-z]+et {
    yylval = mknode0(strjoin(yytext, ": verb, present"));
    return V;
}
[a-z]+eva {
    yylval = mknode0(strjoin(yytext, ": verb, past"));
    return V;
}
[a-z]+era {
    yylval = mknode0(strjoin(yytext, ": verb, future"));
    return V;
}
[a-z]+erea {
    yylval = mknode0(strjoin(yytext, ": verb, conditional"));
    return V;
}
[a-z]+en {
    yylval = mknode0(strjoin(yytext, ": verb, imperative"));
    return V;
}
[a-z]+e {
    yylval = mknode0(strjoin(yytext, ": noun, singular, level=0"));
    return N0;
}
[a-z]+es {
    yylval = mknode0(strjoin(yytext, ": noun, plural, level=0"));
    return N0;
}
[a-z]+i {
    yylval = mknode0(strjoin(yytext, ": noun, singular, level=1"));
    return N1;
}
[a-z]+is {
    yylval = mknode0(strjoin(yytext, ": noun, plural, level=1"));
    return N1;
}
[a-z]+o {
    yylval = mknode0(strjoin(yytext, ": noun, singular, level=2"));
    return N2;
}
[a-z]+os {
    yylval = mknode0(strjoin(yytext, ": noun, plural, level=2"));
    return N2;
}
[a-z]+u {
    yylval = mknode0(strjoin(yytext, ": noun, singular, level=3"));
    return N3;
}
[a-z]+us {
    yylval = mknode0(strjoin(yytext, ": noun, plural, level=3"));
    return N3;
}
[a-z]+ia {
    yylval = mknode0(strjoin(yytext, ": noun, singular, level=4"));
    return N4;
}
[a-z]+ias {
    yylval = mknode0(strjoin(yytext, ": noun, plural, level=4"));
    return N4;
}
[a-z]+ert {
    yylval = mknode0(strjoin(yytext, ": infinitive, intransitive, level=0"));
    return INF0_INTR;
}
[a-z]+er {
    yylval = mknode0(strjoin(yytext, ": infinitive, transitive, level=0"));
    return INF0_TR;
}
[a-z]+irt {
    yylval = mknode0(strjoin(yytext, ": infinitive, intransitive, level=1"));
    return INF1_INTR;
}
[a-z]+ir {
    yylval = mknode0(strjoin(yytext, ": infinitive, transitive, level=1"));
    return INF1_TR;
}
[a-z]+ort {
    yylval = mknode0(strjoin(yytext, ": infinitive, intransitive, level=2"));
    return INF2_INTR;
}
[a-z]+or {
    yylval = mknode0(strjoin(yytext, ": infinitive, transitive, level=2"));
    return INF2_TR;
}
[a-z]+urt {
    yylval = mknode0(strjoin(yytext, ": infinitive, intransitive, level=3"));
    return INF3_INTR;
}
[a-z]+ur {
    yylval = mknode0(strjoin(yytext, ": infinitive, transitive, level=3"));
    return INF3_TR;
}
[a-z]+iart {
    yylval = mknode0(strjoin(yytext, ": infinitive, intransitive, level=4"));
    return INF4_INTR;
}
[a-z]+ec {
    yylval = mknode0(strjoin(yytext, ": apposition, singular, level=0"));
    return APP0;
}
[a-z]+ecs {
    yylval = mknode0(strjoin(yytext, ": apposition, plural, level=0"));
    return APP0;
}
[a-z]+ic {
    yylval = mknode0(strjoin(yytext, ": apposition, singular, level=1"));
    return APP1;
}
[a-z]+ics {
    yylval = mknode0(strjoin(yytext, ": apposition, plural, level=1"));
    return APP1;
}
[a-z]+oc {
    yylval = mknode0(strjoin(yytext, ": apposition, singular, level=2"));
    return APP2;
}
[a-z]+ocs {
    yylval = mknode0(strjoin(yytext, ": apposition, plural, level=2"));
    return APP2;
}
[a-z]+uc {
    yylval = mknode0(strjoin(yytext, ": apposition, singular, level=3"));
    return APP3;
}
[a-z]+ucs {
    yylval = mknode0(strjoin(yytext, ": apposition, plural, level=3"));
    return APP3;
}
[a-z]+iac {
    yylval = mknode0(strjoin(yytext, ": apposition, singular, level=4"));
    return APP4;
}
[a-z]+el {
    yylval = mknode0(strjoin(yytext, ": adjective, singular, level=0"));
    return ADJ0;
}
[a-z]+il {
    yylval = mknode0(strjoin(yytext, ": adjective, singular, level=1"));
    return ADJ1;
}
[a-z]+ol {
    yylval = mknode0(strjoin(yytext, ": adjective, singular, level=2"));
    return ADJ2;
}
[a-z]+ul {
    yylval = mknode0(strjoin(yytext, ": adjective, singular, level=3"));
    return ADJ3;
}
[a-z]+ial {
    yylval = mknode0(strjoin(yytext, ": adjective, singular, level=4"));
    return ADJ4;
}
[a-z]+em {
    yylval = mknode0(strjoin(yytext, ": adverb, level=0"));
    return ADV0;
}
[a-z]+im {
    yylval = mknode0(strjoin(yytext, ": adverb, level=1"));
    return ADV1;
}
[a-z]+om {
    yylval = mknode0(strjoin(yytext, ": adverb, level=2"));
    return ADV2;
}
[a-z]+um {
    yylval = mknode0(strjoin(yytext, ": adverb, level=3"));
    return ADV3;
}
[a-z]+iam {
    yylval = mknode0(strjoin(yytext, ": adverb, level=4"));
    return ADV4;
}
[a-z]+enta {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, present, level=0"));
    return PTCP0_INTR;
}
[a-z]+enda {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, present, level=0"));
    return PTCP0_TR;
}
[a-z]+eta {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, past, level=0"));
    return PTCP0_INTR;
}
[a-z]+eda {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, past, level=0"));
    return PTCP0_TR;
}
[a-z]+inta {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, present, level=1"));
    return PTCP1_INTR;
}
[a-z]+inda {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, present, level=1"));
    return PTCP1_TR;
}
[a-z]+ita {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, past, level=1"));
    return PTCP1_INTR;
}
[a-z]+ida {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, past, level=1"));
    return PTCP1_TR;
}
[a-z]+onta {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, present, level=2"));
    return PTCP2_INTR;
}
[a-z]+onda {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, present, level=2"));
    return PTCP2_TR;
}
[a-z]+ota {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, past, level=2"));
    return PTCP2_INTR;
}
[a-z]+oda {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, past, level=2"));
    return PTCP2_TR;
}
[a-z]+unta {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, present, level=3"));
    return PTCP3_INTR;
}
[a-z]+unda {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, present, level=3"));
    return PTCP3_TR;
}
[a-z]+uta {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, past, level=3"));
    return PTCP3_INTR;
}
[a-z]+uda {
    yylval = mknode0(strjoin(yytext, ": participle, transitive, past, level=3"));
    return PTCP3_TR;
}
[a-z]+ianta {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, present, level=4"));
    return PTCP4_INTR;
}
[a-z]+iata {
    yylval = mknode0(strjoin(yytext, ": participle, intransitive, past, level=4"));
    return PTCP4_INTR;
}
[[:space:]]+ /* do nothing */
[^[:space:]]+ { wrong_word(); }

%%

void
wrong_word() {
    fprintf(stderr, "error: wrong word: ");
    /* filter out nonprintable characters */
    unsigned char c;
    int i;
    for (i = 0; i < strlen(yytext); i++) {
        c = yytext[i];
        if (c < ' ' || c > '~') {
            fprintf(stderr, "\\%X", c);
        } else if (c == '\\') {
            fprintf(stderr, "\\\\");
        } else {
            fprintf(stderr, "%c", c);
        }
    }
    fprintf(stderr, "\n");
    exit(1);
}

char *
strjoin(char *str1, char *str2) {
    char *str;
    if ((str = (char *)malloc(strlen(str1) + strlen(str2) + 1)) == NULL) {
        fprintf(stderr, "warning: not enough memory\n");
        abort();
    }
    strcpy(str, str1);
    strcat(str, str2);
    return str;
}

int
yywrap() {
    return 1;
}

int
yyerror (char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}
