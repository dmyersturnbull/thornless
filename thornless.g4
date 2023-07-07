
grammar thornless ;

vector_expr
   : MINUS vector_expr                                                       # vecExprMinus
   | LEFT vector_expr RIGHT                                                  # vecExprAtom
   | vector_expr pow_op float_expr                                           # vecExprPow
   | vector_expr factor_op vector_expr                                       # vecExprFactor
   | vector_expr term_op vector_expr                                         # vecExprTerm
   | vector_function                                                         # vecExprFunc
   | vector_atom                                                             # vecExprAtom
   ;

float_expr
   : MINUS float_expr                                                        # floatExprMinus
   | LEFT float_expr RIGHT                                                   # floatExprAtom
   | float_expr pow_op float_expr                                            # floatExprPow
   | float_expr factor_op float_expr                                         # floatExprFactor
   | float_expr term_op float_expr                                           # floatExprTerm
   | float_function                                                          # floatExprFromFunc
   | float_atom                                                              # floatExprAtom
   ;

bool_expr
   : NOT bool_expr                                                           # boolExprNot
   | LEFT bool_expr RIGHT                                                    # boolExprAtom
   | float_expr comp_op float_expr                                           # boolExprComp
   | bool_expr bool_op bool_expr                                             # boolExprLogical
   | bool_expr term_op bool_expr                                             # boolExprTerm
   | bool_function                                                           # boolExprFunc
   | bool_atom                                                               # boolExprAtom
   ;

vector_function
   : float_func_f LEFT vector_expr RIGHT                                     # vectorFuncV
   | 'bound' LEFT vector_expr COMMA float_atom COMMA float_atom RIGHT        # vectorFuncBound
   | 'format' LEFT (vector_expr COMMA format_spec)? RIGHT                    # vectorFuncFormat
   | 'if' LEFT bool_expr QUESTION vector_expr (COLON vector_expr)? RIGHT     # vectorFuncIf
   ;

bool_function
   : bool_func_v LEFT vector_expr RIGHT                                       # boolFuncV
   ;

float_function
   : float_func_f LEFT float_expr RIGHT                                      # floatFuncF
   | float_func_fi LEFT float_expr RIGHT                                     # floatFuncFI
   | float_func_v LEFT vector_expr RIGHT                                     # floatFuncV
   | float_func_vv LEFT vector_expr RIGHT                                    # floatFuncVV
   | 'bound' LEFT float_expr COMMA float_atom COMMA float_atom RIGHT         # floatFuncBound
   | 'format' LEFT (float_expr COMMA format_spec)? RIGHT                     # floatFuncFormat
   | 'if' LEFT bool_expr QUESTION float_expr (COLON float_expr)? RIGHT       # floatFuncIf
   ;

vector_literal
   : LBRACK float_atom (COMMA float_atom)* RBRACK
   ;

format_spec
   : QUOTE DIGITS DOT DIGITS QUOTE
   ;

float_func_f
   : 'sin' | 'cos' | 'tan' | 'sec' | 'csc' | 'cot'
   | 'asin' | 'acos' | 'atan' | 'atan2' | 'asec' | 'acsc' | 'acot'
   | 'sinh' | 'cosh' | 'tanh' | 'sech' | 'csch' | 'coth'
   | 'asinh' | 'acosh' | 'atanh' | 'asech' | 'acsch' | 'acoth'
   | 'erf' | 'erfc' | 'gamma'
   | 'exp' | 'exp2' | 'exp10' | 'exp1m' | 'scaleb'
   | 'ln' | 'log2' | 'log10' | 'ln1p'
   | 'round' | 'floor' | 'ceil'
   | 'sqrt' | 'cbrt'
   | 'abs' | 'bool' | 'sgn' | 'signum'
   ;

float_func_fi
   : 'bit_rshift' | 'bit_lshift'
   ;

float_func_v
   : 'length' | 'sum' | 'product' | 'logsum' | 'geomean' | 'hypot'
   | 'mean' | 'median' | 'stddev' | 'skewness'
   | 'bit_and' | 'bit_or' | 'bit_nand' | 'bit_nor' | 'bit_xor' | 'bit_nxor'
   ;

float_func_vv
   : 'dot'
   ;

bool_func_v
   : 'all' | 'any' | 'none'
   ;

vector_atom
   : vector_literal           # vectorAtomLiteral
   | float_expr               # vectorAtomFloat
   | VARIABLE                 # vectorAtomVar
   ;

float_atom
   : float                    # floatAtomLiteral
   | VARIABLE                 # floatAtomVar
   ;

int_atom
   : INT                      # intAtomLiteral
   | VARIABLE                 # intAtomVar
   ;

bool_atom
   : BOOL                     # boolAtomLiteral
   | VARIABLE                 # boolAtomVar
   ;

float
   : FLOAT                    # floatLiteral
   | FLOAT 'E' MINUS? DIGITS  # floatScientific
   | CONST                    # floatConst
   ;

pow_op: SPACE* POW SPACE* ;

comp_op: SPACE* op=(EQ | NEQ | LEQ | GEQ | LT | GT | AEQ | NAEQ) SPACE* ;

bool_op: SPACE* op=(AND | OR | NAND | NOR | XOR | NXOR) SPACE* ;

term_op: SPACE* op=(PLUS | MINUS) SPACE* ;

factor_op: SPACE* op=(TIMES | DIV | MOD) SPACE* ;

CONST: 'NaN' | 'Inf' | 'PI' | 'SQRT2' | 'LN2' ;

VARIABLE: '$' [-.a-z0-9]+ ;

FLOAT: MINUS? DIGITS (DOT [0-9] +)? ;

INT: MINUS? DIGITS ;

BOOL: 'true' | 'false' ;

DIGITS: [0-9] ;

DOT: '.' ;
COMMA: ',' ;
QUESTION: '?' ;
COLON: ':' ;
QUOTE: '"' ;

LBRACK: '[' ;
RBRACK: ']' ;
LEFT: '(' ;
RIGHT: ')' ;

POW: '^' ;

TIMES: '*' ;
DIV: '/' ;
MOD: '%' ;

PLUS: '+' ;
MINUS: '-' ;

EQ : '=' ;
NEQ: '!=' ;
AEQ : '~=' ;
NAEQ: '!~=' ;
LEQ: '<=' ;
GEQ: '>=' ;
LT: '<' ;
GT: '>' ;

NOT: '!' ;

AND: '&&' ;
OR: '||' ;
NAND: '!&&' ;
NOR: '!||' ;
XOR: '^^' ;
NXOR: '!^^' ;

SPACE: ' ' ;
