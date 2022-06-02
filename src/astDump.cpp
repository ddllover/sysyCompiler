#include "ast.h"
int Baseast::count_all = -1;
map<string, Symbol> Symbolmap;
string btype_str;
FILE * IR;

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

string DumpLoad(string lval){
  char temp[MAXCHARS]={0};
  Baseast::count_all++;
  sprintf(temp,"%%%d",Baseast::count_all);
  fprintf(IR,"  %s = load @%s\n",temp,lval.c_str());
  return temp;
}

string DumpStore(string temp1,string lval){
  fprintf(IR,"  store %s, @%s\n\n",temp1.c_str(),lval.c_str());
  return temp1;
}


