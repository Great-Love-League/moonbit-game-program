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

pub fn show(self:Frame_effects,x:Int,y:Int)->Unit{
    let len=self.sprite.length()
    let mut index=0
    let mut posx=x
    let mut posy=y
    for i=0U;i<self.ylen;i=i+1{
        for e=0U;e<self.xlen;e=e+1{
            if((self.back_ground[index]==1||posx>=160||posx<0||posy<0||posy>low_y).not()){
                @wasm4.set_frame_buffer(get_index(posx.reinterpret_as_uint(),posy.reinterpret_as_uint()),self.sprite[index]+1)
            }
            index=index+1
            posx=posx+1
        }
        posx=x
        posy=posy+1
    }
}

pub fn showp(self:Frame_effects_,x:Int,y:Int,t:Int)->Unit{
    let len=self.sprite[t].length()
    let mut index=0
    let mut posx=x
    let mut posy=y
    for i=0U;i<self.ylen;i=i+1{
        for e=0U;e<self.xlen;e=e+1{
            if((self.back_ground[t][index]==1||posx>=160||posx<0||posy<0||posy>low_y).not()){
                @wasm4.set_frame_buffer(get_index(posx.reinterpret_as_uint(),posy.reinterpret_as_uint()),self.sprite[t][index]+1)
            }
            index=index+1
            posx=posx+1
        }
        posx=x
        posy=posy+1
    }
}


pub fn print(self:Aircraft)->Unit{
    self.frame.show(self.pos.x.to_int(),self.pos.y.to_int())
}

pub fn print(self:Bullet)->Unit{
    self.frame.show(self.pos.x.to_int(),self.pos.y.to_int())
}

pub fn print(self:Laser)->Unit{
    // self.frame.show(self.pos.x.to_int(),self.pos.y.to_int())
}

pub fn print(self:Cartridge)->Unit{
    self.frame.show(self.pos.x.to_int(),self.pos.y.to_int())
}

//展示函数#############################################

//构造函数#############################################
pub fn Location::new(~x:Double=0,~y:Double=0,type_:UInt)->Location{
    {x,y,type_}
}

pub fn Bullet_exit_point::new(x:Int,y:Int,type_:Int,last_shoot:Int,shoot_speed:Int,~limit:Int=-1)->Bullet_exit_point{
    {x,y,type_,last_shoot,shoot_speed,limit}
}
//构造函数#############################################

//更新位置#############################################
// let eps:Double=0.000000001
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

pub fn Cartridge::update_pos(self:Cartridge)->Unit{
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
    if(((x<160&&xl>=160)||(y>low_y.to_double()&&yl>=low_y)||(x<0&&xl>=0)||(y<0&&yl>=0))||self.is_out_all()) {true}
    else {false}
}

pub fn Aircraft::is_out_all(self:Aircraft)->Bool{
    let xl=self.pos.x.to_int()+self.frame.xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+self.frame.ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}


pub fn Bullet::is_out_all(self:Bullet)->Bool{
    let xl=self.pos.x.to_int()+self.frame.xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+self.frame.ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}

pub fn Cartridge::is_out_all(self:Cartridge)->Bool{
    let xl=self.pos.x.to_int()+self.frame.xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+self.frame.ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}

pub fn Cartridge::is_out_partly(self:Cartridge)->Bool{
    let xl=self.pos.x.to_int()+self.frame.xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+self.frame.ylen.reinterpret_as_int()-1
    let x=self.pos.x
    let y=self.pos.y
    if(((x<160&&xl>=160)||(y>low_y.to_double()&&yl>=low_y)||(x<0&&xl>=0)||(y<0&&yl>=0))||self.is_out_all()) {true}
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
        xs=i%self.frame.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/self.frame.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=obj.frame.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%obj.frame.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%obj.frame.ylen.reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        obj.hp=obj.hp-self.harm
    }
    return ans;
}

pub fn crash(self:Aircraft,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    for i=self.frame.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%self.frame.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/self.frame.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=obj.frame.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%obj.frame.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%obj.frame.ylen.reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        obj.hp=0
    }
    ans
}

