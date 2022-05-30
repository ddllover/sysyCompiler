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
void yyerror(std::unique_ptr<BaseAST> &ast, const char *s);

using namespace std;

%}

// 定义 parser 函数和错误处理函数的附加参数
// 我们需要返回一个字符串作为 AST, 所以我们把附加参数定义成字符串的智能指针
// 解析完成后, 我们要手动修改这个参数, 把它设置成解析得到的字符串
%union {
  std::string *str_val;
  int int_val;
  BaseAST *ast_val;
}

%parse-param { std::unique_ptr<BaseAST> &ast }


// lexer 返回的所有 token 种类的声明
// 注意 IDENT 和 INT_CONST 会返回 token 的值, 分别对应 str_val 和 int_val
%token INT RETURN 
%token <str_val> IDENT
%token <int_val> INT_CONST

// 非终结符的类型定义
%type <ast_val> FuncDef FuncType Block Stmt Exp PrimaryExp UnaryExp UnaryOp AddExp MulExp AddOp MulOp
%type <int_val> Number

%%

CompUnit: 
  FuncDef {
    auto comp_unit = make_unique<CompUnitAST>();
    comp_unit->func_def = unique_ptr<BaseAST>($1);
    ast = move(comp_unit);   //对应mian函数里面ast
  }
  ;

FuncDef: 
  FuncType IDENT '(' ')' Block {
    auto ast = new FuncDefAST();
    ast->func_type = unique_ptr<BaseAST>($1);
    ast->ident = *unique_ptr<string>($2);
    ast->block = unique_ptr<BaseAST>($5);
    $$ = ast;
  }
  ;

FuncType: 
  INT {
    auto ast =new FuncTypeAST();
    ast->str="int";
    $$ = ast;
  }
  ;

Block: 
  '{' Stmt '}' {
    auto ast = new BlockAST();
    ast->stmt=unique_ptr<BaseAST>($2);
    $$ = ast;
  }
  ;

Stmt: 
  RETURN Exp ';' {
    auto ast=new StmtAST();
    ast->exp =unique_ptr<BaseAST>($2);
    $$ = ast;
  }
  ;
Exp: 
  AddExp{
    auto ast=new ExpAST();
    ast->addExp=unique_ptr<BaseAST>($1);
    $$=ast;

  }
  ;

PrimaryExp: 
  '(' Exp ')' {
      auto ast=new PrimaryExpAST();
      ast->kind=1;
      ast->exp=unique_ptr<BaseAST>($2);
      $$=ast;
  }
  | Number{
    auto ast=new PrimaryExpAST();
    ast->kind=2;
    ast->number=$1;
    $$=ast;
  }
  ;

Number
  : INT_CONST {
    $$ = $1;
  }
  ;

UnaryExp:
  PrimaryExp {
    auto ast=new UnaryExpAST();
    ast->kind=1;
    ast->primary=unique_ptr<BaseAST>($1);
    $$=ast;
  }
  | UnaryOp UnaryExp{
     auto ast=new UnaryExpAST();
     ast->kind=2;
     ast->unaryop=unique_ptr<BaseAST>($1);
     ast->unaryexp=unique_ptr<BaseAST>($2);
     $$=ast;
  }
  ;

UnaryOp:
  '+' {
    auto ast=new UnaryOpAST();
    ast->kind=1;
    ast->str='+';
    $$=ast;
  }
  | '-'{
    auto ast=new UnaryOpAST();
    ast->kind=2;
    ast->str='-';
    $$=ast;
  } 
  | '!'{
    auto ast=new UnaryOpAST();
    ast->kind=3;
    ast->str='!';
    $$=ast;
  }
  ;


MulExp:
  UnaryExp{
    auto ast=new MulExpAST();
    ast->kind=1;
    ast->unaryExp=unique_ptr<BaseAST>($1);
    $$=ast;
  }
  | MulExp  MulOp UnaryExp{
    auto ast=new MulExpAST();
    ast->kind=2;
    ast->mulExp=unique_ptr<BaseAST> ($1);
    ast->mulop=unique_ptr<BaseAST> ($2);
    ast->unaryExp=unique_ptr<BaseAST>($3);
    $$=ast;
  }
  ;
  
MulOp:
  '*'{
  auto ast=new MulOpAST();
  ast->kind=1;
  ast->str='*';
  $$=ast;
  } 
  | '/'
  {
    auto ast=new MulOpAST();
    ast->kind=2;
    $$=ast;
  } 
  | '%'
  {
    auto ast=new MulOpAST();
    ast->kind=3;
    $$=ast;
  }
  ;


AddExp:
 MulExp{
   auto ast=new AddExpAST();
   ast->kind=1;
   ast->mulExp=unique_ptr<BaseAST>($1);
   $$=ast;
 }
  | AddExp AddOp MulExp{
    auto ast=new AddExpAST();
    ast->kind=2;
    ast->addExp=unique_ptr<BaseAST>($1);
    ast->addOp=unique_ptr<BaseAST>($2);
    ast->mulExp=unique_ptr<BaseAST>($3);
    $$=ast;
  }
  ;

AddOp:
  '+'
  {
    auto ast=new AddOpAST();
    ast->kind=1;
    
    $$=ast;
  } 
  | '-'
  {
    auto ast=new AddOpAST();
    ast->kind=2;

    $$=ast;
  };



%%

// 定义错误处理函数, 其中第二个参数是错误信息
// parser 如果发生错误 (例如输入的程序出现了语法错误), 就会调用这个函数
void yyerror(unique_ptr<BaseAST> &ast, const char *s) {
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
