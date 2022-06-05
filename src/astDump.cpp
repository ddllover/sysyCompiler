#include "ast.h"
int Baseast::Count_Order = -1;
string btype_str;
FILE *IR;

map<string, Symbol> glo_symbolmap;
map<string, int> all_fun_symtab;
bool global=false;
Fun_sym fun_symtab;
map<string, Symbol> symbolmap;


bool ret_flag = false;
int IF_cnt = 0;
int While_cnt = 0;
vector<int> vec_while;
int Break_cnt = 0;
int Continue_cnt = 0;

void Fun_init(){
  ret_flag = false;
  IF_cnt = 0;
  While_cnt=0;
  vec_while.clear();
  Break_cnt=0;
  Continue_cnt=0;
  Baseast::Count_Order=-1;
  fun_symtab.clear();
  symbolmap.clear();
}
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
  if(glo_symbolmap.find(str)!=glo_symbolmap.end()){
    return glo_symbolmap[str];
  }
  assert(i!=-1);
  return node;
}

string Dumpop(string temp1, string temp2, string op)
{
  //目前看op1 op2 都不需要

  char temp[MAXCHARS] = {0};
  Baseast::Count_Order++;
  sprintf(temp, "%%%d", Baseast::Count_Order);
  fprintf(IR, "  %s = %s %s, %s\n", temp, op.c_str(), temp1.c_str(), temp2.c_str());
  return temp;
}

string DumpUnaryOp(string temp1, string op)
{
  char temp[MAXCHARS] = {0};
  Baseast::Count_Order++;
  sprintf(temp, "%%%d", Baseast::Count_Order);
  fprintf(IR, "  %s = %s 0, %s\n", temp, op.c_str(), temp1.c_str());
  return temp;
}

string DumpLoad(string lval, int block_num)
{
  char temp[MAXCHARS] = {0};
  Baseast::Count_Order++;
  sprintf(temp, "%%%d", Baseast::Count_Order);
  fprintf(IR, "  %s = load @%s", temp, lval.c_str());
  if(block_num!=-1){//-1为全局量
    fprintf(IR,"_%d",block_num);
  }
  fprintf(IR,"\n");
  return temp;
}

string DumpStore(string temp1, string lval, int block_num)
{
  fprintf(IR, "  store %s, @%s", temp1.c_str(), lval.c_str());
  if(block_num!=-1){//-1为全局量
    fprintf(IR,"_%d",block_num);
  }
  fprintf(IR,"\n\n");
  return temp1;
}

string DumpAlloc(string temp1, int block_num)
{
  fprintf(IR, "  @%s",temp1.c_str());
  if(block_num!=-1){
  fprintf(IR,"_%d",  block_num);
  }
  fprintf(IR,"= alloc i32\n");
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

string DumpCall(string ident,string param){
  char temp[MAXCHARS]={0};
  if(all_fun_symtab[ident]==1){//void;
    fprintf(IR,"  call @%s(%s)\n",ident.c_str(),param.c_str());
  }
  else  if(all_fun_symtab[ident]==2) {
    Baseast::Count_Order++;
    sprintf(temp,"%%%d",Baseast::Count_Order);
    fprintf(IR,"  %s = call @%s(%s)\n",temp,ident.c_str(),param.c_str());
  }
  return temp;
}

void Decl(){
  fprintf(IR,"decl @getint(): i32\ndecl @getch(): i32\ndecl @getarray(*i32): i32\ndecl @putint(i32)\ndecl @putch(i32)\ndecl @putarray(i32, *i32)\ndecl @starttime()\ndecl @stoptime()\n\n");
  all_fun_symtab.insert({"getint",2});
  all_fun_symtab.insert({"getch",2});
  all_fun_symtab.insert({"getarray",2});
  all_fun_symtab.insert({"putint",1});
  all_fun_symtab.insert({"putch",1});
  all_fun_symtab.insert({"putarray",1});
  all_fun_symtab.insert({"starttime",1});
  all_fun_symtab.insert({"stoptime",1});
}