pub fn crash(self:Cartridge,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    for i=self.frame.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%self.frame.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/self.frame.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=obj.frame.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%obj.frame.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%obj.frame.ylen.reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        self.take_effect(obj)
    }
    ans
}

//检测撞击#################################################################################


//弹药箱生效函数######################################################################################

fn take_effect(self:Cartridge,obj:Aircraft)->Unit{
    if(self.type_==8){
        obj.hp=obj.hp+self.effect
    }
    else if(self.type_==7||self.type_==6){
        obj.bullet_exit_point.clear();
        let len=default_bullet(self.type_).length()
        for i=len-1;i>=0;i=i-1{
            obj.bullet_exit_point.push(default_bullet(self.type_)[i])
        }
    }
}

//弹药箱生效函数######################################################################################

pub fn play_sound_effects(effects: Sound_effects) -> Unit {
    //play_tone(tones.effects[1]);
    let mut startcnt=@time_cnt.get_time();
    for effect in effects.effects {
        let tone_for_pub = { tone: effect, startfps: startcnt };
        pubsound_effects.push(tone_for_pub);
        //if(pubsound_effects.length()>0){player_Plane_1_frame.show(50,50)}
        startcnt+=(effect.adsr.release+effect.adsr.attack+effect.adsr.decay+effect.adsr.sustain);
    }
}

pub fn setup_tone_params() -> Array[ToneParams] {
    let adsr = @wasm4.ADSR::new(attack=0, decay=0,10, release=0);
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

    let toneC = {
        frequency: (261, 262),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let toneD = {
        frequency: (293, 294),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let toneE = {
        frequency: (329, 330),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let toneF = {
        frequency: (349, 350),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let toneG =  {
        frequency: (392, 393),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let toneA = {
        frequency: (440,441),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let toneB = {
        frequency: (493, 494),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    return [toneE, toneE, toneF, toneG,
            toneA, toneG, toneF, toneE,
            toneD, toneD, toneE, toneF,
            toneG, toneF, toneE, toneD,
            toneC, toneC, toneD, toneE,
            toneF, toneE, toneD, toneC,
            toneB, toneB, toneC, toneD,
            toneE, toneD, toneC, toneB];
}
pub fn generate_noise() -> Array[ToneParams] {
    let r = @random.new();
    let channel1 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Noise,
        mode = @wasm4.ToneMode::Duty_1_2,
        pan = @wasm4.TonePan::Center
    );
    let adsr = @wasm4.ADSR::new(attack=0, decay=0,50, release=0);
    let noise:Array[ToneParams] = [];
    for i = 0; i < 2; i = i + 1 {
        let random_frequency :UInt= 100; // 随机频率在100到2100之间
        let random_volume =1000; // 随机音量在0.0到1.0之间
        let tone = {
            frequency: (random_frequency, random_frequency + 1),
            adsr: adsr,
            volume: @wasm4.ADSRVolume::new(random_volume.to_uint(), peak=1000),
            channel: channel1
        };
        noise.push(tone);
    }
    return noise;
}

pub fn play_tone(params: ToneParams) -> Unit {
    @wasm4.tone(params.frequency, params.adsr, params.volume, params.channel);
}
pub fn musicplay() -> Unit {
    let frame_counter :UInt= @time_cnt.get_time();
		    // 每秒运行60次，假设每个音调播放0.5秒（30帧）
    let tone_duration :Int= 10;
    let index = ((frame_counter.to_int() / tone_duration) % tones.effects.length());  
    // 根据frame_counter的值播放不同的音调
    play_tone(tones.effects[index])
}
//play_tone的用法如下:
//let toneExample = {
//    frequency: (261, 523),//frequency可以自己定义,其他有需求再定义
//    adsr: adsrSTD,
//    volume: volumeSTD,
//    channel: channelSTD
//};//这里的adsrSTD,volumeSTD,channelSTD是在antity_memory.mbt中定义的标准量
//play_tone(toneExample)
pub fn compare(self:ToneForPub,other:ToneForPub)->Int{
    self.startfps.compare(other.startfps)
}

pub fn op_equal(self: ToneForPub, other: ToneForPub) -> Bool {
    self.startfps == other.startfps
}