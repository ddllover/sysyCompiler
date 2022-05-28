#pragma once

#include <iostream>
#include<cassert>
#include "koopa.h"

using namespace std;

// 所有 AST 的基类
class BaseAST {
 public:
  virtual ~BaseAST() = default;

  virtual void Dump() const = 0;
};

// CompUnit 是 BaseAST
class CompUnitAST : public BaseAST {
 public:
  // 用智能指针管理对象
  unique_ptr<BaseAST> func_def;

  void Dump() const override {
    //cout << "CompUnitAST { ";
    func_def->Dump();
    //cout << " }";
  }
};

// FuncDef 也是 BaseAST
class FuncDefAST : public BaseAST {
 public:
  unique_ptr<BaseAST> func_type;
  string ident;
  unique_ptr<BaseAST> block;

  void Dump() const override {
    cout << "fun ";
    cout << "@" << ident << "(): ";
    func_type->Dump();
    cout<<"{"<<endl;
    block->Dump();
    cout << "}"<<endl;
  }
};

class FuncTypeAST :public BaseAST{
    public:
    string str;

    void Dump() const override {
        cout<<"i32"<<" ";
    }
};

class BlockAST: public BaseAST{
    public:
    unique_ptr<BaseAST> stmt;

    void Dump() const override{
        cout<<"\%entry:"<<endl;
        stmt->Dump();
        cout<<endl;
    }
};

class StmtAST:public BaseAST{
    public:
    int number;

    void Dump() const override{
        cout<<" ret ";
        cout<<number;
    }
};

// ...

// 函数声明略
void Visit(const koopa_raw_slice_t &slice);
void Visit(const koopa_raw_function_t &func) ;
void Visit(const koopa_raw_basic_block_t &bb) ;
void Visit(const koopa_raw_value_t &value);
void Visit(const koopa_raw_program_t &program);





