#include "ast.h"
int Baseast::count_all = -1;
string btype_str;
FILE * IR;
Fun_sym fun_symtab;
map<string, Symbol> symbolmap;
Symbol Symbol_find(string str){
  Symbol node;
  if(symbolmap.find(str)!=symbolmap.end()){
    return symbolmap[str];
  }
  int i=fun_symtab.vec_symbolmap.size()-1;
  for(;i>=0;i--)
  {
    if(fun_symtab.vec_symbolmap[i].find(str)!=fun_symtab.vec_symbolmap[i].end()){
      node=fun_symtab.vec_symbolmap[i][str];
      break;
    }
  }
  assert(i);
  return node;
}

string Dumpop(string temp1,string temp2, string op)
{
  //目前看op1 op2 都不需要
  
  char temp[MAXCHARS] = {0};
  Baseast::count_all++;
  sprintf(temp,"%%%d",Baseast::count_all);
  fprintf(IR, "  %s = %s %s, %s\n",temp, op.c_str(), temp1.c_str(), temp2.c_str());
  return temp;
}

string DumpUnaryOp(string temp1, string op)
{
  char temp[MAXCHARS] = {0};
  Baseast::count_all++;
  sprintf(temp,"%%%d",Baseast::count_all);
  fprintf(IR,"  %s = %s 0, %s\n",temp,op.c_str(),temp1.c_str());
  return temp;
}

string DumpLoad(string lval,int block_num){
  char temp[MAXCHARS]={0};
  Baseast::count_all++;
  sprintf(temp,"%%%d",Baseast::count_all);
  fprintf(IR,"  %s = load @%s_%d\n",temp,lval.c_str(),block_num);
  return temp;
}

string DumpStore(string temp1,string lval,int block_num){
  fprintf(IR,"  store %s, @%s_%d\n\n",temp1.c_str(),lval.c_str(),block_num);
  return temp1;
}

string DumpAlloc(string temp1,int block_num){
  fprintf(IR, "  @%s_%d = alloc i32\n", temp1.c_str(),block_num);
  return temp1;
}


