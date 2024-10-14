pub let frame_cnt:Ref[Int64]=Ref::new(0)

pub fn update_time()->Unit{
	frame_cnt.val=frame_cnt.val+1;
}