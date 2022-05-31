
#include "ast.h"
//函数定义
using namespace std;

int BaseAST::count_all = -1;

void Visit(const koopa_raw_return_t &ret)
{
  cout << "  li a0, ";
  Visit(ret.value);
  cout << endl
       << "  ret" << endl;
}

// integer
void Visit(const koopa_raw_integer_t &ret)
{
  cout << ret.value;
}
// ..

void Visit(const koopa_raw_program_t &program)
{
  cout << "  .text" << endl;
  // 执行一些其他的必要操作
  // ...
  // 访问所有全局变量
  Visit(program.values);
  // 访问所有函数
  Visit(program.funcs);
}

// 访问 raw slice
void Visit(const koopa_raw_slice_t &slice)
{
  for (size_t i = 0; i < slice.len; ++i)
  {
    auto ptr = slice.buffer[i];
    // 根据 slice 的 kind 决定将 ptr 视作何种元素
    switch (slice.kind)
    {
    case KOOPA_RSIK_FUNCTION:
      // 访问函数
      Visit(reinterpret_cast<koopa_raw_function_t>(ptr));
      break;
    case KOOPA_RSIK_BASIC_BLOCK:
      // 访问基本块
      Visit(reinterpret_cast<koopa_raw_basic_block_t>(ptr));
      break;
    case KOOPA_RSIK_VALUE:
      // 访问指令
      Visit(reinterpret_cast<koopa_raw_value_t>(ptr));
      break;
    default:
      // 我们暂时不会遇到其他内容, 于是不对其做任何处理
      assert(false);
    }
  }
}

// 访问函数
void Visit(const koopa_raw_function_t &func)
{
  // 执行一些其他的必要操作
  // ...
  cout << "  .globl " << func->name + 1 << endl;
  cout << func->name + 1 << ":" << endl;
  // 访问所有基本块
  Visit(func->bbs);
}

// 访问基本块
void Visit(const koopa_raw_basic_block_t &bb)
{
  // 执行一些其他的必要操作
  // ...
  // 访问所有指令
  Visit(bb->insts);
}

// 访问指令
void Visit(const koopa_raw_value_t &value)
{
  // 根据指令类型判断后续需要如何访问
  const auto &kind = value->kind;
  switch (kind.tag)
  {
  case KOOPA_RVT_RETURN:
    // 访问 return 指令
    Visit(kind.data.ret);
    break;
  case KOOPA_RVT_INTEGER:
    // 访问 integer 指令
    Visit(kind.data.integer);
    break;
  default:
    // 其他类型暂时遇不到
    assert(false);
  }
}

void AnalyzeIR(const char *str)
{
  // 解析字符串 str, 得到 Koopa IR 程序
  koopa_program_t program;
  koopa_error_code_t ret = koopa_parse_from_string(str, &program);
  assert(ret == KOOPA_EC_SUCCESS); // 确保解析时没有出错
  // 创建一个 raw program builder, 用来构建 raw program
  koopa_raw_program_builder_t builder = koopa_new_raw_program_builder();
  // 将 Koopa IR 程序转换为 raw program
  koopa_raw_program_t raw = koopa_build_raw_program(builder, program);
  // 释放 Koopa IR 程序占用的内存
  koopa_delete_program(program);

  // 处理 raw program
  // ...
  // freopen(output,"w",stdout);
  Visit(raw);
  // fclose(stdout);
  //  处理完成, 释放 raw program builder 占用的内存
  //  注意, raw program 中所有的指针指向的内存均为 raw program builder 的内存
  //  所以不要在 raw program 处理完毕之前释放 builder
  koopa_delete_raw_program_builder(builder);
}

string Dumpop(unique_ptr<BaseAST> &op1, unique_ptr<BaseAST> &op2,const char *temp2,const char *temp1, const char *op)
{
  char temp[MAXCHARS] = {0};
  //char temp1[MAXCHARS] = {0};
  //strcpy(temp2, op2->Dump().c_str());
  //strcpy(temp1, op1->Dump().c_str());
  if (temp1[0] == ' ')
  {
    if (temp2[0] == ' ') // op1为表达式，op2为表达式
      sprintf(temp, "%s%s  %%%d = %s %%%d, %%%d\n", temp2, temp1, BaseAST::count_all + 1, op, op1->count, op2->count);
    else // op1为表达式，op2为数字
      sprintf(temp, "%s  %%%d = %s %%%d, %s\n", temp1, BaseAST::count_all + 1, op, op1->count, temp2);
  }
  else
  {
    if (temp2[0] == ' ') // op1为数字，op2为表达式
      sprintf(temp, "%s  %%%d = %s %s, %%%d\n", temp2, BaseAST::count_all + 1, op, temp1, op2->count);
    else
      sprintf(temp, "  %%%d = %s %s, %s\n", BaseAST::count_all + 1, op, temp1, temp2);
  }
  return temp;
}

string DumpUnaryOp(unique_ptr<BaseAST> &op1,const char *temp1, const char *op)
{
  char temp[MAXCHARS] = {0};
  //strcpy(temp1, op1->Dump().c_str());
  if (temp1[0] != ' ') //非表达式 代表该部分前面没有任何运算
  {
    sprintf(temp, "  %%%d = %s 0, %s\n", BaseAST::count_all + 1, op, temp1);
  }
  else
  {
    //最新的指令编号
    sprintf(temp, "%s  %%%d = %s 0, %%%d\n", temp1, BaseAST::count_all + 1, op, op1->count);
  }
  return temp;
}