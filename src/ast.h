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

class Baseast
{
public:
  virtual ~Baseast() = default;
  static int Count_Order;
  // int count; //代表该节点结果的代数
  int kind; //字节点序号

  virtual string Dump() = 0;
  virtual int Calc() = 0;
};

extern string btype_str; // 声明时变量类型，以便所有声明的变量种类初始化
extern FILE *IR;

extern bool ret_flag;
extern int While_cnt; //记录条件指令个数
extern vector<int> vec_while;
extern int IF_cnt;
extern int Break_cnt;
extern int Continue_cnt;

void Fun_init();

struct Symbol
{
  int kind;      // 0为局部const常量 1为局部符号变量 2为全局const 3为全局变量
  int val;       // 没有初始化时，默认为0
  string type;   //变量类型
  int block_num; //记录符号所属于的block
};

struct Fun_sym //每个函数符号表
{
  int block_num;                             //记录当前block的序号，
  vector<map<string, Symbol>> vec_symbolmap; //函数内每个块的符号表
  int block_cnt;                             // 记录所有block的块的个数，用于命名防止名称重复
  int type;                                  //函数类型1为void  2为int
  Fun_sym()
  {
    block_num = 0;
    block_cnt = 0;
    type=0;
  }
  void clear()
  {
    block_num = 0;
    block_cnt = 0;
    type=0;
    vec_symbolmap.clear();
  }
};
extern map<string, int> all_fun_symtab; //所有函数的符号表
extern map<string, Symbol> glo_symbolmap;   //全局变量
extern bool global;

extern Fun_sym fun_symtab;            //当前函数的符号表
extern map<string, Symbol> symbolmap; //代表当前block符号表,便于操作

Symbol Symbol_find(string str);

void Visit(const koopa_raw_slice_t &slice);
void Visit(const koopa_raw_function_t &func);
void Visit(const koopa_raw_basic_block_t &bb);
void Visit(const koopa_raw_value_t &value);
void Visit(const koopa_raw_program_t &program);
void AnalyzeIR(const char *str);

void Decl();
string Dumpop(string temp1, string temp2, string op);
string DumpUnaryOp(string temp1, string op);
string DumpLoad(string lval, int block_num);
string DumpStore(string temp1, string lval, int block_num);
string DumpAlloc(string temp1, int block_num);
string DumpWhile(unique_ptr<Baseast> &exp, unique_ptr<Baseast> &body, int con_num);
string DumpIfElse(unique_ptr<Baseast> &exp, unique_ptr<Baseast> &then_block, unique_ptr<Baseast> &else_block, int con_num);
string DumpIf(unique_ptr<Baseast> &exp, unique_ptr<Baseast> &then_block, int con_num);
string DumpCall(string ident, string param);

class AST:public Baseast{
  public:
  unique_ptr<Baseast> compunit;
  string Dump() override{
    return compunit->Dump();
  }
  int Calc() override{
    return 0;
  }
};

////CompUnit:Unit|CompUnit Unit;
class CompUnitast : public Baseast
{
public:
  // 用智能指针管理对象
  unique_ptr<Baseast> compunit;
  unique_ptr<Baseast> unit;
  string Dump() override // override确保虚函数覆盖基类的虚函数
  {
    string temp;
    if (kind == 1)
    {
      unit->Dump();
    }
    else if (kind == 2)
    {
      compunit->Dump();
      unit->Dump();
    }
    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};

// Unit :FuncDef|VarDecl|ConstDecl;  //全局变量
class Unitast : public Baseast
{
public:
  unique_ptr<Baseast> funcdef;
  unique_ptr<Baseast> vardecl;
  unique_ptr<Baseast> constdecl;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      // all_symtab.vec_fun_symtab
      funcdef->Dump();
    }
    else if (kind == 2)
    {
      global = true;
      vardecl->Dump();
      global = false;
    }
    else if (kind == 3)
    {
      global = true;
      constdecl->Calc();
      global = false;
    }
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
    int val=constinitval->Calc();
    if (!global)
    {
      symbolmap.insert({ident, {0,val , btype_str, fun_symtab.block_num}});
    }
    else
    {
      glo_symbolmap.insert({ident, {2, val, btype_str, -1}});
    }
#ifdef DEBUG
    cout << "const:" << ident << " " <<val << endl;
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

