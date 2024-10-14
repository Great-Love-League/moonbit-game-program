pub struct Location{
  x:Double
  y:Double
  newx:Double
  newy:Double
  type_:UInt
//用于记录实体的位置
}

struct Sprite_parameter{
	x:UInt
	y:UInt
	//相对于基准像素的偏移量
	color:UInt
}

// pub struct Frame{
// 	x:Int
// 	y:Int
// 	//代表左上角的基准像素
// 	sprite:Array[Sprite_parameter]
// 	//这个代表一帧！！
// }

pub struct Frame_time_config{
	begin:Int64
	end:Int64
}

pub struct Frame_effects{
	begin_time:UInt64
	end_time:UInt64
	//开始和结束的帧，闭区间
	x:Int
	y:Int
	sprite:Array[Sprite_parameter]
	time_management:Array[Frame_time_config]
	//time_management与sprite的长度一致，time_management用于控制sprite的每一帧显示时间
}


pub struct Sound_effects{
	//具体实现待研究QWQ
}

pub struct Effects{
	frame:Frame_effects
	sound:Frame_effects
}

struct Bullet{
	type_:UInt
	harm:UInt
	pos:Location
	dir:UInt
	speed:Double
	frame:Frame_effects
}

struct Aircraft{
  type_:UInt
  pos:Location
  speed:UInt
  dir:UInt
  weapon:UInt
	frame:Frame_effects
  hp:Int
}

struct Cartridge{
  type_:UInt
  pos:Location
  speed:UInt
  dir:UInt
	frame:Frame_effects
}