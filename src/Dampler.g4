grammar Dampler;


program: stat+ EOF;

stat: type ID (ASSIGN expr)? SEMI         #decl
    | target ASSIGN expr SEMI             #assignStat
    | IF LPAR expr RPAR stat (ELSE stat)? #ifStat
    | WHILE LPAR expr RPAR stat           #whileStat
    | LCURLY stat* RCURLY                 #blockStat
//    | PRINT LPAR STRING (COMMA ID)* RPAR SEMI #printStat
//    | BREAK SEMI                          #breakStat
//    | CONTINUE SEMI                       #contStat
    ;

target
    : ID                            #idTarget
    ;

expr: expr DOT ID                   #fieldExpr
    | NOT expr                      #notExpr
    | expr PLUS expr                #addExpr
    | expr MINUS expr               #minExpr
    | expr MULT expr                #multExpr
    | expr AND expr                 #andExpr
    | expr OR  expr                 #orExpr
    | expr (LT | GT | EQ | NE) expr #compExpr
    | LPAR expr RPAR                #parExpr
    | (NUM | TRUE | FALSE)          #constExpr
    | ID                            #idExpr
    ;

type: INT | BOOL;

DOT: '.';
SEMI: ';';
COMMA: ',';
ASSIGN: '=';
NOT: '!';
OR: '|';
AND: '&';
PLUS: '+';
MINUS: '-';
MULT: '*';
LT: '<';
GT: '>';
EQ: '==';
NE: '!=';
LCURLY: '{';
RCURLY: '}';
LPAR: '(';
RPAR: ')';

//PRINT: 'printf';
BOOL: 'boolean';
INT: 'int';
WHILE: 'while';
IF: 'if';
ELSE: 'else';
TRUE: 'true';
FALSE: 'false';
//BREAK: 'break';
//CONTINUE: 'continue';

fragment LETTER: [a-zA-Z];
fragment DIGIT: [0-9];

ID: LETTER (LETTER | DIGIT)*;
NUM: DIGIT+;

WS: [ \t\r\n]+ -> skip;
