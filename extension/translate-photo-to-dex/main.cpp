#include<bits/stdc++.h>
#include<windows.h>
#include<filesystem>
#include "stb_image.h"
#define index(x,y) (y*160)+x
using namespace std;
string commad_="@wasm4.set_frame_buffer(";
map<int,int> pallet ={{0x150369,1},{0xFFA729,2},{0x4FB8FF,3},{0xAB38DE,4}};

string address,name;
int x,y;
int width;
int height;
int channel;
int color[200][200];


struct Sprite{
    int xx,yy;
    int color;
    string ans;
    inline void build_ans(){
        ans=commad_+to_string(index(xx+x,yy+y))+","+to_string(color)+")\n";
    }
}sprite[5000];
int ans_cnt=0;

inline string get_name(const string & C){
    int a=C.find_last_of('\\');
    if(a==C.size()) return "";
    else return C.substr(a+1,C.length()-a-1-4);
}

inline bool check_valid(const string& address){
    if(address.length()<4) {cout<<"Not png!!!\n";return 0;}
    if(address.substr(address.length()-4)!=".png") {cout<<"Not png!!!\n";return 0;}
    std::filesystem::path AD(address);
    if(std::filesystem::exists(AD)) return 1;
    else {cout<<"Not find file\n";return 0;}
}

inline void check_color(){
    unsigned char* data=stbi_load(address.c_str(),&width,&height,&channel,0);
    for(int index,y=0;y<height;y++){
        for(int x=0;x<width;x++){
            index=(y*width+x)*channel;
            color[y][x]|=(data[index]<<16);
            color[y][x]|=(data[index+1]<<8);
            color[y][x]|=(data[index+2]);
            // if(channel==4&&data[index+4]==0) color[y][x]=-1;
            if(pallet.find(color[y][x])==pallet.end()) {cout<<"use invalid color!!\n"<<"First appear at"<<x<<","<<y<<endl;exit(0);}
            else color[y][x]=pallet[color[y][x]];
        }
    }
}

inline void two_bit(){
    for(int i=0;i<height;i++){
        for(int j=0;j<width;j++){
            if(color[i][j]==-1) continue;
            sprite[++ans_cnt].xx=j;
            sprite[ans_cnt].yy=i;
            sprite[ans_cnt].color=color[i][j];
            sprite[ans_cnt].build_ans();
        }
    }
}

ostream & operator << (ostream & OOUT,const Sprite & a){
    OOUT<<"{x:"<<a.xx<<",y:"<<a.yy<<",color:"<<a.color<<"},"<<endl;
    return OOUT;
}

inline void set_pallet(){
    for(pair<int,int> i : pallet){
        cout<<"@wasm4.set_palette("<<i.second<<","<<"@wasm4.rgb("<<i.first<<")"<<")\n";
    }
}

inline void ban_ground(){
    queue<pair<int,int> > p;
    for(int i=0;i<height;i++){
        if(color[i][0]==1) p.push(make_pair(i,0)),color[i][0]=-1;
        if(color[i][width-1]==1) p.push(make_pair(i,0)),color[i][width-1]=-1;
    }
    for(int i=0;i<width;i++){
        if(color[0][i]==1) p.push(make_pair(i,0)),color[0][i]=-1;
        if(color[height-1][i]==1) p.push(make_pair(i,0)),color[height-1][i]=-1;
    }
    int move_y[4]={0,-1,0,1};
    int move_x[4]={1,0,-1,0};
    while(!p.empty()){
        for(int i=0;i<4;i++){
            int new_y=p.front().first+move_y[i];
            int new_x=p.front().second+move_x[i];
            if(new_y<0||new_y>=height||new_x<0||new_x>=width) continue;
            if(color[new_y][new_x]!=1) continue;
            p.push(make_pair(new_y,new_x));
            color[new_y][new_x]=-1;
        }
        p.pop();
    }
}

int main() {
    cout<<__cplusplus<<endl;
    cout<<"Please input the address of png.\n";
    cout<<"attention: only png is supported.\n";
    cin>>address;
    while(!check_valid(address)){
        cout<<"Please input the address of png.\n";
        cout<<"attention: only png is supported.\n";
        cin>>address;
    }
    name=get_name(address);
    cout<<"Enter the coordinates of the first pixel in the upper left corner of the image:\n";
    cin>>x>>y;
    check_color();
    set_pallet();
    ban_ground();
    two_bit();
    for(int i=1;i<=ans_cnt;i++) cout<<sprite[i];
    for(int i=1;i<=ans_cnt;i++) cout<<"{begin:0,end:10000000},\n";
    return 0;
}

