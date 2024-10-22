pub trait Strike{
	is_strike(Self,Self)->Bool
}

pub trait Updata_pos{
	updata_pos(Self)->Unit
}

pub trait Get_new_pos{
	get_new_pos(Self)->Unit
}
pub trait Setmusic{
		setup_tone_params() -> Array[ToneParams]
}

pub fn get_index(x:UInt,y:UInt)->UInt{
	y*160+x
}

//造成伤害#######################################################################################################################################

//造成伤害#######################################################################################################################################

//展示函数#############################################
pub fn show(self:Sprite_parameter)->Unit{
    if 0U<=self.x&&self.x<160&&0U<=self.y&&self.y<160{
	    @wasm4.set_frame_buffer(get_index(self.x,self.y),self.color)
    }
}

pub fn show(self:Frame_effects,x:Int)->Unit{
	{..self.sprite[x],x:self.sprite[x].x+self.x,y:self.sprite[x].y+self.y}.show()
}

pub fn print(self:Frame_effects)->Unit{
	let len=self.sprite.length();
	let time=@time_cnt.get_time()
	for i=0;i<len;i=i+1{
		self.show(i)
	}
}

pub fn print(self:Aircraft)->Unit{
    let len=self.frame.sprite.length();
    self.frame.x=self.pos.x.to_int().reinterpret_as_uint()
    self.frame.y=self.pos.y.to_int().reinterpret_as_uint()
	for i=0;i<len;i=i+1{
		self.frame.show(i)
	}
}

pub fn print(self:Bullet)->Unit{
    let len=self.frame.sprite.length();
    self.frame.x=self.pos.x.to_int().reinterpret_as_uint()
    self.frame.y=self.pos.y.to_int().reinterpret_as_uint()
	for i=0;i<len;i=i+1{
		self.frame.show(i)
	}
}

pub fn print(self:Laser)->Unit{

}

pub fn print(self:Cartridge)->Unit{

}

//展示函数#############################################

//构造函数#############################################
pub fn Location::new(~x:Double=0,~y:Double=0,type_:UInt)->Location{
    {x,y,type_}
}

pub fn Sprite_parameter::new(x:UInt,y:UInt,color:UInt)->Sprite_parameter{
    {x,y,color}
}
pub fn Bullet_exit_point::new(x:Int,y:Int,type_:Int,last_shoot:Int64,shoot_speed:Int64)->Bullet_exit_point{
    {x,y,type_,last_shoot,shoot_speed}
}
//构造函数#############################################

//更新位置#############################################
let eps:Double=0.000000001
pub fn Aircraft::update_pos(self:Aircraft)->Unit{
    let x=self.pos.x
    let y=self.pos.y
    self.pos.x=self.pos.x+self.speed*@math.cos(self.dir/180*@math.pi)
    self.pos.y=self.pos.y+self.speed*@math.sin(self.dir/180*@math.pi)
    if self.type_==3{
        if(self.is_out_partly()){
            self.pos.x=x
            self.pos.y=y
        }
    }
}

pub fn Bullet::update_pos(self:Bullet)->Unit{
    self.pos.x=self.pos.x+self.speed*@math.cos(self.dir/180*@math.pi)
    self.pos.y=self.pos.y+self.speed*@math.sin(self.dir/180*@math.pi)
}
//更新位置#############################################

//检测是否出界#########################################
pub fn Aircraft::is_out_partly(self:Aircraft)->Bool{
    let xl=self.pos.x.to_int()+self.frame.xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+self.frame.ylen.reinterpret_as_int()-1
    let x=self.pos.x
    let y=self.pos.y
    if(x<0||xl>=160||y<0||yl>=low_y) {true}
    else {false}
}

pub fn Aircraft::is_out_all(self:Aircraft)->Bool{
    let xl=self.pos.x.to_int()+self.frame.xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+self.frame.ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    // if(tttt.val){
    //     // @wasm4.text(self.type_.to_string(),0,0)
    //     @wasm4.text(y.to_string(),0,16)
    //     @wasm4.text(xl.to_string(),0,24)
    //     @wasm4.text(yl.to_string(),0,32)
    //     @wasm4.text(x.to_string(),0,40)
    //     tttt.val=false
    // }
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}


pub let tttt:Ref[Bool]=Ref::new(true)
pub fn Bullet::is_out_all(self:Bullet)->Bool{
    let xl=self.pos.x.to_int()+self.frame.xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+self.frame.ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    // if(tttt.val){
    //     @wasm4.text(self.type_.to_string(),0,0)
    //     @wasm4.text(x.to_string(),0,8)
    //     @wasm4.text(y.to_string(),0,16)
    //     @wasm4.text(xl.to_string(),0,24)
    //     @wasm4.text(yl.to_string(),0,32)
    //     tttt.val=false
    // }
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}
//检测是否出界#########################################

//判断死亡########################################################################################

pub fn die(self:Aircraft)->Bool{
    self.hp<0.00000000001
}

//判断死亡########################################################################################

//检测撞击#################################################################################

pub fn crash(self:Bullet,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    for i=self.frame.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=(self.frame.sprite[i].x).reinterpret_as_int()+self.pos.x.to_int()
        ys=(self.frame.sprite[i].y).reinterpret_as_int()+self.pos.y.to_int()
        for j=obj.frame.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=(obj.frame.sprite[j].x).reinterpret_as_int()+obj.pos.x.to_int()
            yo=(obj.frame.sprite[j].y).reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        obj.hp=obj.hp-self.harm
    }
    ans
}

pub fn crash(self:Aircraft,obj:Aircraft)->Bool{
    true
}

//检测撞击#################################################################################


//function of music 
pub fn setup_tone_params() -> Array[ToneParams] {
    let adsr = @wasm4.ADSR::new(attack=0, decay=0,30, release=0);
    let volume = @wasm4.ADSRVolume::new(100,peak=100);

    let channel1 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_4,
        pan = @wasm4.TonePan::Left
    );

    let channel2 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_2,
        pan = @wasm4.TonePan::Right
    );

    let channel3 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_2,
        pan = @wasm4.TonePan::Center
    );

    let tone1 = {
        frequency: (261, 523),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone2 = {
        frequency: (293, 587),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let tone3 = {
        frequency: (329, 659),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let tone4 = {
        frequency: (349, 698),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone5 =  {
        frequency: (392, 784),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let tone6 = {
        frequency: (440, 880),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let tone7 = {
        frequency: (493, 987),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone8 = {
        frequency: (523, 1046),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    return [tone1, tone2, tone3, tone4, tone5, tone6, tone7, tone8];
}

fn play_tone(params: ToneParams) -> Unit {
    @wasm4.tone(params.frequency, params.adsr, params.volume, params.channel);
}
pub fn musicplay() -> Unit {
    let frame_counter :UInt64= @time_cnt.get_time();
		    // 每秒运行60次，假设每个音调播放0.5秒（30帧）
    let tone_duration :Int= 30;
    let index :Int64= ((frame_counter.reinterpret_as_int64() / tone_duration.to_int64()) % 8);
    // 根据frame_counter的值播放不同的音调
    let index=index.to_int();
    play_tone(tones[index])
}
//play_tone的用法如下:
//let toneExample = {
//    frequency: (261, 523),//frequency可以自己定义,其他有需求再定义
//    adsr: adsrSTD,
//    volume: volumeSTD,
//    channel: channelSTD
//};//这里的adsrSTD,volumeSTD,channelSTD是在antity_memory.mbt中定义的标准量
//play_tone(toneExample)