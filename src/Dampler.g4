grammar Dampler;

program: stat+ EOF;

stat: type ID (ASSIGN expr)? SEMI           #decl
	| type SHARED ID (ASSIGN expr)? SEMI 	#sharedDeclStat
    | target ASSIGN expr SEMI               #assignStat
    | IF LPAR expr RPAR block (ELSE block)? #ifStat
    | WHILE LPAR expr RPAR block            #whileStat
    | block                                 #blockStat
    | FORK ID block							#forkStat
    | ID DOT JOIN							#joinStat
    | SYNC block							#syncStat
//    | PRINT LPAR STRING (COMMA ID)* RPAR SEMI #printStat
//    | BREAK SEMI                          #breakStat
//    | CONTINUE SEMI                       #contStat
    ;

block
    : LCURLY stat* RCURLY;

target
    : ID                            #idTarget
    ;

expr: expr DOT ID                   #fieldExpr
    | NOT expr                      #notExpr
    | MINUS expr                    #unMinExpr
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
WHILE: 'repeat';
IF: 'if';
ELSE: 'else';
TRUE: 'true';
SHARED: 'shrd';
FALSE: 'untrue';
FORK: 'fork';
JOIN: 'join';
SYNC: 'sync';
//BREAK: 'break';
//CONTINUE: 'continue';

fragment LETTER: [a-zA-Z];
fragment DIGIT: [0-9];

ID: LETTER (LETTER | DIGIT)*;
NUM: DIGIT+;

WS: [ \t\r\n]+ -> skip;
