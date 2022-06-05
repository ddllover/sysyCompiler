%code requires {
  #include <memory>
  #include <cstring>
  #include"ast.h"
}

%{

#include <iostream>
#include <memory>
#include <cstring>
#include"ast.h"
// 声明 lexer 函数和错误处理函数
int yylex();
void yyerror(std::unique_ptr<Baseast> &ast, const char *s);

using namespace std;

%}

// 定义 parser 函数和错误处理函数的附加参数
// 我们需要返回一个字符串作为 ast, 所以我们把附加参数定义成字符串的智能指针
// 解析完成后, 我们要手动修改这个参数, 把它设置成解析得到的字符串
%union {
  std::string *str_val;
  int int_val;
  Baseast *ast_val;
}

%parse-param { std::unique_ptr<Baseast> &ast }


// lexer 返回的所有 token 种类的声明
// 注意 IDENT 和 INT_CONST 会返回 token 的值, 分别对应 str_val 和 int_val
%token INT RETURN LREL RREL EQ NEQ AND OR 
//4.1
%token CONST
//6 7
%token WHILE IF BREAK CONTINUE ELSE
//8
%token VOID
%token <str_val> IDENT
%token <int_val> INT_CONST

// 非终结符的类型定义
%type <ast_val> FuncDef Block Stmt Exp PrimaryExp UnaryExp UnaryOp AddExp MulExp AddOp MulOp
%type <ast_val> RelExp EqExp LAndExp LOrExp Relop Eqop 
//4.1
%type <ast_val> Decl ConstDecl BType  ConstDef ConstInitVal BlockItem LVal  ConstExp
//4.2
%type <ast_val> VarDecl VarDef InitVal
//6 7
%type <ast_val>  Exma UExma
%type <int_val> Number
//8
%type <ast_val> CompUnit Unit FuncArgs FuncFParams FuncFParam FuncRParams

%right ELSE
%%
//CompUnit:Unit| FuncDef;
AST:
  CompUnit{
    auto final_ast=make_unique<AST>();
    final_ast->compunit=unique_ptr<Baseast>($1);
    ast=move(final_ast); 
  };

CompUnit: 
  Unit
   {
    auto ast = new CompUnitast();
    ast->kind=1;
    ast->unit = unique_ptr<Baseast>($1);  
    $$=ast;
  }
  | CompUnit Unit{
    auto ast = new CompUnitast();
    ast->kind=2;
    ast->compunit=unique_ptr<Baseast>($1); 
    ast->unit = unique_ptr<Baseast>($2); 
    $$=ast;
  };

//Unit :FuncDef|VarDecl|ConstDecl;  //全局变量
Unit:
  FuncDef 
  {
    auto ast=new Unitast();;
    ast->kind=1;
    ast->funcdef=unique_ptr<Baseast> ($1);
    $$=ast;
  }
  |VarDecl {
    auto ast=new Unitast();
    ast->kind=2;
    ast->vardecl=unique_ptr<Baseast>($1);
    $$=ast;
  }
  |ConstDecl{
    auto ast=new Unitast();
    ast->kind=3;
    ast->constdecl=unique_ptr<Baseast>($1);
    $$=ast;
  }
  ;


//FuncDef     ::= Void IDENT "(" FuncArgs ")" Block|Btpye IDENT "(" FuncArgs")" Block ;
FuncDef: 
  VOID IDENT '(' FuncArgs ')' Block {
    auto ast = new FuncDefast();
    ast->kind=1;
    
    ast->ident = *unique_ptr<string>($2);
    ast->funcargs=unique_ptr<Baseast>($4);
    ast->block = unique_ptr<Baseast>($6);
    $$ = ast;
  }
  |BType IDENT '('FuncArgs ')' Block{
    auto ast = new FuncDefast();
    ast->kind=2;
    ast->btype = unique_ptr<Baseast>($1);
    ast->ident = *unique_ptr<string>($2);
    ast->funcargs=unique_ptr<Baseast>($4);
    ast->block = unique_ptr<Baseast>($6);
    $$ = ast;
  }
  ;
//FuncArgs :|FuncFParams
FuncArgs:
  {
    auto ast=new FuncArgsast();
    ast->kind=1;
    $$=ast;
  }
  |FuncFParams{
    auto ast=new FuncArgsast();
    ast->kind=2;
    ast->funcfparams=unique_ptr<Baseast>($1);
    $$=ast;
  }
