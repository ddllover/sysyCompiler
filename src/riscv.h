#pragma once

#include "koopa.h"
#include<iostream>
#include<assert.h>
#include<string.h>
#include <map>

#define IRMAXCHAR 100000

using namespace std;
extern FILE * ASM;

void reg_init();
int Release_reg(string reg);

void Sw_stack(string reg, int size);
void Lw_stack(string reg, int size);
void Addi(string reg, int size);
bool Is_stack(const koopa_raw_value_t &value);
int Count_fun_size(const koopa_raw_function_t &func);
int Calc_array_size(const koopa_raw_type_kind *base);

string Alloca_stack(const koopa_raw_value_t &value);


void Visit(const koopa_raw_slice_t &slice);

void Visit(const koopa_raw_program_t &program);
void Visit(const koopa_raw_function_t &func);
void Visit(const koopa_raw_basic_block_t &bb);
void GlobalVisit(const koopa_raw_value_t &value);
void FunVisit(const koopa_raw_value_t &value);
string FunValueVisit(const koopa_raw_value_t &value);

void Visit(const koopa_raw_binary_t &exp);
//void Visit(const koopa_raw_integer_t &ret);
void Visit(const koopa_raw_return_t &ret);
void Visit(const koopa_raw_call_t &value);

void AnalyzeIR(const char *str);
