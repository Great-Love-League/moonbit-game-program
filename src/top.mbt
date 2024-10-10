pub fn start() -> Unit {

}

pub fn update() -> Unit {
  @wasm4.set_draw_colors(4,index=1)
  @wasm4.set_draw_colors(3,index=2)
  //相当于有两个序列，第一个是调色板，也就是颜色储存的地方，就是这里的第一个参数
  //第二个是使用的颜色序列，也是只有四个空位，每一种画图函数会调用这四个空位中的颜色来作画，index的值就是这四个位置的下标
}