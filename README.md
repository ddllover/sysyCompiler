# 测试环境
北大编译实践教学用编译器开发环境 (Compiler Development Environment).

该仓库的内容将被打包为 Docker 镜像, 所以不建议直接使用该仓库, 具体使用方法见[使用方法](#使用方法)一节.

## 使用方法

### 从 Docker Hub 获取

推荐使用该方法.

```sh
docker run -it --rm maxxing/compiler-dev bash
```

### 从仓库构建

```sh
cd docker
make # or `sudo make`
docker run -it --rm compiler-dev bash
```

## 镜像中包含的内容

* 必要的工具: `git`, `flex`, `bison`, `python3` (用于运行测试脚本).
* 构建工具: `make`, `cmake`.
* 运行工具: `qemu-user-static`.
* 编译工具链: Rust 工具链, LLVM 工具链.
* Koopa IR 相关工具: `libkoopa`, `koopac`.
* 测试脚本: `autotest`.

## 缺陷/待处理

* [ ] 目前的镜像会安装各类预编译工具链 (例如 LLVM), 但其中部分工具链不支持 `aarch64`, 这也许会给使用搭载了 Apple Silicon 平台的同学带来困扰. 是否考虑从源代码编译?


# 实现目标
将SysY语言编译到RISC-V汇编的编译器，SysY语言为一个精简版的c语言，将SysY语言编译到Koopa IR，将Koopa IR生成RISC-V汇编

## SysY语言文法定义
```
CompUnit      ::= [CompUnit] (Decl | FuncDef);

Decl          ::= ConstDecl | VarDecl;
ConstDecl     ::= "const" BType ConstDef {"," ConstDef} ";";
BType         ::= "int";
ConstDef      ::= IDENT {"[" ConstExp "]"} "=" ConstInitVal;
ConstInitVal  ::= ConstExp | "{" [ConstInitVal {"," ConstInitVal}] "}";
VarDecl       ::= BType VarDef {"," VarDef} ";";
VarDef        ::= IDENT {"[" ConstExp "]"}
                | IDENT {"[" ConstExp "]"} "=" InitVal;
InitVal       ::= Exp | "{" [InitVal {"," InitVal}] "}";

FuncDef       ::= FuncType IDENT "(" [FuncFParams] ")" Block;
FuncType      ::= "void" | "int";
FuncFParams   ::= FuncFParam {"," FuncFParam};
FuncFParam    ::= BType IDENT ["[" "]" {"[" ConstExp "]"}];

Block         ::= "{" {BlockItem} "}";
BlockItem     ::= Decl | Stmt;
Stmt          ::= LVal "=" Exp ";"
                | [Exp] ";"
                | Block
                | "if" "(" Exp ")" Stmt ["else" Stmt]
                | "while" "(" Exp ")" Stmt
                | "break" ";"
                | "continue" ";"
                | "return" [Exp] ";";

Exp           ::= LOrExp;
LVal          ::= IDENT {"[" Exp "]"};
PrimaryExp    ::= "(" Exp ")" | LVal | Number;
Number        ::= INT_CONST;
UnaryExp      ::= PrimaryExp | IDENT "(" [FuncRParams] ")" | UnaryOp UnaryExp;
UnaryOp       ::= "+" | "-" | "!";
FuncRParams   ::= Exp {"," Exp};
MulExp        ::= UnaryExp | MulExp ("*" | "/" | "%") UnaryExp;
AddExp        ::= MulExp | AddExp ("+" | "-") MulExp;
RelExp        ::= AddExp | RelExp ("<" | ">" | "<=" | ">=") AddExp;
EqExp         ::= RelExp | EqExp ("==" | "!=") RelExp;
LAndExp       ::= EqExp | LAndExp "&&" EqExp;
LOrExp        ::= LAndExp | LOrExp "||" LAndExp;
ConstExp      ::= Exp;

```
## [koopa IR 规范](https://github.com/pku-minic/online-doc/blob/master/docs/misc-app-ref/koopa.md)

## 示例
sysy程序
```c
int fib(int n) {
  if (n <= 2) {
    return 1;
  } else {
    return fib(n - 1) + fib(n - 2);
  }
}

int main() {
  int input = getint();
  putint(fib(input));
  putch(10);
  return 0;
}
```
RISC-V
```
  .text
  .align  2

  .globl fib
fib:
  sw    ra, -4(sp)
  addi  sp, sp, -16
  li    t1, 2
  bgt   a0, t1, .l0
  li    a0, 1
  addi  sp, sp, 16
  lw    ra, -4(sp)
  ret
.l0:
  addi  s4, a0, -1
  sw    a0, 0(sp)
  mv    a0, s4
  call  fib
  mv    a3, a0
  lw    a0, 0(sp)
  addi  s4, a0, -2
  sw    a3, 0(sp)
  mv    a0, s4
  call  fib
  mv    s4, a0
  lw    a3, 0(sp)
  add   s4, a3, s4
  mv    a0, s4
  addi  sp, sp, 16
  lw    ra, -4(sp)
  ret

  .globl main
main:
  sw    ra, -4(sp)
  addi  sp, sp, -16
  call  getint
  call  fib
  call  putint
  li    a0, 10
  call  putch
  li    a0, 0
  addi  sp, sp, 16
  lw    ra, -4(sp)
  ret
```
