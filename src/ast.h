#ifndef GRANDPARENT_H
#define GRANDPARENT_H

//#define DEBUG
#define MAXCHARS 100000

#include "koopa.h"

#include <cassert>
#include <iostream>
#include <cstdio>
#include <memory>
#include <cstring>

using namespace std;

class BaseAST
{
public:
  virtual ~BaseAST() = default;
  static int count_all;
  int count; //代表该节点结果的代数
  int kind;  
  virtual string Dump() = 0;
};

string Dumpop(unique_ptr<BaseAST>  &op1,unique_ptr<BaseAST> &op2,const char *temp2,const char *temp1,const char * op);
// 所有 AST 的基类
string DumpUnaryOp(unique_ptr<BaseAST> &op1,const char *temp1,const char * op);
// CompUnit 是 BaseAST
class CompUnitAST : public BaseAST // CompUnit    ::= FuncDef;
{
public: 
  // 用智能指针管理对象
  unique_ptr<BaseAST> func_def;

  string Dump() override // override确保虚函数覆盖基类的虚函数
  {
    string temp = func_def->Dump();
    count = func_def->count;
    return temp;
  }
};

// FuncDef 也是 BaseAST
class FuncDefAST : public BaseAST // FuncDef     ::= FuncType IDENT "(" ")" Block;
{
public:
  unique_ptr<BaseAST> func_type;
  string ident;
  unique_ptr<BaseAST> block;

  string Dump() override
  {
    char temp[MAXCHARS] = {0};
    string temp_func_type = func_type->Dump();
    string temp_block = block->Dump();
    count = block->count;
    sprintf(temp, "fun @%s(): %s{\n%s}\n", ident.c_str(), temp_func_type.c_str(), temp_block.c_str());

    return string(temp);
  }
};

class FuncTypeAST : public BaseAST // FuncType    ::= "int";
{
public:
  string str;

  string Dump() override
  {
    char temp[MAXCHARS] = {0};
    sprintf(temp, "i32 ");
    return temp;
  }
};

class BlockAST : public BaseAST // Block       ::= "{" Stmt "}";
{
public:
  unique_ptr<BaseAST> stmt;

  string Dump() override
  {
    char temp[MAXCHARS] = {0};
    string temp_stmt = stmt->Dump();
    count = stmt->count;
    sprintf(temp, "%%entry:\n%s", temp_stmt.c_str());

    // cout<<"\%entry:"<<endl;
    // stmt->Dump();
    return temp;
  }
};

class StmtAST : public BaseAST // Stmt        ::= "return" Exp ";";
{
public:
  unique_ptr<BaseAST> exp;

  string Dump() override
  {
    char temp[MAXCHARS] = {0};

    string temp_exp = exp->Dump();
    count = exp->count;
    if (temp_exp[0] != ' ') //非表达式
    {
      sprintf(temp, "  ret %s\n", temp_exp.c_str());
    }
    else
    {
      sprintf(temp, "%s  ret %%%d\n", temp_exp.c_str(), count_all);
    }
    return temp;
  }
};

class ExpAST : public BaseAST // Exp         ::= LOrExp;
{
public:
  unique_ptr<BaseAST> lorExp;

  string Dump() override
  {
    string temp = lorExp->Dump();
    count = lorExp->count;
    return temp;
  }
};

class PrimaryExpAST : public BaseAST // PrimaryExp  ::= "(" Exp ")" | Number;
{
public:
  unique_ptr<BaseAST> exp;
  int number;

  string Dump() override
  {
    char temp[MAXCHARS] = {0};
    if (kind == 1)
    {
      strcpy(temp,exp->Dump().c_str());
      count = exp->count;
    }
    else if (kind == 2)
    {
      sprintf(temp, "%d", number);
      count = count_all;
    }
    return temp;
  }
};

class UnaryExpAST : public BaseAST // UnaryExp    ::= PrimaryExp | UnaryOp UnaryExp;
{
public:
  unique_ptr<BaseAST> primary;
  unique_ptr<BaseAST> unaryop;
  unique_ptr<BaseAST> unaryexp;

  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp=primary->Dump();
      count = primary->count;
    }
    else if (kind == 2)
    {
      if (unaryop->kind == 1)
      { //正,不需要处理
        temp =unaryexp->Dump();
        count = unaryexp->count;
      }
      else {
        temp=DumpUnaryOp(unaryexp,unaryexp->Dump().c_str(),unaryop->Dump().c_str());
        count_all++;
        count = count_all;
      }
    }
    return temp;
  }
};

class UnaryOpAST : public BaseAST
{
public:
  string str;
  string Dump() override
  {
    return str;
  }
};

class MulExpAST : public BaseAST // UnaryExp | MulExp ("*" | "/" | "%") UnaryExp;
{
public:
  unique_ptr<BaseAST> unaryExp;
  unique_ptr<BaseAST> mulop;
  unique_ptr<BaseAST> mulExp;

