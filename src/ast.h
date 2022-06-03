#ifndef GRANDPARENT_H
#define GRANDPARENT_H

#define DEBUG
#define MAXCHARS 10000

#include "koopa.h"

#include <cassert>
#include <iostream>
#include <cstdio>
#include <memory>
#include <cstring>
#include <map>
#include <vector>

using namespace std;
extern string btype_str; // 声明时变量类型，以便所有声明的变量种类初始化
extern FILE *IR;

struct Symbol
{
  int kind;    // 0为const常量 1为符号变量
  int val;     // 没有初始化时，默认为0
  string type; //变量类型
  int block_num; //记录符号所属于的block
};
struct Fun_sym //每个函数一个层次符号表
{                                
  int block_num;  //记录block的个数，用于命名防止名称重复
  vector<map<string, Symbol>> vec_symbolmap;; //符号表
  Fun_sym()
  {
    block_num = 0;
  }
};
extern Fun_sym fun_symtab;  //用于查询上级符号表
extern map<string, Symbol> symbolmap; //代表当前block符号表,便于操作

Symbol Symbol_find(string str);

void Visit(const koopa_raw_slice_t &slice);
void Visit(const koopa_raw_function_t &func);
void Visit(const koopa_raw_basic_block_t &bb);
void Visit(const koopa_raw_value_t &value);
void Visit(const koopa_raw_program_t &program);
void AnalyzeIR(const char *str);

string Dumpop(string temp1, string temp2, string op);
string DumpUnaryOp(string temp1, string op);
string DumpLoad(string lval,int block_num);
string DumpStore(string temp1, string lval,int block_num);
string DumpAlloc(string temp1,int block_num);

class Baseast
{
public:
  virtual ~Baseast() = default;
  static int count_all;
  int count; //代表该节点结果的代数
  int kind;  //字节点序号

  virtual string Dump() = 0;
  virtual int Calc() = 0;
};

// CompUnit    ::= FuncDef;
class CompUnitast : public Baseast 
{
public:
  // 用智能指针管理对象
  unique_ptr<Baseast> func_def;

  string Dump() override // override确保虚函数覆盖基类的虚函数
  {
    string temp = func_def->Dump();
    count = func_def->count;
    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};

// BType         ::= "int";
class BTypeast : public Baseast
{
public:
  string str;
  string Dump() override
  {
    return str;
  }
  int Calc() override
  {
    return 0;
  }
};

// Decl          ::= ConstDecl|VarDecl;
class Declast : public Baseast
{
public:
  unique_ptr<Baseast> constdecl;
  unique_ptr<Baseast> vardecl;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      constdecl->Calc();
    }
    else if (kind == 2)
    {
      temp = vardecl->Dump();
    }
    return temp;
  }
  int Calc() override
  {
    return 0;
  }
};
// ConstDecl     ::= "const" BType ConstDef ";";
class ConstDeclast : public Baseast
{
public:
  unique_ptr<Baseast> btype; // btype 目前都为int 先不管
  unique_ptr<Baseast> constdef;
  string Dump() override
  {
    return "";
  }
  int Calc() override
  {
    btype_str = btype->Dump();
    return constdef->Calc();
  }
};

// ConstDef      ::= IDENT "=" ConstInitVal|IDENT "=" ConstInitVal ',' ConstDef;
class ConstDefast : public Baseast
{
public:
  unique_ptr<Baseast> constinitval;
  string ident;
  unique_ptr<Baseast> constdef;
  string Dump() override
  {
    return "";
  }
  int Calc() override
  {
    symbolmap.insert({ident, {0, constinitval->Calc(), btype_str,fun_symtab.block_num}});
    #ifdef DEBUG
        cout << "const:" << ident << " " << symbolmap[ident].val << endl;
    #endif
    if (kind == 2)
    {
      constdef->Calc();
    }
    return 0;
  }
};

// ConstInitVal  ::= ConstExp;
class ConstInitValast : public Baseast
{
public:
  unique_ptr<Baseast> constexp;
  string Dump() override
  {
    return "";
  }
  int Calc() override
  {
    return constexp->Calc();
  }
};

// ConstExp      ::= Exp;
class ConstExpast : public Baseast
{
public:
  unique_ptr<Baseast> exp;
  string Dump() override
  {
    return "";
  }
  int Calc() override
  {
    return exp->Calc();
  }
};

