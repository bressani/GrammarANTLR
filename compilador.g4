grammar compilador;

programa : package_expressao import_expressao* class_expressao*;

package_expressao: PACKAGEPR IDENTIFICADOR PV;
import_expressao : IMPORTPR IDENTIFICADOR (PONTO IDENTIFICADOR)* PV;

class_expressao : PUBLICPR CLASSPR IDENTIFICADOR AC (metodo|atributo)* FC; 

metodo : visibilidade tipo_retorno IDENTIFICADOR AP parametros? FP AC expressoes* FC;
atributo: visibilidade tipo IDENTIFICADOR PV;
tipo_retorno : tipo | VOIDPR;
visibilidade : PUBLICPR | PRIVATEPR;
parametros : tipo IDENTIFICADOR (V tipo IDENTIFICADOR)*;

expressoes : declaracao | expressao | if_expressao | 
             while_expressao | break_expressao | return_expressao | 
             print_expressao | do_while_expressao | system_expressao;

declaracao : tipo IDENTIFICADOR (OP_ATRIBUICAO valor)? PV |
             tipo ACOL FCOL IDENTIFICADOR OP_ATRIBUICAO NEWPR tipo ACOL valor FCOL PV;

tipo : INTPR | FLOATPR | DOUBLEPR | CHARPR | STRINGPR;

valor : NUMERO | IDENTIFICADOR;

expressao : IDENTIFICADOR OP_ATRIBUICAO valor OP_ARITMETICO valor PV |
            IDENTIFICADOR OP_ATRIBUICAO valor PV;

if_expressao : IFPR AP expr_logica FP AC expressoes* FC
               (ELSEPR IFPR AP expr_logica FP AC expressoes* FC)*
               (ELSEPR AC expressoes*  FC)?;

do_while_expressao: DOPR AC (expressoes)* FC WHILEPR AP expr_logica FP PV;

while_expressao : WHILEPR AP expr_logica FP AC expressoes* FC;

for_expressao : FORPR AP parentesis_for  FP AC expressoes* FC ;
parentesis_for: tipo IDENTIFICADOR OP_ATRIBUICAO valor PV IDENTIFICADOR OP_LOGICO valor PV IDENTIFICADOR OP_INCREMENTO;

break_expressao : BREAKPR PV;

return_expressao : return_expression;
return_expression: RETURNPR valor PV| RETURNPR THISPR PONTO IDENTIFICADOR PV;

expr_logica : valor OP_LOGICO valor;
system_expressao: SYSTEMPR (PONTO sytem_tipo PONTO print_expressao)* PV;
sytem_tipo: OUTPR;
print_expressao: PRINTPR AP IDENTIFICADOR FP;

AP : '(';
FP : ')';
AC : '{';
FC : '}';
ACOL: '[';
FCOL: ']';
OP_INCREMENTO: '++';
OP_LOGICO : '==' | '<' | '>' | '<=' | '>=';
OP_ARITMETICO : '*' | '-' | '+';
PV : ';';
V : ',';
PONTO : '.';
OP_ATRIBUICAO : '=';
PACKAGEPR: 'package';
IMPORTPR : 'import';
CLASSPR : 'class';
NEWPR: 'new';
BREAKPR : 'break';
VOIDPR : 'void';
PUBLICPR : 'public';
PRIVATEPR : 'private';
INTPR : 'int';
STRINGPR: 'String';
WHILEPR : 'while';
FORPR: 'for';
DOPR: 'do';
FLOATPR : 'float';
DOUBLEPR : 'double';
CHARPR : 'char';
RETURNPR : 'return';
IFPR : 'if';
ELSEPR : 'else';
IDENTIFICADOR : [a-zA-Z]([a-zA-Z]|[0-9])*;
NUMERO : [0-9]+;
SYSTEMPR: 'System';
OUTPR: 'out';
PRINTPR: 'println';
THISPR: 'this';

//WS : [ \t\r\n]+ -> skip;
WS  :  [ \t\r\n\u000C]+ -> skip
    ;
