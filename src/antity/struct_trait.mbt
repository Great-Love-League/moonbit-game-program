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
pub fn Aircraft::mutx(self:Aircraft, x:Float)->Unit {self.pos.x = x.to_double();@wasm4.trace("ffffff\{self.pos.x} \{x}")}
pub fn Aircraft::muty(self:Aircraft, y:Float)->Unit {self.pos.y = y.to_double();@wasm4.trace("ffffff\{self.pos.y} \{y}")}

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
    @wasm4.trace("GGGG")
    let x = entity.getx()
    let y = entity.gety()
        let new_x = x + entity.getspeed() * @math.cos(entity.getdir().to_double() * @math.PI / 180.0).to_float()
    let new_y = y + entity.getspeed() * @math.sin(entity.getdir().to_double() * @math.PI / 180.0).to_float()
    @wasm4.trace("\{x} \{y} \{new_x} \{new_y}")
    entity.mutx(new_x)
    entity.muty(new_y)
    
    if (entity.gettype() == 3) {
    let xl=entity.getx().to_double().to_int()+get_fram_entity(entity.gettype()).xlen.reinterpret_as_int()-1
    let yl=entity.gety().to_double().to_int()+get_fram_entity(entity.gettype()).ylen.reinterpret_as_int()-1
    let xx=entity.getx().to_double().to_int()
    let yy=entity.gety().to_double().to_int()
    @wasm4.trace("ddddd \{xx},\{xl},\{yy},\{yl}")
    @wasm4.trace("ddddd \{entity.getx()},\{entity.gety()}")
        if (is_out_partly(entity)) {
            @wasm4.trace("111111111")
            entity.mutx(x)
            entity.muty(y)
        }
    }
    entity
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
    @wasm4.trace("\{(x<160&&xl>=160)} \{(x<0&&xl>=0)} \{(y<low_y&&yl>=low_y)} \{(y<0&&yl>=0)}")
    if((x<160&&xl>=160)||(y<low_y&&yl>=low_y)||(x<0&&xl>=0)||(y<0&&yl>=0)) {true}
    else {false}
}