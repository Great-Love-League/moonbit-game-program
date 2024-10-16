let frame_cnt:Ref[UInt64]=Ref::new(0)

pub fn update_time()->Unit{
	frame_cnt.val=frame_cnt.val+1;
}

pub fn get_time()->UInt64{
	frame_cnt.val
}