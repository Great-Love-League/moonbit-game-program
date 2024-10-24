pub fn start() -> Unit {
	@wasm4.set_palette(1,@wasm4.rgb(1377129))
	@wasm4.set_palette(3,@wasm4.rgb(5224703))
	@wasm4.set_palette(4,@wasm4.rgb(11221214))
	@wasm4.set_palette(2,@wasm4.rgb(16754473))
	//初始化调色板，之后调色板禁止更改！！
}

pub fn update() -> Unit {
	// @time_cnt.update_time();
	// @antity.player_Plane_1_frame.print()
	// @interface.interface()
	let a:@bitset.Bitset=@bitset.Bitset::new(2,"1110000110");
	println(a[0])
}
