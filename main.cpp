
#include <iostream>
using namespace std;

extern int yylex();
int main(){
while(1){
cout<<yylex()<<endl;
}
return 0;
}
