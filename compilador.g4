grammar compilador;

application : package_exp? import_exp* class_exp*;

package_exp: PACKAGEPR IDENTIFICADOR PV;
import_exp : IMPORTPR IDENTIFICADOR (PONTO IDENTIFICADOR)* PV;

class_exp : PUBLICPR CLASSPR IDENTIFICADOR AC (exps)* FC;

method_declaration : visibility tipo_retorno IDENTIFICADOR AP parametros? FP AC exps* FC;

tipo_retorno : type | VOIDPR;
visibility : PUBLICPR | PRIVATEPR;
parametros : type IDENTIFICADOR (V type IDENTIFICADOR)*;

methods : switch_exp| if_exp | while_exp | do_while_exp | methodo_call PV | for_exp;

exps: methods | return_exp | system_println_exp | exp_math_or_att  | var_declaration | method_declaration | methodo_call PV;

var_declaration : visibility? type IDENTIFICADOR (OP_ATRIBUICAO value)? PV |
array | object;

array : visibility? type ACOL FCOL IDENTIFICADOR OP_ATRIBUICAO NEWPR type ACOL value FCOL PV;

array_call : IDENTIFICADOR ACOL (IDENTIFICADOR | NUMERO) FCOL;

object : visibility? IDENTIFICADOR IDENTIFICADOR (OP_ATRIBUICAO NEWPR IDENTIFICADOR AP((TIPO VALOR (V TIPO VALOR)*)?)FP)? PV;

methodo_call : IDENTIFICADOR PONTO IDENTIFICADOR (PONTO IDENTIFICADOR)* (AP? (value | IDENTIFICADOR |
 array_call)? FP?)? | IDENTIFICADOR AP FP;

type : INTPR | FLOATPR | DOUBLEPR | CHARPR | STRINGPR | object;

value : NUMERO | IDENTIFICADOR | ASPAS IDENTIFICADOR ASPAS | IDENTIFICADOR ACOL IDENTIFICADOR ACOL;

exp_math_or_att : IDENTIFICADOR OP_ATRIBUICAO value OP_ARITMETICO value PV |
            IDENTIFICADOR OP_ATRIBUICAO value PV | methodo_call OP_ATRIBUICAO IDENTIFICADOR PV;

if_exp : IFPR AP logical_exp FP AC exps* FC
               (ELSEPR IFPR AP logical_exp FP AC exps* FC)*
               (ELSEPR AC exps*  FC)?;

do_while_exp: DOPR AC (exps)* FC WHILEPR AP logical_exp FP PV;

while_exp : WHILEPR AP logical_exp FP AC exps* FC;

for_exp : FORPR AP parentesis_for FP AC exps* FC ;
parentesis_for: type? IDENTIFICADOR OP_ATRIBUICAO? value? PV IDENTIFICADOR OP_LOGICO (value | IDENTIFICADOR | methodo_call)
PV IDENTIFICADOR OP_INCREMENTO;

break_exp : BREAKPR PV;

return_exp: RETURNPR value PV| RETURNPR methodo_call PV;

logical_exp : value OP_LOGICO value (OP_LOGICO value OP_LOGICO value)*;
system_println_exp: SYSTEMPR (PONTO sytem_tipo PONTO print_exp)* PV;
sytem_tipo: OUTPR;
print_exp: PRINTPR AP IDENTIFICADOR ACOL? IDENTIFICADOR? FCOL? FP;

this_exp: THISPR PONTO IDENTIFICADOR OP_ATRIBUICAO IDENTIFICADOR PV;

switch_exp: SWITCHPR AP IDENTIFICADOR FP AC case_exp* FC;

case_exp: CASEPR NUMERO DOIS_PONTOS exps BREAKPR PV ;

AP : '(';
FP : ')';
AC : '{';
FC : '}';
ACOL: '[';
FCOL: ']';
OP_INCREMENTO: '++';
OP_LOGICO : '==' | '<' | '>' | '<=' | '>=' | '&&';
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
SETPR: 'set';
ASPAS : '"';
DOIS_PONTOS: ':';
SWITCHPR : 'switch';

//WS : [ \t\r\n]+ -> skip;
WS  :  [ \t\r\n\u000C]+ -> skip;
