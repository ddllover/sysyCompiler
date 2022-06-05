/*
CompUnit      ::= [CompUnit] (Decl | FuncDef);


Decl          : ConstDecl | VarDecl;

BType :INT;
ValType : |ArrayDef
ArrayDef : '[' ConstExp ']'|'[' ConstExp ']' ArrayDef

ConstDecl   :CONST BType ConstDef ';';
ConstDef      :ConstDefPart|ConstDefPart ',' ConstDef;
ConstDefPart :IDENT ValType '=' ConstInitVal;
ConstInitVal  :ConstExp|'{' '}' |'{'  ConstArrayVal '}'; 
ConstArrayVal: ConstInitVal | ConstInitval ',' ConstArrayVal;
ConstExp      :Exp;

VarDecl       : BType VarDef ';';
VarDef        : VarDefPart|VarDefPart ',' VarDef;
VarDefPart     :IDENT ValTpye|IDENT ValTpye "=" InitVal;
InitVal       : Exp | '{' '}'|'{' ArrayInitVal '}';
ArrayInitVal  : InitVal| InitVal ',' ArrayInitVal;

FuncDef       ::= FuncType IDENT "(" [FuncFParams] ")" Block;
FuncType      ::= "void" | "int";
FuncFParams   ::= FuncFParam {"," FuncFParam};
FuncFParam    ::= BType IDENT ["[" "]" {"[" ConstExp "]"}];

Block         ::= "{" {BlockItem} "}";
BlockItem     ::= Decl | Stmt;
Stmt          ::= LVal "=" Exp ";"
                | [Exp] ";"
                | Block
                | "if" "(" Exp ")" Stmt ["else" Stmt]
                | "while" "(" Exp ")" Stmt
                | "break" ";"
                | "continue" ";"
                | "return" [Exp] ";";

Exp           ::= LOrExp;
LVal          ::= IDENT {"[" Exp "]"};
PrimaryExp    ::= "(" Exp ")" | LVal | Number;
Number        ::= INT_CONST;
UnaryExp      ::= PrimaryExp | IDENT "(" [FuncRParams] ")" | UnaryOp UnaryExp;
UnaryOp       ::= "+" | "-" | "!";
FuncRParams   ::= Exp {"," Exp};
MulExp        ::= UnaryExp | MulExp ("*" | "/" | "%") UnaryExp;
AddExp        ::= MulExp | AddExp ("+" | "-") MulExp;
RelExp        ::= AddExp | RelExp ("<" | ">" | "<=" | ">=") AddExp;
EqExp         ::= RelExp | EqExp ("==" | "!=") RelExp;
LAndExp       ::= EqExp | LAndExp "&&" EqExp;
LOrExp        ::= LAndExp | LOrExp "||" LAndExp;

*/
/*
CompUnit    : Unit ;
Unit : (ConstDecl|ValDecl | FuncDef)|CompUnit  (Decl | FuncDef)

FuncDef     : (void|Btype) IDENT "(" FuncArgs ")" Block;

FuncFArgs :|FuncFParams
FuncFParams : FuncFParam| FuncFParam ',' FuncFParams;
FuncFParam  :BType IDENT;

FuncRParams ::= Exp | Exp ',' FuncRParams;
*/