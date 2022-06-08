int c=1;
int T(){
  c=2;
  return 1;
}
int main(){
  //int c=1;
  c=T()+c;
  return 0;
}