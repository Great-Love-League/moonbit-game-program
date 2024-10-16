pub trait Print{
	print(Self)->Unit
}

pub trait Strike{
	is_strike(Self,Self)->Bool
}

pub trait Updata_pos{
	updata_pos(Self)->Unit
}

pub trait Get_new_pos{
	get_new_pos(Self)->Unit
}

pub fn show(self:Sprite_parameter)->Unit{
	@wasm4.set_frame_buffer(get_index(self.x,self.y),self.color)
}

pub fn show(self:Frame_effects,x:Int)->Unit{
	{..self.sprite[x],x:self.sprite[x].x+self.x,y:self.sprite[x].y+self.y}.show()
}

pub fn check_in_time(self:Frame_effects,x:Int,time:UInt64)->Bool{
	(self.time_management[x].begin.reinterpret_as_uint64()+self.begin_time<=time)&&(time<=self.time_management[x].end.reinterpret_as_uint64()+self.begin_time)
}

pub fn get_index(x:UInt,y:UInt)->UInt{
	y*160+x
}
pub fn print(sub:Frame_effects)->Unit{
	let len=sub.sprite.length();
	if sub.time_management.length()!=len {}
	let time=@time_cnt.get_time()
	for i=0;i<len;i=i+1{
		if(sub.check_in_time(i,time)){
			sub.show(i)
		}
	}
}