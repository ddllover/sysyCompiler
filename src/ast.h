#ifndef GRANDPARENT_H
#define GRANDPARENT_H

#define DEBUG

#include "koopa.h"

#include <cassert>
#include <iostream>
#include <cstdio>
#include <memory>
#include <cstring>

using namespace std;

// 所有 AST 的基类
class BaseAST
{
public:
  virtual ~BaseAST() = default;
  int count; //代表该节点结果的代数
  static int count_all;
  int kind;
  virtual string Dump() = 0;
};
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
    char temp[10000] = {0};
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
    char temp[10000] = {0};
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
    char temp[10000] = {0};
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
    char temp[10000] = {0};

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

class ExpAST : public BaseAST // Exp         ::= AddExp;
{
public:
  unique_ptr<BaseAST> addExp;

  string Dump() override
  {
    string temp = addExp->Dump();
    count = addExp->count;
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
    char temp[10000] = {0};
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
    char temp[10000] = {0};
    if (kind == 1)
    {
      strcpy(temp,primary->Dump().c_str());
      count = primary->count;
    }
    else if (kind == 2)
    {
      if (unaryop->kind == 1)
      { //正,不需要处理
        strcpy(temp ,unaryexp->Dump().c_str());
        count = unaryexp->count;
      }
      else if (unaryop->kind == 2)
      { //负
        string temp_unaryexp = unaryexp->Dump();

        if (temp_unaryexp[0] !=' ') //非表达式 代表该部分前面没有任何运算
        {
          sprintf(temp, "  %%%d = sub 0, %s\n", count_all + 1, temp_unaryexp.c_str());
        }
        else
        {
          //最新的指令编号
          sprintf(temp, "%s  %%%d = sub 0, %%%d\n", temp_unaryexp.c_str(), count_all + 1, unaryexp->count);
        }
        count_all++;
        count = count_all;
      }
      else if (unaryop->kind == 3)
      { //非
        string temp_unaryexp = unaryexp->Dump();
        if (temp_unaryexp[0] != ' ')
        { // temp_unaryexp最终会返回一个数字
          sprintf(temp, "  %%%d = eq %s, 0\n", count_all + 1, temp_unaryexp.c_str());
        }
        else
        {
          sprintf(temp, "%s  %%%d = eq %%%d, 0\n", temp_unaryexp.c_str(), count_all + 1, unaryexp->count);
        }
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
    char temp[100000] = {0};
    if (kind == 1)
    {
    }
    else if (kind == 2)
    {
    }
    else if (kind == 3)
    {
    }
    return temp;
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
    char temp[100000] = {0};
    if(kind==1){
      strcpy(temp,unaryExp->Dump().c_str());
      count=unaryExp->count;
      return temp;
    }
    else if(kind==2){
      //unaryexp 优先参与运算
      string temp_unaryExp=unaryExp->Dump();
      string temp_mulExp=mulExp->Dump();
      if(mulop->kind==1)//*
      { 
        if(temp_mulExp[0]==' '){
          if(temp_unaryExp[0]==' ') //mulexp为表达式 unaryexp为表达式
            sprintf(temp,"%s%s  %%%d = mul %%%d, %%%d\n",temp_unaryExp.c_str(),temp_mulExp.c_str(),count_all+1,mulExp->count,unaryExp->count);
          else 
            sprintf(temp,"%s  %%%d = mul %%%d, %s\n",temp_mulExp.c_str(),count_all+1,mulExp->count,temp_unaryExp.c_str());

        }
        else{
          if(temp_unaryExp[0]==' ')
            sprintf(temp,"%s  %%%d = mul %s, %%%d\n",temp_unaryExp.c_str(),count_all+1,temp_mulExp.c_str(),unaryExp->count);

          else 
            sprintf(temp,"  %%%d = mul %s, %s\n",count_all+1,temp_mulExp.c_str(),temp_unaryExp.c_str());
        }
        count_all++;
        count=count_all;
      }
      else if(mulop->kind==2)// /
      { 
        if(temp_mulExp[0]==' '){
          if(temp_unaryExp[0]==' ') //mulexp为表达式 unaryexp为表达式
            sprintf(temp,"%s%s  %%%d = div %%%d, %%%d\n",temp_unaryExp.c_str(),temp_mulExp.c_str(),count_all+1,mulExp->count,unaryExp->count);
          else 
            sprintf(temp,"%s  %%%d = div %%%d, %s\n",temp_mulExp.c_str(),count_all+1,mulExp->count,temp_unaryExp.c_str());

        }
        else{
          if(temp_unaryExp[0]==' ')
            sprintf(temp,"%s  %%%d = div %s, %%%d\n",temp_unaryExp.c_str(),count_all+1,temp_mulExp.c_str(),unaryExp->count);

          else 
            sprintf(temp,"  %%%d = div %s, %s\n",count_all+1,temp_mulExp.c_str(),temp_unaryExp.c_str());
        }
        count_all++;
        count=count_all;
      }
      else if(mulop->kind==3)// %
      {
        if(temp_mulExp[0]==' '){
          if(temp_unaryExp[0]==' ') //mulexp为表达式 unaryexp为表达式
            sprintf(temp,"%s%s  %%%d = mod %%%d, %%%d\n",temp_unaryExp.c_str(),temp_mulExp.c_str(),count_all+1,mulExp->count,unaryExp->count);
          else 
            sprintf(temp,"%s  %%%d = mod %%%d, %s\n",temp_mulExp.c_str(),count_all+1,mulExp->count,temp_unaryExp.c_str());

        }
        else{
          if(temp_unaryExp[0]==' ')
            sprintf(temp,"%s  %%%d = mod %s, %%%d\n",temp_unaryExp.c_str(),count_all+1,temp_mulExp.c_str(),unaryExp->count);

          else 
            sprintf(temp,"  %%%d = mod %s, %s\n",count_all+1,temp_mulExp.c_str(),temp_unaryExp.c_str());
        }
        count_all++;
        count=count_all
        ;
      }
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
    char temp[10000] = {0};
    if (kind == 1)
    {
      strcpy(temp , mulExp->Dump().c_str());
      count = mulExp->count;
    }
    else if (kind == 2)
    { 
      //mulexp先参与运算
      string temp_mulExp = mulExp->Dump();  
      string temp_addExp = addExp->Dump();
      if (addOp->kind == 1) // +
      {
        if (temp_addExp[0] == ' ')
        {
          if (temp_mulExp[0] == ' ') // addexp为表达式，mulexp为表达式
            sprintf(temp, "%s%s  %%%d = add %%%d, %%%d\n", temp_mulExp.c_str(), temp_addExp.c_str(), count_all + 1, addExp->count, mulExp->count);
          else // addexp为表达式，mulexp为数字
            sprintf(temp, "%s  %%%d = add %%%d, %s\n", temp_addExp.c_str(), count_all + 1, addExp->count, temp_mulExp.c_str());
        }
        else 
        {
          if (temp_mulExp[0] == ' ') // addexp为数字，mulexp为表达式
            sprintf(temp, "%s  %%%d = add %s, %%%d\n", temp_mulExp.c_str(), count_all + 1, temp_addExp.c_str(), mulExp->count);
          else
            sprintf(temp, "  %%%d = add %s, %s\n", count_all + 1, temp_addExp.c_str(), temp_mulExp.c_str());
        }
        count_all++;
        count=count_all;
      }
      else if (addOp->kind == 2) // -
      {
        if (temp_addExp[0] == ' ')
        {
          if (temp_mulExp[0] == ' ') // addexp为表达式，mulexp为表达式
            sprintf(temp, "%s%s  %%%d = sub %%%d, %%%d\n", temp_addExp.c_str(), temp_mulExp.c_str(), count_all + 1, addExp->count, mulExp->count);
          else // addexp为表达式，mulexp为数字
            sprintf(temp, "%s  %%%d = sub %%%d, %s\n", temp_addExp.c_str(), count_all + 1, addExp->count, temp_mulExp.c_str());
        }
        else
        {
          if (temp_mulExp[0] == ' ') // addexp为数字，mulexp为表达式
            sprintf(temp, "%s  %%%d = sub %s, %%%d\n", temp_mulExp.c_str(), count_all + 1, temp_addExp.c_str(), mulExp->count);
          else
            sprintf(temp, "  %%%d = sub %s, %s\n", count_all + 1, temp_addExp.c_str(), temp_mulExp.c_str());
        }
        count_all++;
        count=count_all;
      }
    #ifdef DEBUG
    cout<<temp<<endl;
    #endif
    }

    return temp;

  }
};

class AddOpAST : public BaseAST
{
public:
  string str;
  string Dump() override
  {
    char temp[10000] = {0};
    return temp;
  }
};

class MulOpAST : public BaseAST
{
public:
  string str;
  string Dump() override
  {
    char temp[10000] = {0};
    return temp;
  }
};
//RelExp      ::= AddExp | RelExp ("<" | ">" | "<=" | ">=") AddExp;
//EqExp       ::= RelExp | EqExp ("==" | "!=") RelExp;
//LAndExp     ::= EqExp | LAndExp "&&" EqExp;
//LOrExp      ::= LAndExp | LOrExp "||" LAndExp;

// ...

// 函数声明略
void Visit(const koopa_raw_slice_t &slice);
void Visit(const koopa_raw_function_t &func);
void Visit(const koopa_raw_basic_block_t &bb);
void Visit(const koopa_raw_value_t &value);
void Visit(const koopa_raw_program_t &program);
void AnalyzeIR(const char *str);

#endif