//FuncFParams : FuncFParam| FuncFParam ',' FuncFParams;
FuncFParams : 
  FuncFParam
  {
    auto ast=new FuncFParamsast();
    ast->kind=1;
    ast->funcfparam=unique_ptr<Baseast>($1);
    $$=ast;
  }
  | FuncFParam ',' FuncFParams{
    auto ast=new FuncFParamsast();
    ast->kind=2;
    ast->funcfparam=unique_ptr<Baseast>($1);
    ast->funcfparams=unique_ptr<Baseast>($3);
    $$=ast;
  };
//FuncFParam  :BType IDENT;
FuncFParam  :
  BType IDENT{
    auto ast=new FuncFParamast();
    ast->kind=1;
    ast->btype=unique_ptr<Baseast>($1);
    ast->ident=*unique_ptr<string>($2);
    $$=ast;
  };

//Decl          ::= ConstDecl| VarDecl;
Decl : 
  ConstDecl
  {
    auto ast=new Declast();
    ast->kind=1;
    ast->constdecl=unique_ptr<Baseast>($1);
    $$= ast;
  }
  | VarDecl
  {
    auto ast=new Declast();
    ast->kind=2;
    ast->vardecl=unique_ptr<Baseast>($1);
    $$=ast;
  }
  ;

//ConstDecl     ::= "const" BType ConstDef {"," ConstDef} ";";
ConstDecl: 
  CONST BType ConstDef  ';'
  {
    auto ast=new ConstDeclast();
    ast->kind=1;
    ast->btype=unique_ptr<Baseast>($2);
    ast->constdef=unique_ptr<Baseast>($3);
    $$=ast;
  }
  ;

//BTpye 
BType:
 INT{
   auto ast=new BTypeast();
   ast->kind=1;
   ast->str="i32";
   $$=ast;
 };
//ArrayDef:'[' ConstExp ']'| '[' ConstExp ']' ArrayDef
//ArrayDef:

//ConstDef      ::= IDENT "=" ConstInitVal;
ConstDef:
  IDENT '=' ConstInitVal
  {
    
    auto ast=new ConstDefast();
    ast->kind=1;
    ast->ident=*unique_ptr<string>($1);
    ast->constinitval=unique_ptr<Baseast>($3);
    $$=ast;
  } 
  | IDENT '=' ConstInitVal ',' ConstDef
  {
    
    auto ast=new ConstDefast();
    ast->kind=2;
    ast->ident=*unique_ptr<string>($1);
    ast->constinitval=unique_ptr<Baseast>($3);
    ast->constdef=unique_ptr<Baseast> ($5);
    $$=ast;
  }
  ;

//ConstInitVal  ::= ConstExp;


ConstInitVal  : 
  ConstExp
  {
    auto ast=new ConstInitValast();
    ast->kind=1;
    ast->constexp=unique_ptr<Baseast> ($1);
    $$=ast;
  }
;
//ConstExp      ::= Exp;
ConstExp: 
  Exp{
  auto ast=new ConstExpast();
  ast->kind=1;
  ast->exp=unique_ptr<Baseast>($1);
  $$=ast;
  };

//VarDecl       ::= BType VarDef ";";
VarDecl:
   BType VarDef ';'{
     auto ast=new VarDeclast();
     ast->kind=1;
     ast->btype=unique_ptr<Baseast>($1);
     ast->vardef=unique_ptr<Baseast>($2);
     $$=ast;
   }

;
 
//VarDef: VarDefPart|VarDefPart ',' VarDef
//VarDefPart: ValueName| ValueName "=" Initval 
//ValueName: IDENT| IDENT ArrayDef


//VarDef        ::= IDENT | IDENT "=" InitVal|IDENT ',' VarDef|IDENT '=' InitVal ',' VarDef;
VarDef:
  IDENT{
    auto ast=new VarDefast();
    ast->kind=1;
    ast->ident=*unique_ptr<string>($1);
    $$=ast;
  }
  |IDENT '=' InitVal {
    auto ast=new VarDefast();
    ast->kind=2;
    ast->ident=*unique_ptr<string>($1);
    ast->initval=unique_ptr<Baseast>($3);
    $$=ast;
  }
  | IDENT ',' VarDef{
    auto ast=new VarDefast();
    ast->kind=3;
    ast->ident=*unique_ptr<string>($1);
    ast->vardef=unique_ptr<Baseast>($3);
    $$=ast;
  }
  | IDENT '=' InitVal ',' VarDef{
    auto ast=new VarDefast();
    ast->kind=4;
    ast->ident=*unique_ptr<string>($1);
    ast->initval=unique_ptr<Baseast>($3);
    ast->vardef=unique_ptr<Baseast>($5);
    $$=ast;
  }
  ;

