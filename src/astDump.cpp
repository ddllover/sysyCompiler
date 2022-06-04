#include "ast.h"
int Baseast::count_all = -1;
string btype_str;
FILE *IR;
Fun_sym fun_symtab;
map<string, Symbol> symbolmap;

bool ret_flag = false;
int IF_cnt = 0;
int While_cnt = 0;
vector<int> vec_while;
int Break_cnt = 0;
int Continue_cnt = 0;

Symbol Symbol_find(string str)
{
  Symbol node;
  if (symbolmap.find(str) != symbolmap.end())
  {
    return symbolmap[str];
  }
  int i = fun_symtab.vec_symbolmap.size() - 1;
  for (; i >= 0; i--)
  {
    if (fun_symtab.vec_symbolmap[i].find(str) != fun_symtab.vec_symbolmap[i].end())
    {
      node = fun_symtab.vec_symbolmap[i][str];
      break;
    }
  }
  assert(i);
  return node;
}

string Dumpop(string temp1, string temp2, string op)
{
  //目前看op1 op2 都不需要

  char temp[MAXCHARS] = {0};
  Baseast::count_all++;
  sprintf(temp, "%%%d", Baseast::count_all);
  fprintf(IR, "  %s = %s %s, %s\n", temp, op.c_str(), temp1.c_str(), temp2.c_str());
  return temp;
}

string DumpUnaryOp(string temp1, string op)
{
  char temp[MAXCHARS] = {0};
  Baseast::count_all++;
  sprintf(temp, "%%%d", Baseast::count_all);
  fprintf(IR, "  %s = %s 0, %s\n", temp, op.c_str(), temp1.c_str());
  return temp;
}

string DumpLoad(string lval, int block_num)
{
  char temp[MAXCHARS] = {0};
  Baseast::count_all++;
  sprintf(temp, "%%%d", Baseast::count_all);
  fprintf(IR, "  %s = load @%s_%d\n", temp, lval.c_str(), block_num);
  return temp;
}

string DumpStore(string temp1, string lval, int block_num)
{
  fprintf(IR, "  store %s, @%s_%d\n\n", temp1.c_str(), lval.c_str(), block_num);
  return temp1;
}

string DumpAlloc(string temp1, int block_num)
{
  fprintf(IR, "  @%s_%d = alloc i32\n", temp1.c_str(), block_num);
  return temp1;
}

string DumpIfElse(unique_ptr<Baseast> &exp, unique_ptr<Baseast> &then_block, unique_ptr<Baseast> &else_block, int con_num)
{
  string temp = exp->Dump();
  fprintf(IR, "  br %s, %%then_%d, %%else_%d\n\n", temp.c_str(), con_num, con_num);

  fprintf(IR, "%%then_%d:\n", con_num);
  then_block->Dump();
  ret_flag ? ret_flag = false : fprintf(IR, "  jump %%if_end_%d\n\n", con_num);

  fprintf(IR, "%%else_%d:\n", con_num);
  else_block->Dump();
  ret_flag ? ret_flag = false :fprintf(IR, "  jump %%if_end_%d\n\n", con_num);

  fprintf(IR, "%%if_end_%d:\n", con_num);
  return temp;
}
string DumpIf(unique_ptr<Baseast> &exp, unique_ptr<Baseast> &then_block, int con_num)
{
  string temp = exp->Dump();
  fprintf(IR, "  br %s, %%then_%d, %%if_end_%d\n\n", temp.c_str(), con_num, con_num);
  fprintf(IR, "%%then_%d:\n", con_num);
  then_block->Dump();
  ret_flag ? ret_flag = false :fprintf(IR, "  jump %%if_end_%d\n\n", con_num);

  fprintf(IR, "%%if_end_%d:\n", con_num);
  return temp;
}

string DumpWhile(unique_ptr<Baseast> &exp, unique_ptr<Baseast> &body, int con_num)
{
  vec_while.push_back(con_num);
  string temp;
  fprintf(IR, "  jump %%while_entry_%d\n\n", con_num);

  fprintf(IR, "%%while_entry_%d:\n", con_num);
  temp = exp->Dump();
  fprintf(IR, "  br %s, %%while_body_%d, %%while_end_%d\n\n", temp.c_str(), con_num, con_num);

  fprintf(IR, "%%while_body_%d:\n", con_num);
  body->Dump();
  ret_flag ? ret_flag = false :fprintf(IR, "  jump %%while_entry_%d\n\n", con_num);

  fprintf(IR, "%%while_end_%d:\n", con_num);
  vec_while.pop_back();
  return temp;
}