    if (!global)
    {
      //局部变量只需要表明类型以及和const区分，值由IR计算
  
      symbolmap.insert({ident, {1, 0, btype_str, fun_symtab.block_num}});

      //  vardef 声明 @ident = alloc btype_str
      DumpAlloc(ident, fun_symtab.block_num);

      // 定义 store %count, @ident
      if (kind == 2 || kind == 4)
      {
        DumpStore(initval->Dump(), ident, fun_symtab.block_num);
      }
      else
      {
        fprintf(IR, "\n"); //每个变量划分一个块便于debug
      }

      if (kind == 3 || kind == 4)
      {
        vardef->Dump();
      }
    }
    else
    {
      int val = 0; //全局变量必须定义初始值
      if (kind == 2 || kind == 4)
      {
        val = initval->Calc();
      }
      glo_symbolmap.insert({ident, {3, val, btype_str, -1}});
      fprintf(IR, "global @%s = alloc %s, ", ident.c_str(), btype_str.c_str());
      if (val == 0)
      {
        fprintf(IR, "zeroinit\n");
      }
      else
      {
        fprintf(IR, "%d\n", val);
      }
      if (kind == 3 || kind == 4)
      {
        vardef->Dump();
      }
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
    return temp;
  }
  int Calc() override
  {
    return exp->Calc();
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
    if (ret_flag)
      return temp;
    if (blockitem->kind != 1) // blockitem 不为空 为空返回空  空{}不计入block_num
    {
      //建立新的符号表
      fun_symtab.vec_symbolmap.push_back(symbolmap);
      int fun_block_num = fun_symtab.block_num;
      fun_symtab.block_cnt++;
      fun_symtab.block_num = fun_symtab.block_cnt;
      symbolmap.clear();

      temp = blockitem->Dump();

      symbolmap = fun_symtab.vec_symbolmap.back();
      fun_symtab.vec_symbolmap.pop_back();
      fun_symtab.block_num = fun_block_num;
      // if(ret_flag) ret_flag=false;
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
    if (ret_flag)
      return temp;
    if (kind == 1) //为空返回值无用
    {
      return "";
    }
    else if (kind == 2)
    {

      decl->Dump();
      blockitem->Dump();
    }
    else if (kind == 3)
    {
      stmt->Dump();
      blockitem->Dump();
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

    Symbol lval_sym = Symbol_find(ident);
    // Symbol lval_sym = lval_symtab->symbolmap[ident];
    // assert(!lval_sym.kind);  全局变量的初始值可以用全局变量定义
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
    }
    else if (kind == 2)
    {
      temp = to_string(number);
    }
    else if (kind == 3)
    {
      string ident = lval->Dump();
      // Symboltab *lval_symtab = Symtab_find(dump_symtab, ident);
      Symbol lval_sym = Symbol_find(ident);
      if (lval_sym.kind == 0||lval_sym.kind==2)
      { // const常量
        temp = to_string(lval_sym.val);
      }
      else if (lval_sym.kind == 1||lval_sym.kind==3)
      { // 变量
        temp = DumpLoad(ident, lval_sym.block_num);
      }
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

// FuncDef     ::= Void IDENT "(" FuncArgs ")" Block|Btpye IDENT "(" FuncArgs")" Block ;
class FuncDefast : public Baseast
{
public:
  unique_ptr<Baseast> btype;
  string ident;
  unique_ptr<Baseast> funcargs;
  unique_ptr<Baseast> block;
  string Dump() override
  {
    string temp;
    Fun_init();
    fprintf(IR, "fun @%s(", ident.c_str());
    funcargs->Dump();
    if (kind == 1)
    { // void 类型单独输出
      fprintf(IR, ") {\n%%entry:\n");
      fun_symtab.type = 1;
    }
    else if (kind == 2)
    { //): %s{\n%%entry:\n
      fprintf(IR, "):%s {\n%%entry:\n", btype->Dump().c_str());
      fun_symtab.type = 2;
    }
    all_fun_symtab.insert({ident, fun_symtab.type});
    funcargs->Dump();
    block->Dump();
    if(!ret_flag) fprintf(IR,"  ret\n");
    fprintf(IR, "}\n\n");

    

    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};

// FuncArgs :|FuncFParams
class FuncArgsast : public Baseast
{
public:
  unique_ptr<Baseast> funcfparams;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
    }
    else if (kind == 2)
    {
      funcfparams->Dump();
    }
    return temp;
  }
  int Calc() override
  {
    return 0;
  }
};

// FuncFParams : FuncFParam| FuncFParam ',' FuncFParams;
class FuncFParamsast : public Baseast
{
public:
  unique_ptr<Baseast> funcfparam;
  unique_ptr<Baseast> funcfparams;
  int Dump_cnt = 1;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      funcfparam->Dump();
    }
    else
    {
      funcfparam->Dump();
      if (Dump_cnt == 1)
      {
        fprintf(IR, " , ");
        Dump_cnt = 2;
      }
      else if(Dump_cnt==2)
      {
        Dump_cnt = 1;
      }
      funcfparams->Dump();
    }
    return temp;
  }
  int Calc() override
  {
    return 0;
  }
};

// FuncFParam  :BType IDENT;
class FuncFParamast : public Baseast
{
public:
  unique_ptr<Baseast> btype;
  string ident;
  int Dump_cnt = 1;
  string Dump() override
  {
    string temp;
    if (Dump_cnt == 1)
    {
      fprintf(IR, "%%%s:%s", ident.c_str(), btype->Dump().c_str());
      Dump_cnt=2;
    }
    else if (Dump_cnt == 2)
    {
      symbolmap.insert({ident,{1,0,btype->Dump(),fun_symtab.block_num}});
      DumpAlloc(ident, fun_symtab.block_num);
      DumpStore("%" + ident, ident, fun_symtab.block_num);
      Dump_cnt = 1;
    }
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
  unique_ptr<Baseast> btype;
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

// stmt : Exma | UExma
class Stmtast : public Baseast
{
public:
  unique_ptr<Baseast> exma;
  unique_ptr<Baseast> uexma;
  string Dump() override
  {
    string temp;
    if (ret_flag)
      return temp;
    if (kind == 1)
    {
      exma->Dump();
    }
    else if (kind == 2)
    {
      uexma->Dump();
    }
    return temp;
  }

  int Calc() override
  {
    return 0;
  }
};

// UExma ->WHILE '(' Exp ')' UExma| IF '(' Exp ')' Stmt | IF '(' Exp ')' Exma ELSE UExma |
class UExmaast : public Baseast
{
public:
  unique_ptr<Baseast> stmt;
  unique_ptr<Baseast> exp;
  unique_ptr<Baseast> uexma;
  unique_ptr<Baseast> exma;
  // int con_num; //记录此时if while的语句的次序
  string Dump() override
  {
    string temp;
    if (ret_flag)
      return temp;
    if (kind == 1)
    { // IF '(' Exp ')' Stmt    base_cnt //基本块划分IF WHILE 命令数
      While_cnt++;
      DumpWhile(exp, uexma, While_cnt);
    }
    else if (kind == 2)
    {
      IF_cnt++;
      DumpIf(exp, stmt, IF_cnt);
    }
    else if (kind == 3)
    {
      IF_cnt++;
      DumpIfElse(exp, exma, uexma, IF_cnt);
    }
    return temp;
  }
  int Calc() override
  {
    return 0;
  }
};

/*Exma          ::= return';'|"return" Exp ";"|LVal "=" Exp ";"| ';'|Exp ";"|Block
 | IF '(' Exp ')' Exma ELSE Exma   | WHILE '(' Exp ')' Exma | BREAK ';' | CONTINUE ';'*/
class Exmaast : public Baseast
{
public:
  unique_ptr<Baseast> exp;
  unique_ptr<Baseast> lval;
  unique_ptr<Baseast> block; //符号表迭代一层
  unique_ptr<Baseast> exma_if;
  unique_ptr<Baseast> exma_else;
  unique_ptr<Baseast> exma_while;
  string Dump() override
  {
    string temp;
    if (ret_flag)
      return temp;
    if (kind == 1)
    { // return';'
      fprintf(IR, "  ret\n\n");
      ret_flag = true;
    }
    if (kind == 2) //"return" Exp ";"
    {
      fprintf(IR, "  ret %s\n\n", exp->Dump().c_str());
      ret_flag = true;
    }
    else if (kind == 3) // LVal "=" Exp ";"
    {
      // lval 在stmt需要 store ,lval 在exp中需要load
      string ident = lval->Dump();
      Symbol lval_sym = Symbol_find(ident);

      DumpStore(exp->Dump(), ident, lval_sym.block_num);
    }
    else if (kind == 4) //';'
    {
      // 空
    }
    else if (kind == 5) // exp ';'
    {
      exp->Dump();
    }
    else if (kind == 6) // Block
    {                   //符号表加深一层
      temp = block->Dump();
    }
    else if (kind == 7) // IF '(' Exp ')' Exma ELSE Exma
    {
      IF_cnt++;
      DumpIfElse(exp, exma_if, exma_else, IF_cnt);
    }
    else if (kind == 8) // WHILE '(' Exp ')' Exma
    {
      While_cnt++;
      DumpWhile(exp, exma_while, While_cnt);
    }
    else if (kind == 9) // BREAK ';'
    {
      Break_cnt++;
      int temp_while_cnt = vec_while.back();
      fprintf(IR, "  jump %%while_end_%d\n\n", temp_while_cnt);
      fprintf(IR, "%%while_body_%d_%d:\n", temp_while_cnt, Break_cnt);
    }
    else if (kind == 10) // CONTINUE ';'
    {
      Continue_cnt++;
      int temp_while_cnt = vec_while.back();
      fprintf(IR, "  jump %%while_entry_%d\n\n", temp_while_cnt);
      fprintf(IR, "%%while_body_%d_%d:\n", temp_while_cnt, Continue_cnt);
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
    return temp;
  }
  int Calc() override
  {
    return lorExp->Calc();
  }
};

// UnaryExp    : PrmaryExp|UnaryOp UnaryExp | IDENT '(' ')'|IDENT '(' FuncRParams')';
class UnaryExpast : public Baseast
{
public:
  unique_ptr<Baseast> primary;
  unique_ptr<Baseast> unaryop;
  unique_ptr<Baseast> unaryexp;
  string ident;
  unique_ptr<Baseast> funcrparams;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = primary->Dump();
    }
    else if (kind == 2)
    {
      if (unaryop->kind == 1)
      { //正,不需要处理
        temp = unaryexp->Dump();
      }
      else
      {
        temp = DumpUnaryOp(unaryexp->Dump(), unaryop->Dump());
      }
    }
    else if (kind == 3)
    {
      temp = DumpCall(ident, "");
      // fprintf(IR,"%%%d call @%s()",ident)
    }
    else if (kind == 4)
    {
      temp = DumpCall(ident, funcrparams->Dump());
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

// FuncRParams:Exp|Exp ',' FuncRParams
class FuncRParamsast : public Baseast
{
public:
  unique_ptr<Baseast> funcrparams;
  unique_ptr<Baseast> exp;
  string Dump() override
  {
    string temp;
    if (kind == 1)
    {
      temp = exp->Dump();
    }
    else if (kind == 2)
    {
      temp = exp->Dump() + "," + funcrparams->Dump();
    }
    return temp;
  }
  int Calc() override
  {
    return 0;
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
    }
    else if (kind == 2)
    {
      //可再分temp为空
      temp = Dumpop(mulExp->Dump(), unaryExp->Dump(), mulop->Dump());
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
    }
    else if (kind == 2)
    {
      temp = Dumpop(addExp->Dump(), mulExp->Dump(), addOp->Dump());
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
    }
    else if (kind == 2)
    {
      temp = Dumpop(relexp->Dump(), addexp->Dump(), relop->Dump());
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
    }
    else if (kind == 2)
    {
      temp = Dumpop(eqexp->Dump(), relexp->Dump(), eqop->Dump());
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
    }
    else if (kind == 2)
    {
      // 短路求值
      IF_cnt++;
      int con_num=IF_cnt;
      fprintf(IR,"  @result_%d = alloc i32\n",con_num);
      fprintf(IR,"  store 0,@result_%d\n",con_num);
      temp = DumpUnaryOp(landexp->Dump(), "ne");
      fprintf(IR, "  br %s, %%then_%d, %%if_end_%d\n\n", temp.c_str(), con_num,con_num);
      fprintf(IR, "%%then_%d:\n", con_num);
      temp=DumpUnaryOp(eqexp->Dump(),"ne");
      fprintf(IR," store %s,@result_%d\n",temp.c_str(),con_num);
      fprintf(IR, "  jump %%if_end_%d\n\n", con_num);

      fprintf(IR, "%%if_end_%d:\n", con_num);
      Count_Order++;
      temp="%"+to_string(Count_Order);
      fprintf(IR,"  %s= load @result_%d\n",temp.c_str(),con_num);
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
    }
    else if (kind == 2)
    {
      //短路求值
      IF_cnt++;
      int con_num=IF_cnt;
      fprintf(IR,"  @result_%d = alloc i32\n",con_num);
      fprintf(IR,"  store 1,@result_%d\n",con_num);
      temp = DumpUnaryOp(lorexp->Dump(), "ge");
      fprintf(IR, "  br %s, %%then_%d, %%if_end_%d\n\n", temp.c_str(), con_num,con_num);
      fprintf(IR, "%%then_%d:\n",con_num);
      temp=DumpUnaryOp(landexp->Dump(),"ne");
      fprintf(IR," store %s,@result_%d\n",temp.c_str(),con_num);
      fprintf(IR, "  jump %%if_end_%d\n\n", con_num);

      fprintf(IR, "%%if_end_%d:\n", con_num);
      Count_Order++;
      temp="%"+to_string(Count_Order);
      fprintf(IR,"  %s= load @result_%d\n",temp.c_str(),con_num);
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