//InitVal       ::= Exp;
InitVal:
  Exp{
    auto ast=new InitValast();
    ast->kind=1;
    ast->exp=unique_ptr<Baseast>($1);
    $$=ast;
  };


//Block         ::= "{" {BlockItem} "}";
Block: 
  '{' BlockItem '}' {
    auto ast = new Blockast();
    ast->kind=1;
    ast->blockitem=unique_ptr<Baseast>($2);
    $$ = ast;
  }
;
//BlockItem     ::= |Decl BlockItem| Stmt BlockItem;
BlockItem : 
  {
    auto ast=new BlockItemast();
    ast->kind=1;
    $$=ast;
  }
  |Decl  BlockItem{
    auto ast=new BlockItemast();
    ast->kind=2;
    ast->decl=unique_ptr<Baseast>($1);
    ast->blockitem=unique_ptr<Baseast>($2);
    $$=ast;
  }
  | Stmt BlockItem{
    auto ast=new BlockItemast();
    ast->kind=3;
    ast->stmt=unique_ptr<Baseast>($1);
    ast->blockitem=unique_ptr<Baseast>($2);
    $$=ast;
  }
;
//LVal          ::= IDENT;
LVal: 
  IDENT{
    auto ast=new LValast();
    ast->kind=1;
    ast->ident=*unique_ptr<string>($1);
    $$=ast;
  }
;
//PrimaryExp    ::= "(" Exp ")" | LVal | Number;
PrimaryExp: 
  '(' Exp ')' {
      auto ast=new PrimaryExpast();
      ast->kind=1;
      ast->exp=unique_ptr<Baseast>($2);
      $$=ast;
  }
  | Number{
    auto ast=new PrimaryExpast();
    ast->kind=2;
    ast->number=$1;
    $$=ast;
  }
  | LVal{
    auto ast=new PrimaryExpast();
    ast->kind=3;
    ast->lval=unique_ptr<Baseast>($1);
    $$=ast;
  }
;

//stmt : Exma | UExma
Stmt:
  Exma{
    auto ast=new Stmtast();
    ast->kind=1;
    ast->exma=unique_ptr<Baseast>($1);
    $$=ast;
   }
  | UExma
  { 
    auto ast=new Stmtast();
    ast->kind=2;
    ast->uexma=unique_ptr<Baseast>($1);
    $$=ast;
  };

//UExma ->  WHILE '(' Exp ')' UExma|IF '(' Exp ')' Stmt | IF '(' Exp ')' Exma ELSE UExma |

UExma:
  WHILE '(' Exp ')' UExma
  {
    auto ast=new UExmaast();
    ast->kind=1;
    ast->exp=unique_ptr<Baseast>($3);
    ast->uexma=unique_ptr<Baseast>($5);
    $$=ast;
  }
  | IF '(' Exp ')' Stmt
  { 
    auto ast=new UExmaast();
    ast->kind=2;
    ast->exp=unique_ptr<Baseast>($3);
    ast->stmt=unique_ptr<Baseast>($5);
    $$=ast;
  }
  | IF '(' Exp ')' Exma ELSE UExma
  {
    auto ast=new UExmaast();
    ast->kind=3;
    ast->exp=unique_ptr<Baseast>($3);
    ast->exma=unique_ptr<Baseast>($5);
    ast->uexma=unique_ptr<Baseast>($7);
    $$=ast;
  }
  ;