// VarDecl       ::= BType VarDef  ";";
class VarDeclast : public Baseast
{
public:
  unique_ptr<Baseast> btype;
  unique_ptr<Baseast> vardef;
  string Dump() override
  { // alloc
    btype_str = btype->Dump();
    return vardef->Dump();
  }
  int Calc() override
  {
    return 0;
  }
};

// VarDef        ::= (IDENT , | IDENT "=" InitVal) {',' VarDef};
class VarDefast : public Baseast
{
public:
  string ident;
  unique_ptr<Baseast> initval;
  unique_ptr<Baseast> vardef;
  string Dump() override
  {
    string temp;

    //变量只需要表明类型以及和const区分，值由IR计算

    symbolmap.insert({ident, {1, 0, btype_str,fun_symtab.block_num}});

    //  vardef 声明 @ident = alloc btype_str
    DumpAlloc(ident,fun_symtab.block_num);

    // 定义 store %count, @ident
    if (kind == 2 || kind == 4)
    {
      temp = DumpStore(initval->Dump(), ident,fun_symtab.block_num);
      count = initval->count;
    }
    else
    {
      fprintf(IR, "\n"); //每个变量划分一个块便于debug
    }

    if (kind == 3 || kind == 4)
    {
      temp = vardef->Dump();
      count = initval->count;
    }
    return temp;
  }
  int Calc() override
  {
    return 0;
  }
};

// InitVal       ::= Exp;
class InitValast : public Baseast
{
public:
  unique_ptr<Baseast> exp;
  string Dump() override
  {
    string temp = exp->Dump();
    count = exp->count;
    return temp;
  }
  int Calc() override
  {
    return 0;
  }
};

// Block         ::= "{" BlockItem "}";
class Blockast : public Baseast
{
public:
  unique_ptr<Baseast> blockitem;
  string Dump() override
  {

    string temp;
    if (blockitem->kind != 1) // blockitem 不为空 为空返回空  空{}不计入block_num
    {
      //建立新的符号表
      fun_symtab.vec_symbolmap.push_back(symbolmap);
      fun_symtab.block_num++;
      symbolmap.clear();

      temp = blockitem->Dump();
      count = blockitem->count;

      symbolmap=fun_symtab.vec_symbolmap.back();
      fun_symtab.vec_symbolmap.pop_back();
    }
    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};
// BlockItem     ::=  |Decl BlockItem| Stmt BlockItem;
class BlockItemast : public Baseast
{
public:
  unique_ptr<Baseast> decl;
  unique_ptr<Baseast> stmt;
  unique_ptr<Baseast> blockitem;
  string Dump() override
  {
    string temp;
    if (kind == 1) //为空返回值无用
    {
      return "";
    }
    else if (kind == 2)
    {

      decl->Dump();
      temp = blockitem->Dump();
    }
    else if (kind == 3)
    {
      stmt->Dump();
      temp = blockitem->Dump();
    }
    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};

// LVal          ::= IDENT;
class LValast : public Baseast
{ //用符号表记录LVal和其对应的值
public:
  string ident;
  string Dump() override //返回name
  {
    return ident;
  }
  int Calc() override //返回value
  {

    Symbol lval_sym=Symbol_find(ident);
    //Symbol lval_sym = lval_symtab->symbolmap[ident];
    assert(!lval_sym.kind);
    return lval_sym.val;
  }
};

// PrimaryExp    ::= "(" Exp ")"  | Number| LVal;
class PrimaryExpast : public Baseast // lval 分为常量和变量 常量直接换成number 变量需要load
{
public:
  unique_ptr<Baseast> exp;  
  int number;
  unique_ptr<Baseast> lval;

  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = exp->Dump();
      count = exp->count;
    }
    else if (kind == 2)
    {
      temp = to_string(number);
      count = count_all;
    }
    else if (kind == 3)
    {
      string ident=lval->Dump();
      //Symboltab *lval_symtab = Symtab_find(dump_symtab, ident);
      Symbol lval_sym = Symbol_find(ident);
      if (lval_sym.kind == 0)
      { // const常量
        temp = to_string(lval_sym.val);
      }
      else if (lval_sym.kind == 1)
      { // 变量
        temp = DumpLoad(ident , lval_sym.block_num);
      }

      count = count_all;
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = exp->Calc();
    }
    else if (kind == 2)
    {
      temp = number;
    }
    else if (kind == 3)
    {
      temp = lval->Calc();
    }
    return temp;
  }
};