  string Dump() override
  {
    string temp;
    if(kind==1){
      temp=unaryExp->Dump();
      count=unaryExp->count;
    }
    else if(kind==2){
      //unaryexp 优先参与运算
      temp=Dumpop(mulExp,unaryExp,unaryExp->Dump().c_str(),mulExp->Dump().c_str(),mulop->Dump().c_str());
      count_all++;
      count=count_all;

      #ifdef DEBUG
      cout<<temp;
      #endif
    }
    return temp;
  }
};

class AddExpAST : public BaseAST // MulExp | AddExp ("+" | "-") MulExp
{
public:
  unique_ptr<BaseAST> mulExp;
  unique_ptr<BaseAST> addOp;
  unique_ptr<BaseAST> addExp;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp= mulExp->Dump();
      count = mulExp->count;
    }
    else if (kind == 2)
    { 
      temp=Dumpop(addExp,mulExp,mulExp->Dump().c_str(),addExp->Dump().c_str(),addOp->Dump().c_str() );
      count_all++;
      count=count_all;
      

      #ifdef DEBUG
      cout<<temp<<endl;
      #endif
    }
    return temp;

  }
};



//RelExp      ::= AddExp | RelExp ("<" | ">" | "<=" | ">=") AddExp;
class RelExpAST:public BaseAST{
  public:
  unique_ptr<BaseAST> addexp;
  unique_ptr<BaseAST> relexp;
  unique_ptr<BaseAST> relop;
  string Dump() override{
    string temp;
    if(kind ==1){
      temp=addexp->Dump();
      count=addexp->count;
    }
    else if(kind==2){
      temp=Dumpop(relexp,addexp,addexp->Dump().c_str(),relexp->Dump().c_str(),relop->Dump().c_str());
      count_all++;
      count=count_all;
      #ifdef DEBUG
      cout<<temp<<endl;
      #endif
    }
     return temp;
  }
 
};

//EqExp       ::= RelExp | EqExp ("==" | "!=") RelExp;
class EqExpAST :public BaseAST{
  public:
  unique_ptr<BaseAST> relexp;
  unique_ptr<BaseAST> eqexp;
  unique_ptr<BaseAST> eqop;
  string Dump() override{
    string temp;
    if(kind==1){
      temp=relexp->Dump();
      count=relexp->count;
    }
    else if(kind==2){
      temp=Dumpop(eqexp,relexp,relexp->Dump().c_str(),eqexp->Dump().c_str(),eqop->Dump().c_str());
      count_all++;
      count=count_all;

      #ifdef DEBUG
      cout<<temp<<endl;
      #endif
    }

    return temp;
  }
};

//LAndExp     ::= EqExp | LAndExp "&&" EqExp;
class LAndExpAST :public BaseAST{
  public:
  unique_ptr<BaseAST> eqexp;
  unique_ptr<BaseAST> op; 
  unique_ptr<BaseAST> landexp;
  string Dump() override{
    string temp;
    if(kind==1){
      temp=eqexp->Dump();
      count=eqexp->count;
    }
    else if(kind==2){
      // 先用ne 将数值转换为逻辑
      string temp_eqexp=DumpUnaryOp(eqexp,eqexp->Dump().c_str(),"ne");
      count_all++;
      eqexp->count=count_all;

      string temp_landexp=DumpUnaryOp(landexp,landexp->Dump().c_str(),"ne");
      count_all++;
      landexp->count=count_all;

      temp=Dumpop(landexp,eqexp,temp_eqexp.c_str(),temp_landexp.c_str(),"and");
      count_all++;
      count=count_all;

      #ifdef DEBUG
      cout<<temp;
      #endif
    }
    return temp;
  }
};

//LOrExp      ::= LAndExp | LOrExp "||" LAndExp;
class LOrExpAST:public BaseAST{
  public:
  unique_ptr<BaseAST> landexp;
  unique_ptr<BaseAST> op;
  unique_ptr<BaseAST> lorexp;
  string Dump() override{
    string temp;
    if(kind==1){
      temp=landexp->Dump();
      count=landexp->count;
    }
    else if(kind==2){
      temp=Dumpop(lorexp,landexp,landexp->Dump().c_str(),lorexp->Dump().c_str(),"or");
      count_all++;
      count=count_all;
      
      //按位或和逻辑或相同 将结果转换为逻辑
      unique_ptr<BaseAST> temp_ptr=unique_ptr<BaseAST>(this);
      temp=DumpUnaryOp(temp_ptr,temp.c_str(),"ne");
      temp_ptr.release();
      count_all++;
      count=count_all;

      #ifdef DEBUG
      cout<<temp;
      #endif
    }
    return temp;
  }
};

class OpAST:public BaseAST{
  public:
  string str;
  string Dump() override{
    return str;
  }
};

// ...

// 函数声明略
void Visit(const koopa_raw_slice_t &slice);
void Visit(const koopa_raw_function_t &func);
void Visit(const koopa_raw_basic_block_t &bb);
void Visit(const koopa_raw_value_t &value);
void Visit(const koopa_raw_program_t &program);
void AnalyzeIR(const char *str);



#endif