//Exma          ::= return';'|"return" Exp ";"|LVal "=" Exp ";"| ';'|Exp ";"|block
//  | IF '(' Exp ')' Exma ELSE Exma   | WHILE '(' Exp ')' Exma | BREAK ';' | CONTINUE ';'
Exma: 
  RETURN ';'{
    auto ast=new Exmaast();
    ast->kind=1;
    $$=ast;
  }
  |RETURN Exp ';' {
    auto ast=new Exmaast();
    ast->kind=2;
    ast->exp =unique_ptr<Baseast>($2);
    $$ = ast;
  }
  | LVal '=' Exp ';'{
    auto ast=new Exmaast();
    ast->kind=3;
    ast->lval=unique_ptr<Baseast>($1);
    ast->exp=unique_ptr<Baseast>($3);
    $$=ast;
  }
  | ';'
  {
    auto ast=new Exmaast();
    ast->kind=4;
    $$=ast;
  }
  | Exp ';'
  {
    auto ast=new Exmaast();
    ast->kind=5;
    ast->exp=unique_ptr<Baseast>($1);
    $$=ast;
  }
  |Block
  {
    auto ast=new Exmaast();
    ast->kind=6;
    ast->block=unique_ptr<Baseast>($1);
    $$=ast;
  }
  | IF '(' Exp ')' Exma ELSE Exma
  {
    auto ast=new Exmaast();
    ast->kind=7;
    ast->exp=unique_ptr<Baseast>($3);
    ast->exma_if=unique_ptr<Baseast>($5);
    ast->exma_else=unique_ptr<Baseast>($7);
    $$=ast;
  }
  | WHILE '(' Exp ')' Exma
  {
    auto ast=new Exmaast();
    ast->kind=8;
    ast->exp=unique_ptr<Baseast>($3);
    ast->exma_while=unique_ptr<Baseast>($5);
    $$=ast;
  }
  | BREAK ';'
  {
    auto ast=new Exmaast();
    ast->kind=9;
    $$=ast;
  }
  | CONTINUE ';'
  {
    auto ast=new Exmaast();
    ast->kind=10;
    $$=ast;
  }
  ;



Exp: 
  LOrExp{
    auto ast=new Expast();
    ast->lorExp=unique_ptr<Baseast>($1);
    $$=ast;

  }
  ;



Number
  : INT_CONST {
    $$ = $1;
  }
  ;
//UnaryExp    : PrmaryExp|UnaryOp UnaryExp | IDENT '(' ')'|IDENT '(' FuncRParams')';
UnaryExp:
  PrimaryExp {
    auto ast=new UnaryExpast();
    ast->kind=1;
    ast->primary=unique_ptr<Baseast>($1);
    $$=ast;
  }
  | UnaryOp UnaryExp{
     auto ast=new UnaryExpast();
     ast->kind=2;
     ast->unaryop=unique_ptr<Baseast>($1);
     ast->unaryexp=unique_ptr<Baseast>($2);
     $$=ast;
  }
  | IDENT '(' ')'{
    auto ast=new UnaryExpast();
     ast->kind=3;
     ast->ident=*unique_ptr<string> ($1);
     $$=ast;
  }
  |IDENT '(' FuncRParams')'{
    auto ast=new UnaryExpast();
     ast->kind=4;
     ast->ident=*unique_ptr<string> ($1);
     ast->funcrparams=unique_ptr<Baseast>($3);
     $$=ast;
  }
  ;
//FuncRParams:Exp|Exp ',' FuncRParams
FuncRParams:
  Exp{
    auto ast=new FuncRParamsast();
    ast->kind=1;
    ast->exp=unique_ptr<Baseast>($1);
    $$=ast;
  } 
  | Exp ',' FuncRParams{
    auto ast=new FuncRParamsast();
    ast->kind=2;
    ast->exp=unique_ptr<Baseast>($1);
    ast->funcrparams=unique_ptr<Baseast>($3);
    $$=ast;
  };

UnaryOp:
  '+' {
    auto ast=new Opast();
    ast->kind=1;
    ast->str='+';
    $$=ast;
  }
  | '-'{
    auto ast=new Opast();
    ast->kind=2;
    ast->str="sub";
    $$=ast;
  } 
  | '!'{
    auto ast=new Opast();
    ast->kind=3;
    ast->str="eq";
    $$=ast;
  }
  ;


MulExp:
  UnaryExp{
    auto ast=new MulExpast();
    ast->kind=1;
    ast->unaryExp=unique_ptr<Baseast>($1);
    $$=ast;
  }
  | MulExp  MulOp UnaryExp{
    auto ast=new MulExpast();
    ast->kind=2;
    ast->mulExp=unique_ptr<Baseast> ($1);
    ast->mulop=unique_ptr<Baseast> ($2);
    ast->unaryExp=unique_ptr<Baseast>($3);
    $$=ast;
  }
  ;

MulOp:
  '*'{
  auto ast=new Opast();
  ast->kind=1;
  ast->str="mul";
  $$=ast;
  } 
  | '/'
  {
    auto ast=new Opast();
    ast->kind=2;
    ast->str="div";
    $$=ast;
  } 
  | '%'
  {
    auto ast=new Opast();
    ast->kind=3;
    ast->str="mod";
    $$=ast;
  }
  ;