// FuncDef 也是 Baseast
class FuncDefast : public Baseast // FuncDef     ::= FuncType IDENT "(" ")" Block;
{
public:
  unique_ptr<Baseast> func_type;
  string ident;
  unique_ptr<Baseast> block;

  string Dump() override
  {
    string temp;

    fprintf(IR, "fun @%s(): %s{\n%%entry:\n", ident.c_str(), func_type->Dump().c_str());
    temp = block->Dump();
    count = block->count;
    fprintf(IR, "}\n");

    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};

class FuncTypeast : public Baseast // FuncType    ::= "int";
{
public:
  string str;

  string Dump() override
  {
    char temp[MAXCHARS] = {0};
    sprintf(temp, "i32 ");
    return temp;
  }
  int Calc() override
  {
    return 0;
  }
};
// Stmt::= "return" Exp ";"|LVal "=" Exp ";"| ';'|Exp ";"|block
class Stmtast : public Baseast
{
public:
  unique_ptr<Baseast> exp;
  unique_ptr<Baseast> lval;
  unique_ptr<Baseast> block; //符号表迭代一层
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      fprintf(IR, "  ret %s\n\n", exp->Dump().c_str());
      count = exp->count;
    }
    else if (kind == 2) // lval 在exp中需要load
    {                   // lval 在stmt需要 store
      string ident=lval->Dump();
      Symbol lval_sym=Symbol_find(ident);

      temp = DumpStore(exp->Dump(), ident,lval_sym.block_num);
      count = exp->count;
    }
    else if (kind == 3)
    {
      // 空
    }
    else if (kind == 4)
    {
      exp->Dump();
      count = exp->count;
    }
    else if (kind == 5)
    { //符号表加深一层
      temp = block->Dump();
      count = block->count;
    }
    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};

class Expast : public Baseast // Exp         ::= LOrExp;
{
public:
  unique_ptr<Baseast> lorExp;

  string Dump() override
  {
    string temp = lorExp->Dump();
    count = lorExp->count;
    return temp;
  }
  int Calc() override
  {
    return lorExp->Calc();
  }
};

class UnaryExpast : public Baseast // UnaryExp    ::= PrimaryExp | UnaryOp(+ - !) UnaryExp;
{
public:
  unique_ptr<Baseast> primary;
  unique_ptr<Baseast> unaryop;
  unique_ptr<Baseast> unaryexp;

  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = primary->Dump();
      count = primary->count;
    }
    else if (kind == 2)
    {
      if (unaryop->kind == 1)
      { //正,不需要处理
        temp = unaryexp->Dump();
        count = unaryexp->count;
      }
      else
      {
        temp = DumpUnaryOp(unaryexp->Dump(), unaryop->Dump());
        count = count_all;
      }
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = primary->Calc();
    }
    else if (kind == 2)
    {
      temp = unaryexp->Calc();
      if (unaryop->kind == 1)
      {
        // + 忽略
      }
      else if (unaryop->kind == 2)
      {
        temp = -temp;
      }
      else if (unaryop->kind == 3)
      {
        temp = (temp == 0 ? 0 : 1);
      }
    }
    return temp;
  }
};

class MulExpast : public Baseast // UnaryExp | MulExp ("*" | "/" | "%") UnaryExp;
{
public:
  unique_ptr<Baseast> unaryExp;
  unique_ptr<Baseast> mulop;
  unique_ptr<Baseast> mulExp;

  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = unaryExp->Dump();
      count = unaryExp->count;
    }
    else if (kind == 2)
    {
      //可再分temp为空
      temp = Dumpop(mulExp->Dump(), unaryExp->Dump(), mulop->Dump());
      count = count_all;
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = unaryExp->Calc();
    }
    else if (kind == 2)
    {
      temp = unaryExp->Calc();
      int temp2 = mulExp->Calc();
      if (mulop->kind == 1)
      {
        temp = temp2 * temp;
      }
      else if (mulop->kind == 2)
      {
        temp = temp2 / temp;
      }
      else if (mulop->kind == 3)
      {
        temp = temp2 % temp;
      }
    }
    return temp;
  }
};

