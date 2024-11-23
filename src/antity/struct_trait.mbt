pub let scores:Ref[Int]=Ref::new(0);

pub fn get_index(x:UInt,y:UInt)->UInt{
	y*160+x
}

//造成伤害#######################################################################################################################################

//造成伤害#######################################################################################################################################

//展示函数#############################################

pub fn show(self:Frame_effects,x:Int,y:Int)->Unit{
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
    get_fram_entity(self.type_).show(self.pos.x.to_int(),self.pos.y.to_int())
}

pub fn print(self:Bullet)->Unit{
    get_fram_entity(self.type_).show(self.pos.x.to_int(),self.pos.y.to_int())
}

pub fn print(self:Cartridge)->Unit{
    get_fram_entity(self.type_).show(self.pos.x.to_int(),self.pos.y.to_int())
}

//展示函数#############################################

//构造函数#############################################
pub fn Location::new(x~:Double=0,y~:Double=0,type_:UInt)->Location{
    {x,y,type_}
}

pub fn Bullet_exit_point::new(x:Int,y:Int,type_:Int,last_shoot:Int,shoot_speed:Int,limit~:Int=-1)->Bullet_exit_point{
    {x,y,type_,last_shoot,shoot_speed,limit}
}
//构造函数#############################################

//判断死亡########################################################################################

pub fn die(self:Aircraft)->Bool{
    self.hp<0.0000001
}

//判断死亡########################################################################################

//检测撞击#################################################################################

pub fn get_ratio_en()->Double{
    return (1.0+scores.val.to_double()*0.0008)
}

pub fn get_ratio_my()->Double{
    return (1.0+scores.val.to_double()*0.0004)
}

pub fn crash(self:Bullet,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    let selff=get_fram_entity(self.type_)
    let objj=get_fram_entity(obj.type_)
    for i=selff.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%selff.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/selff.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=objj.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%objj.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%objj.ylen.reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        if(self.type_==1||self.type_==11){
            obj.hp=obj.hp-self.harm*get_ratio_en();
        }
        else if(self.type_==2||self.type_==9){obj.hp=obj.hp-self.harm*get_ratio_my()}
    }
    ans
}

pub fn crash(self:Aircraft,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    let selff=get_fram_entity(self.type_)
    let objj=get_fram_entity(obj.type_)
    for i=selff.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%selff.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/selff.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=objj.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%objj.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%objj.ylen.reinterpret_as_int()+obj.pos.y.to_int()
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
    let selff=get_fram_entity(self.type_)
    let objj=get_fram_entity(obj.type_)
    for i=selff.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%selff.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/selff.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=objj.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%objj.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%objj.ylen.reinterpret_as_int()+obj.pos.y.to_int()
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


pub(open) trait Get_infor{
    getx(Self)->Float
    gety(Self)->Float
    getdir(Self)->Float
    getspeed(Self)->Float
    gettype(Self)->Int
}

pub(open) trait Mut_infor{
    mutx(Self,Float)->Unit
    muty(Self,Float)->Unit
}

pub(open) trait Check_out{
    is_out_partly(Self)->Bool
    is_out_all(Self)->Bool
}

pub fn Aircraft::getx(self:Aircraft)->Float{self.pos.x.to_float()}
pub fn Aircraft::gety(self:Aircraft)->Float{self.pos.y.to_float()}
pub fn Aircraft::getdir(self:Aircraft)->Float{self.dir.to_float()}
pub fn Aircraft::getspeed(self:Aircraft)->Float{self.speed.to_float()}
pub fn Aircraft::gettype(self:Aircraft)->Int{self.type_}
pub fn Aircraft::mutx(self:Aircraft, x:Float)->Unit {self.pos.x = x.to_double()}
pub fn Aircraft::muty(self:Aircraft, y:Float)->Unit {self.pos.y = y.to_double()}

pub fn Bullet::getx(self:Bullet)->Float{self.pos.x.to_float()}
pub fn Bullet::gety(self:Bullet)->Float{self.pos.y.to_float()}
pub fn Bullet::getdir(self:Bullet)->Float{self.dir.to_float()}
pub fn Bullet::getspeed(self:Bullet)->Float{self.speed.to_float()}
pub fn Bullet::gettype(self:Bullet)->Int{self.type_}
pub fn Bullet::mutx(self:Bullet, x:Float)->Unit {self.pos.x = x.to_double()}
pub fn Bullet::muty(self:Bullet, y:Float)->Unit {self.pos.y = y.to_double()}

pub fn Cartridge::getx(self:Cartridge)->Float{self.pos.x.to_float()}
pub fn Cartridge::gety(self:Cartridge)->Float{self.pos.y.to_float()}
pub fn Cartridge::getdir(self:Cartridge)->Float{self.dir.to_float()}
pub fn Cartridge::getspeed(self:Cartridge)->Float{self.speed.to_float()}
pub fn Cartridge::gettype(self:Cartridge)->Int{self.type_}
pub fn Cartridge::mutx(self:Cartridge, x:Float)->Unit {self.pos.x = x.to_double()}
pub fn Cartridge::muty(self:Cartridge, y:Float)->Unit {self.pos.y = y.to_double()}

pub fn update_pos[T:Get_infor+Mut_infor](entity:T)->T{
    let x = entity.getx()
    let y = entity.gety()
    let new_x = x + entity.getspeed() * @math.cos(entity.getdir().to_double() * @math.PI / 180.0).to_float()
    let new_y = y + entity.getspeed() * @math.sin(entity.getdir().to_double() * @math.PI / 180.0).to_float()
    entity.mutx(new_x)
    entity.muty(new_y)
    
    if (entity.gettype() == 3) {
        if (is_out_partly(entity)) {
            entity.mutx(x)
            entity.muty(y)
        }
    }
    entity
//function of music 
pub fn play_tone(params: ToneParams) -> Unit {
    @wasm4.tone(params.frequency, params.adsr, params.volume, params.channel);
}
pub fn musicplay() -> Unit {
    let frame_counter :UInt= @time_cnt.get_time();
            // 每秒运行60次，假设每个音调播放0.5秒（30帧）
    let tone_duration :Int= 10;
    let index = ((frame_counter.reinterpret_as_int() / tone_duration) % tones.effects.length());  
    // 根据frame_counter的值播放不同的音调
    play_tone(tones.effects[index])
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

pub fn is_out_all[T:Get_infor](entity:T)->Bool{
    let xl=entity.getx().to_double().to_int()+get_fram_entity(entity.gettype()).xlen.reinterpret_as_int()-1
    let yl=entity.gety().to_double().to_int()+get_fram_entity(entity.gettype()).ylen.reinterpret_as_int()-1
    let x=entity.getx().to_double().to_int()
    let y=entity.gety().to_double().to_int()
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}

pub fn is_out_partly[T:Get_infor](entity:T)->Bool{
    let xl=entity.getx().to_double().to_int()+get_fram_entity(entity.gettype()).xlen.reinterpret_as_int()-1
    let yl=entity.gety().to_double().to_int()+get_fram_entity(entity.gettype()).ylen.reinterpret_as_int()-1
    let x=entity.getx().to_double().to_int()
    let y=entity.gety().to_double().to_int()
    if((x<160&&xl>=160)||(y<low_y&&yl>=low_y)||(x<0&&xl>=0)||(y<0&&yl>=0)) {true}
    else {false}
}