AddExp:
 MulExp{
   auto ast=new AddExpast();
   ast->kind=1;
   ast->mulExp=unique_ptr<Baseast>($1);
   $$=ast;
 }
  | AddExp AddOp MulExp{
    auto ast=new AddExpast();
    ast->kind=2;
    ast->addExp=unique_ptr<Baseast>($1);
    ast->addOp=unique_ptr<Baseast>($2);
    ast->mulExp=unique_ptr<Baseast>($3);
    $$=ast;
  }
  ;

AddOp:
  '+'
  {
    auto ast=new Opast();
    ast->kind=1;
    ast->str="add";
    $$=ast;
  } 
  | '-'
  {
    auto ast=new Opast();
    ast->kind=2;
    ast->str="sub";
    $$=ast;
  };


RelExp:
  AddExp
  {
    auto ast=new RelExpast();
    ast->kind=1;
    ast->addexp=unique_ptr<Baseast>($1);
    $$=ast;
  } 
  | RelExp Relop AddExp
  {
    auto ast=new RelExpast();
    ast->kind=2;
    ast->relexp=unique_ptr<Baseast>($1);
    ast->relop=unique_ptr<Baseast>($2);
    ast->addexp=unique_ptr<Baseast>($3);
    $$=ast;
  }
  ;

Relop:
  '<'
  {
    auto ast=new Opast();
    ast->kind=1;
    ast->str="lt";
    $$=ast;
  } 
  | '>' 
  {
    auto ast=new Opast();
    ast->kind=2;
    ast->str="gt";
    $$=ast;
  }
  | LREL
  {
    auto ast=new Opast();
    ast->kind=3;
    ast->str="le";
    $$=ast;
  }
  | RREL
  {
    auto ast=new Opast();
    ast->kind=4;
    ast->str="ge";
    $$=ast;
  }
  ;

//EqExp       ::= RelExp | EqExp ("==" | "!=") RelExp;

EqExp:
  RelExp
  {
    auto ast=new EqExpast();
    ast->kind=1;
    ast->relexp=unique_ptr<Baseast>($1);
    $$=ast;
  }
  | EqExp Eqop RelExp
  {
    auto ast=new EqExpast();
    ast->kind=2;
    ast->eqexp=unique_ptr<Baseast>($1);
    ast->eqop=unique_ptr<Baseast>($2);
    ast->relexp=unique_ptr<Baseast>($3);
    $$=ast;
  }
  ;
Eqop:
  EQ
  {
    auto ast=new Opast();
    ast->kind=1;
    ast->str="eq";
    $$=ast;
  }
  | NEQ
  {
    auto ast=new Opast();
    ast->kind=2;
    ast->str="ne";
    $$=ast;
  }
  ;
//LAndExp     ::= EqExp | LAndExp "&&" EqExp;

LAndExp:
  EqExp
  {
    auto ast=new LAndExpast();
    ast->kind=1;
    ast->eqexp=unique_ptr<Baseast>($1);
    $$=ast;
  }
  | LAndExp AND EqExp{
    auto ast=new LAndExpast();
    ast->kind=2;
    ast->landexp=unique_ptr<Baseast>($1);
    //ast->op=unique_ptr<Baseast> ($2);
    ast->eqexp=unique_ptr<Baseast>($3);
    $$=ast;
  }
  ;


//LOrExp      ::= LAndExp | LOrExp "||" LAndExp;

LOrExp:
  LAndExp{
    auto ast=new LOrExpast();
    ast->kind=1;
    ast->landexp=unique_ptr<Baseast>($1);
    $$=ast;

  }
  |LOrExp OR LAndExp{
    auto ast=new LOrExpast();
    ast->kind=2;
    ast->lorexp=unique_ptr<Baseast>($1);
    //ast->op=unique_ptr<Baseast>($2);
    ast->landexp=unique_ptr<Baseast>($3);
    $$=ast;
  };




%%

// 定义错误处理函数, 其中第二个参数是错误信息
// parser 如果发生错误 (例如输入的程序出现了语法错误), 就会调用这个函数
void yyerror(unique_ptr<Baseast> &ast, const char *s) {
    extern int yylineno;    // defined and maintained in lex
    extern char *yytext;    // defined and maintained in lex
    int len=strlen(yytext);
    int i;
    char buf[512]={0};
    for (i=0;i<len;++i){
        sprintf(buf,"%s%d ",buf,yytext[i]);
    }
    fprintf(stderr, "ERROR: %s at symbol '%s' on line %d\n", s, buf, yylineno);
  //cerr << "error: " << s << endl;
}