class AddExpast : public Baseast // MulExp | AddExp ("+" | "-") MulExp
{
public:
  unique_ptr<Baseast> mulExp;
  unique_ptr<Baseast> addOp;
  unique_ptr<Baseast> addExp;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = mulExp->Dump();
      count = mulExp->count;
    }
    else if (kind == 2)
    {
      temp = Dumpop(addExp->Dump(), mulExp->Dump(), addOp->Dump());
      count = count_all;
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = mulExp->Calc();
    }
    else if (kind == 2)
    {
      temp = mulExp->Calc();
      int temp2 = addExp->Calc();
      if (addOp->kind == 1)
      {
        temp = temp2 + temp;
      }
      else if (addOp->kind == 2)
      {
        temp = temp2 - temp;
      }
    }
    return temp;
  }
};

// RelExp      ::= AddExp | RelExp ("<" | ">" | "<=" | ">=") AddExp;
class RelExpast : public Baseast
{
public:
  unique_ptr<Baseast> addexp;
  unique_ptr<Baseast> relexp;
  unique_ptr<Baseast> relop;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = addexp->Dump();
      count = addexp->count;
    }
    else if (kind == 2)
    {
      temp = Dumpop(relexp->Dump(), addexp->Dump(), relop->Dump());
      count = count_all;
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = addexp->Calc();
    }
    else if (kind == 2)
    {
      temp = addexp->Calc();
      int temp_rel = relexp->Calc();
      if (relop->kind == 1)
      {
        temp = (temp_rel < temp);
      }
      else if (relop->kind == 2)
      {
        temp = (temp_rel > temp);
      }
      else if (relop->kind == 3)
      {
        temp = (temp_rel <= temp);
      }
      else if (relop->kind == 4)
      {
        temp = (temp_rel >= temp);
      }
    }
    return temp;
  }
};

// EqExp       ::= RelExp | EqExp ("==" | "!=") RelExp;
class EqExpast : public Baseast
{
public:
  unique_ptr<Baseast> relexp;
  unique_ptr<Baseast> eqexp;
  unique_ptr<Baseast> eqop;

  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = relexp->Dump();
      count = relexp->count;
    }
    else if (kind == 2)
    {
      temp = Dumpop(eqexp->Dump(), relexp->Dump(), eqop->Dump());
      count = count_all;
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = relexp->Calc();
    }
    else if (kind == 2)
    {
      if (eqop->kind == 1)
        temp = (eqexp->Calc() == relexp->Calc());
      else if (eqop->kind == 2)
        temp = (eqexp->Calc() != relexp->Calc());
    }
    return temp;
  }
};

// LAndExp     ::= EqExp | LAndExp "&&" EqExp;
class LAndExpast : public Baseast
{
public:
  unique_ptr<Baseast> eqexp;
  unique_ptr<Baseast> op;
  unique_ptr<Baseast> landexp;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = eqexp->Dump();
      count = eqexp->count;
    }
    else if (kind == 2)
    {
      // 先用ne 将数值转换为逻辑
      string temp_landexp = DumpUnaryOp(landexp->Dump(), "ne");

      string temp_eqexp = DumpUnaryOp(eqexp->Dump(), "ne");

      temp = Dumpop(temp_landexp, temp_eqexp, "and");
      count = count_all;
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = eqexp->Calc();
    }
    else if (kind == 2)
    {
      temp = landexp->Calc() && eqexp->Calc();
    }
    return temp;
  }
};

// LOrExp      ::= LAndExp | LOrExp "||" LAndExp;
class LOrExpast : public Baseast
{
public:
  unique_ptr<Baseast> landexp;
  unique_ptr<Baseast> op;
  unique_ptr<Baseast> lorexp;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = landexp->Dump();
      count = landexp->count;
    }
    else if (kind == 2)
    {
      temp = Dumpop(lorexp->Dump(), landexp->Dump(), "or");

      //按位或和逻辑或相同 将结果转换为逻辑
      temp = DumpUnaryOp(temp, "ne");

      count = count_all;
    }
    return temp;
  }

  int Calc() override
  {
    int temp = 0;
    if (kind == 1)
    {
      temp = landexp->Calc();
    }
    else if (kind == 2)
    {
      temp = lorexp->Calc() || landexp->Calc();
    }
    return temp;
  }
};

class Opast : public Baseast
{
public:
  string str;
  string Dump() override
  {
    return str;
  }
  int Calc() override
  {
    return 0;
  }
};

#endif
