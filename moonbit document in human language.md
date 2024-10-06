# moonbit 学习笔录

[参考文献1](https://mooncakes.io/docs/#/moonbitlang/core/)

[MoonBit | MoonBit Docs (moonbitlang.cn)](https://docs.moonbitlang.cn/)



## 内置数据结构

为变量赋值使用 `let` 或者 `let mut`（标示变量可以更改）

hint：在 moonbit 中， ``let`` 关键字用于绑定变量，这意味着这可以在同一个地方将同一个变量名反复绑定

```
fn main {
  let a:Int=1;
  let a:Int=4;
  let a:String="dsd"
}
```

### 布尔类型 bool

MoonBit 内置了布尔类型，它有两个值：``true`` 和 ``false``

注意，不能用 ``0/1`` 代替 ``true`` 和 ``false``

#### bool 操作符

操作方式和 ``C++`` 几乎无区别，只是在取反方面不同

```
let a = true
let b = false
let c = a && b
let d = a || b
let e = not(a)
```

#### bool类型的内置函数

注：大多数内置函数具有两种调用方式

1. Type::funtion()
2. variable.function()

两者的在参数上的区别是，第一种调用方式需要完整的参数列表，第二中方式会默认将 ```variable``` 当作第一个参数

##### Bool::to_int && to_int64 && to_uint && to_uint64

将 Bool 转化为对应数值类型

```
fn main {
  let a: Bool = true
  let b: Bool = false
  let aint_result = a.to_int()
  let bint_result = b.to_int64()
  println("aint_result: \{aint_result}") //1
  println("bint_result: \{bint_result}") //0
}
```

##### Bool::to_string

将 Bool 转化为字符串

```
fn main {
  let a: Bool = true
  let b: Bool = false
  let astring=a.to_string();
  let bstring=b.to_string();
  println("astring: \{astring}") //true
  println("bstring: \{bstring}") //false
}
```

##### Bool::op_compare

在 MoonBit 中，Bool 类型的 op_compare 函数用于比较两个布尔值。op_compare 函数返回一个整数，表示两个布尔值的比较结果。具体来说，op_compare 函数的返回值有以下三种可能：

1. 0：表示两个布尔值相等。
2. 1：表示第一个布尔值为 true，第二个布尔值为 false。
3. -1：表示第一个布尔值为 false，第二个布尔值为 true。

```
fn main {
  let a: Bool = true
  let b: Bool = false

  let compare_result_ab = Bool::op_compare(a, b)
  let compare_result_ba = Bool::op_compare(b, a)
  let compare_result_aa = Bool::op_compare(a, a)
  let compare_result_bb = Bool::op_compare(b, b)

  println("compare_result_ab: \{compare_result_ab}") // 输出: compare_result_ab: 1
  println("compare_result_ba: \{compare_result_ba}") // 输出: compare_result_ba: -1
  println("compare_result_aa: \{compare_result_aa}") // 输出: compare_result_aa: 0
  println("compare_result_bb: \{compare_result_bb}") // 输出: compare_result_bb: 0
}
```
##### Bool::to_json

在 MoonBit 中，Bool 类型的 to_json 函数用于将布尔值转换为 JSON 格式的字符串。JSON 是一种轻量级的数据交换格式，广泛用于前后端数据传输和存储。Bool 类型的 to_json 函数将布尔值转换为 JSON 格式的字符串，true 转换为 "true"，false 转换为 "false"。

注：```json``` 有啥用我目前不知QWQ

```
fn main {
  let a: Bool = true
  let b: Bool = false

  let json_a = Bool::to_json(a)
  let json_b = Bool::to_json(b)

  println("json_a: \{json_a}") // 输出: json_a: "true"
  println("json_b: \{json_b}") // 输出: json_b: "false"
}

```

### 数字

moonbit 支持的整形和浮点类型


|类型	|描述	|例子|
| ---- | ---- | ---- |
|```Int```|	32 位有符号整数	|42|
|```Int64```|	64 位有符号整数|	1000L|
|```UInt```|	32 位无符号整数	|14U|
|```UInt64```|	64 位无符号整数	|14UL|
|```Double```|	64 位浮点数，由 IEEE754 定义	|3.14|
|```Float```|	32 位单精度浮点数	|(3.14 : Float)|
|```BigInt```|	表示任意大的整数	|10000000000000000000000N|

注：在某些数字后面会有后缀，这将帮助编译器推断变量类型

#### 整形的操作

##### 操作符

1. 数值运算 ```+-*/```
2. 位运算 ```& | ^```
3. 位移   ```<< >>```

注意：不同类型的整形是不可以相互运算的，但是可以通过其内在函数 ```to_....``` 转化后运算

##### 内置函数（Int为例）

1. Int::land && Int::lor && Int::lxor
   分别代表 ```& | ^```
   
2. Int::upto
	```fn upto(start: Int, end: Int) -> Iter[Int]```
	
	Int::upto 函数是 MoonBit 中用于生成一个范围内的整数序列的内置函数。
	
	```
	fn main {
	  let c=Int::upto(1,5)
	  println(c.count())//[1, 2, 3, 4]
	}
	```
	
	


3. Int::shl && Int::shl
   左移右移
   
4. Int::clz && Int::ctz
   ```fn clz(value: Int) -> Int```

   在 MoonBit 中，Int::clz 函数用于计算一个整数的二进制表示中前导零（leading zeros）的数量。前导零是指从最高位开始，连续的 0 的个数。clz 是 "count leading zeros" 的缩写。

   ```
    fn main {
    let value: Int = 0b00001000  // 二进制表示为 8
    let leading_zeros = Int::clz(value)
    println("leading_zeros: \{leading_zeros}") // 输出:leading_zeros:28
    }
   ```
   
   注意负数的补码！！！
   
   ```
   fn main {
     let value: Int = -0b00001000  // 二进制表示为 8
     let leading_zeros = Int::clz(value)
     println("leading_zeros: \{leading_zeros}") // 输出:leading_zeros:0
   }
   ```

  在 MoonBit 中，Int::ctz 函数用于计算一个整数的二进制表示中尾随零（trailing zeros）的数量。尾随零是指从最低位开始，连续的 0 的个数。ctz 是 "count trailing zeros" 的缩写。

5. Int::compare
    在 MoonBit 中，Int::compare 函数用于比较两个整数。compare 函数返回一个整数，表示两个整数的比较结果。具体来说，compare 函数的返回值有以下三种可能：
    1.0：表示两个整数相等。
    
    2. 1：表示第一个整数大于第二个整数。
    3. -1：表示第一个整数小于第二个整数。
    
6. Int::abs
    绝对值
    
7. Int::is_non_pos && Int::is_pos && Int::is_neg && Int::is_non_neg
    判断数字是否为非正数，正数，负数，非负数
    
8. Int:to_....
    类型转换函数，和bool的相似
    
9. op系函数  Int::op_....
    op系列函数是运算符的另外一种写法，和直接使用运算符基本无区别，但是在某些情况下只可以使用操作符函数
    | op_name | op |
    |---|---|
    |Int::op_equal(self : Int, other : Int) -> Bool |==|
    |Int::op_shr(other : Int) -> Int | >>|
    |Int::op_shl(other : Int) -> Int | <<|
    |Int::op_sub(other : Int) -> Int | -|
    |Int::op_mod(self : Int, other : Int) -> Int| % |
    |Int::op_neg(self : Int) -> Int | 取负号 |
    |Int::op_add(self : Int, other : Int) -> Int | + |

10. Int::default()

    这个函数没有参数，不可以用点法调用，只可以用Int直接调用，返回值是0

    ```
    println(Int::default()) //0
    ```
    
11. Int::reinterpret_as_uint && Int::reinterpret_as_float

     ```Int::reinterpret_as_uint(self : Int) -> UInt```

     当值是非负时，将有符号int重新解释为Uint。当该值为正数时，值是一样的。当该值为负数时，它会变成一个较大的数字，例如 $-1$ 会变成 $2^{32}-1$

     ```Int::reinterpret_as_float(self : Int) -> float``` 目前不请楚QWQ

12. Int::until

     ```      Int::until(self : Int, end : Int, ~step : Int = .., ~inclusive : Bool = ..) -> Iter[Int]```

     不清楚QWQ，用不到的样子

13. fn Int::land && Int::lnot

     ```Int::land(self : Int, other : Int) -> Int```

     land 即 logic and 也就是 bitwise and，就是 $\&$

     ```Int::lnot(self : Int) -> Int```

     同理，lnot意味着 bitwise not，按位取反，和C++中的 ``~`` 一样

注：Int64，UInt，UInt64 和此上基本相同

##### BigInt

BigInt 按下不表，用不到

#### 浮点数

使用 $Double$ 为例

##### 自带函数

1. Double::convert_uint && Double::convert_uint64

   ```Double::convert_uint(val : UInt) -> Double```

   ```Double::convert_uint(val : UInt64) -> Double```

   将 UInt 和 UInt64 转变为 Double

2. op系列

   | op_name                                                 | operation |
   | ------------------------------------------------------- | --------- |
   | Double::op_neg(self : Double) -> Double                 | 取负号    |
   | Double::op_equal(self : Double, other : Double) -> Bool | ==        |
   | Double::op_add(self : Double, other : Double) -> Double | +         |
   | Double::op_sub(self : Double, other : Double) -> Double | -         |
   | Double::op_div(self : Double, other : Double) -> Double | /         |
   | Double::op_mul(self : Double, other : Double) -> Double | $*$       |
   | Double::op_neq(self : Double, other : Double) -> Bool   | !=        |

3. Double::until

   ```Double::until(self : Double, end : Double, ~step : Double = .., ~inclusive : Bool = ..) -> Iter[Double]```

   返回一个迭代器，第一个数字为 $self $，最后一个数字小于 $end $，步长为 $step$

   但是将 $inclusive$ 设置为 $true$ 那么最后一个数字小于等于 $end$

   Creates an iterator that iterates over a range of Double with default step 1.0 . To grow the range downward, set the step parameter to a negative value.

   start - The starting value of the range (inclusive).

   end - The ending value of the range (exclusive by default).

   step - The step size of the range (default 1.0).

   inclusive - Whether the ending value is inclusive (default false).

   Returns an iterator that iterates over the range of Double from start to end - 1.

4. Double::upto

   ```Double::upto(self : Double, end : Double, ~inclusive : Bool = ..) -> Iter[Double]```

   和上面那个没啥区别

5. Mathematics and logic

   Double::sqrt

   Double::sqrt(self : Double) -> Double

   Double::compare

   Double::compare(self : Double, other : Double) -> Int

6. to族

   | to_name                                  |
   | ---------------------------------------- |
   | Double::to_int(self : Double) -> Int     |
   | Double::to_json(self : Double) -> Json   |
   | Double::to_float(self : Double) -> float |

7. Double::default

   ```Double::default() -> Double```

   同 $Int$ 一样，无法被点调用，只可以用 $typename::method$ 的方式使用，返回一个 $0$

8. Double::reinterpret

   ```fn Double::reinterpret_as_u64(self : Double) -> UInt64```

   ```fn Double::reinterpret_as_i64(self : Double) -> Int64```

   用不到，不知道

### 字符串 String

#### 字符串的基本使用

字符串`String`内部保存了 UTF-16 编码单元序列。可以使用双引号来表示一个字符串，或者通过`#|`来书写多行字符串。

```
fn main {
	let a="moonbit"
	println(a)
	println(a[0])
	println(a[1])
	let b =
  	#| Hello
  	#| MoonBit
  	#|
  	println(b)
}
```

注：直接输出字符，会加上一个单引号

在双引号包围的字符串之间支持使用`\`表示特殊字符转义：

| 转义序列             | 解释                         |
| -------------------- | ---------------------------- |
| `\n`,`\r`,`\t`,`\b`  | 换行、回车、水平制表符、退格 |
| `\\`                 | 反斜杠                       |
| `\x41`               | 16 进制转义序列              |
| `\o102`              | 8 进制转义序列               |
| `\u5154`,`\u{1F600}` | Unicode 字符转义序列         |

注意：在使用 ``\b`` 时有个问题

```
println("a\b") \\out: 
println("a\bcc")
```



MoonBit 支持字符串插值，它可以把字符串中内插的变量替换为变量具体的值。 这个特性能够简化动态拼接字符串的过程。

用于字符串内插的变量必须支持 `to_string` 方法。

```
fn main {
  let x = 42
  println("The answer is \{x}")
}
```

#### 自带函数

1. String::length

   `String::length(self : String) -> Int` 

   返回此字符串的长度

2. String::pad_end

   ```String::pad_end(self : String, total_width : Int, padding_char : Char) -> String```

   将字符串补充为指定长度，如果 ```self.length()<total_width``` 那么新的字符串长度将为 ```total_width``` 并且末尾填充相应数量的 `padding_char` ，否则屁事没有QWQ

3. String::rev

   `String::rev(self : String) -> String`

   反转字符串

4. String::rev_iter

   ```String::rev_iter(self : String) -> Iter[Char]```

   返回一个从尾指向头的迭代器

   ```
   fn main {
     let c=1234
     let x = "\{c}abcdefg\n"
     println(x.rev_iter())
   }
   // ['\n', 'g', 'f', 'e', 'd', 'c', 'b', 'a', '4', '3', '2', '1']
   ```

5. String::is_blank

   `String::is_blank(self : String) -> Bool`

   判断字符串是否为空白串，空返回 `ture` 否则返回 `false`

   空白串指的是只有换行符，空格之类的东西，而没有可见字符

   ```
   fn main {
     let c="1234"
     let x = "        \n  \r     \t      "
     let y = ""
     let z = "\b"
     println(c.is_blank())
     println(x.is_blank())
     println(y.is_blank())
     println(z.is_blank())
   }
   //false
   //true
   //true
   //false
   ```

   注：`\b` 有点问题，因为其$ascii~code$是 `\x8`

   [std::isblank - cppreference.com](https://en.cppreference.com/w/cpp/string/byte/isblank)

6. String::is_empty

   `String::is_empty(self : String) -> Bool`

   检查字符串是否为空

7. String::to_array

   `String::to_array(self : String) -> Array[Char]`

   字面意思QWQ

8. String::to_lower

   `String::to_lower(self : String) -> String`

   将此字符串转换为小写。

9. String::to_upper

   `String::to_upper(self : String) -> String`

   将此字符串转换为大写。

10. String::index_of

   `String::index_of(self : String, str : String, ~from : Int = ..) -> Int`

   类似于C++中的 `string::find` ，返回第一个子串对应的索引（理解为下标），如果没有，就返回 `-1`

   `from` ：从第几位开始找，默认为开头。即查找范围为 $[from,end]$

11. String::last_index_of

    `String::index_of(self : String, str : String, ~from : Int = ..) -> Int`

    和上面那个差不多，只是直接找最后一个

    `from` ：从第几位开始向前找，默认为结尾。即查找范围为 $[Begin,from)$

12. String::trim

    ` String::trim(self : String, trim_set : String) -> String`

    在 `self` 中的前导和后缀中删除 `trim_set` 中所包含的字符

    `String::trim_space(self : String) -> String`

    删除 `self` 前导和后缀中所有的 `isblank` 字符（就是空白字符，不包括 `\b`）

    `String::trim_start(self : String, trim_set : String) -> String`

    在 `self` 中的前导中删除 `trim_set` 中所包含的字符

    ` String::trim_end(self : String, trim_set : String) -> String`

    在 `self` 中的后缀中删除 `trim_set` 中所包含的字符

    ~~`String::trim_right(self : String, trim_set : String) -> String`~~ 被 `trim_end` 取代

    ~~`String::trim_left(self : String, trim_set : String) -> String`~~ 被 `trim_start` 取代

13. String::compare

    `String::compare(self : String, other : String) -> Int` 

    首先比较长度，长的那个比较大，然后按照字典序比较两个字符串

    | a.compare(b) | return result |
    | ------------ | ------------- |
    | a>b          | 1             |
    | a=b          | 0             |
    | a<b          | -1            |

14. String::repeat

    `String::repeat(self : String, n : Int) -> String`

    将 `self` 重复 `n` 次

15. String::ends_with && String::starts_with

    `String::ends_with(self : String, str : String) -> Bool`

    判断 `self` 结尾是否为 `str`

    `String::starts_with(self : String, str : String) -> Bool`

    判断 `self` 开头是否为 `str`

16. String::default()

    `String::default()`

    返回一个空的字符串

17. String::replace && String::replace

    `String::replace_all(self : String, ~old : String, ~new : String) -> String`

    将此字符串中的所有旧字符串替换为新字符串。

    `String::replace(self : String, ~old : String, ~new : String) -> String`

    将此字符串中的第一个旧字符串替换为新字符串。

18. String::split

    `fn String::split(self : String, seperator : String) -> Iter[String]`

    使用指定的分隔符将输入`String`拆分为`String`的迭代器。

    ``self``:要分割的输入字符串。

    ``separator``:用作分隔符的字符串。

    函数返回的迭代器包含每个分隔符之间的字串，在字符串开始和结束时，被认为是有一个分隔符。

    当 `separator` 是 `“”` 时，每个字符都会被分割开来放进迭代器

    ```
    fn main {
      let c="wo nuibi ds wo fw ds wo chao nb ds wo chao fw"
      println(c.split("ds"))
      println(c.split(""))
    }
    //["wo nuibi ", " wo fw ", " wo chao nb ", " wo chao fw"]
    // ["w", "o", " ", "n", "u", "i", "b", "i", " ", "d", "s", " ", "w", "o", " ", "f", "w", " ", "d", "s", " ", "w", "o", " ", "c", "h", "a", "o", " ", "n", "b", " ", "d", "s", " ", "w", "o", " ", "c", "h", "a", "o", " ", "f", "w"]
    ```

19. String::contains_char && contains

    `String::contains_char(self : String, c : Char) -> Bool`

    检查此字符串是否包含某个字符

    `String::contains(self : String, str : String) -> Bool`

    检查此字符串是否包含某个子串

20. String::substring

    `String::substring(self : String, ~start : Int = .., ~end : Int = ..) -> String`

    给出一个 `[start,end)` 的子串，这个函数越界会报错

21. String::to_..

    | to_typename                                        |                                |
    | -------------------------------------------------- | ------------------------------ |
    | `String::to_bytes(self : String) -> Bytes`         | 将此字符串转换为 `UTF-16 code` |
    | `String::to_js_string(self : String) -> Js_string` | 不知道 js_string 拿来干啥      |
    | `String::to_json(self : String) -> Json`           | 将字符转化为 `Json`            |
    | `String::to_string(self : String) -> String`       | 不理解要这个有啥用QWQ          |

22. String::make

    `String::make(length : Int, value : Char) -> String`

    构造一个长度为 `length` 的字符串，每个字符都为为 `value`

23. String::escape

    `String::escape(self : String) -> String`

    返回字符串的有效MoonBit字符串文字表示形式，添加引号和转义特殊字符。

    大白话：在字符串的两边加上引号，然后所有的 `\t \n \b \\` 之类的直接输出，不发生转义（eg. `\n` 不会输出换行，而是输出 `“\n”`）

    ```
    fn main {
      let c="dsdsdsd\{323}da\tsd\nas"
      // println(c.split("ds"))
      println(c.escape())
    }
    // "dsdsdsd323da\tsd\nas"
    ```

24. String::op_..

    | op_type                                                   | operation |
    | --------------------------------------------------------- | --------- |
    | `String::op_equal(self : String, other : String) -> Bool` | ==        |
    | `String::op_add(self : String, other : String) -> String` | +         |
    | `String::op_get(self : String, idx : Int) -> Char`        | []        |

    注：`String::get(self : String, idx : Int) -> Char` 和直接用 `[]` 一样，为了兼容，保留了这个

25. 目前没搞懂的

    |                                                              |
    | ------------------------------------------------------------ |
    | `String::iter2(self : String) -> Iter2[Int, Char]`           |
    | `String::iter(self : String) -> Iter[Char]`                  |
    | `String::fold[A](self : String, ~init : A, f : (A, Char) -> A) -> A` |
    | `String::rev_fold[A](self : String, ~init : A, f : (A, Char) -> A) -> A` |

### 字符 Char

char的东西少呀，比较轻松

#### 自带函数

1. to_..

   | to_type                                  |               |
   | ---------------------------------------- | ------------- |
   | `Char::to_string(self : Char) -> String` |               |
   | `Char::to_json(self : Char) -> Json`     |               |
   | `Char::to_int(self : Char) -> Int`       | 转化为ASCII码 |

2. Char::op_equal

   `Char::op_equal(self : Char, other : Char) ->Bool`

   以ASCII码来比较大小

3. Char::compare

   `Char::compare(self : Char, other : Char) -> Int`

   以ASCII码来比较大小

   | Result | Return value |
   | ------ | ------------ |
   | <      | -1           |
   | =      | 0            |
   | >      | 1            |

4. Char::default()

   `Char::default() -> Char`

   返回一个字符 `NUL`

5. Char::from_int

   `Char::from_int(val : Int)->Char`

   返回一个 ASCII 码为 `val` 的字符

6. 发现char还有两个接口方法被实现

   | `impl Hash for Char with hash(self : Char) -> Int`           |
   | ------------------------------------------------------------ |
   | `impl Hash for Char with hash_combine(self : Char, hasher : Hasher) -> Unit` |

   不知道干啥

### 字节（序列）Byte(Bytes)

感觉用不着，暂时放下。其实 `Byte` 和 `Bytes` 的关系和 `Char` 与 `String` 的关系差不多

### 元组 Tuple

我翻文档发现这个元组最高只支持16个元素，可以去试一下把元组搞爆

#### 元组介绍

元组是一个有限值的**有序**集合，使用圆括号 `()` 构造，其中的元素由逗号 `,` 分隔。元素的顺序很重要，例如 `(1, true)` 和 `(true, 1)` 是不同的类型。以下是一个例子：

```
fn pack(a: Bool, b: Int, c: String, d: Double) -> (Bool, Int, String, Double) {
    (a, b, c, d)
}
fn main {
    let quad = pack(false, 100, "text", 3.14)
    let (bool_val, int_val, str, float_val) = quad
    println("\{bool_val} \{int_val} \{str} \{float_val}")
}
//false 100 text 3.14
```

元组的访问方式有两种

1. 模式匹配

   即通过给元组中每个变量一个名字来访问他，这个名字相当于引用

2. 索引

   和下标没区别，只不过是用点号标识

   ```
   fn main {
     ttry((1,2))
   }
   
   fn ttry(t:(Int,Int))->Unit{
     let (x1,y1)=t
     println(x1)//模式匹配
     println(t.0)//索引
   }
   ```

   发现一个问题，这样的元组是不可以更改的，还在寻找更改的方法

#### 内在函数

1. Tuple::op_equal

   元组自动重载了 `==`

2. Tuple::to_string

   元组支持直接输出，以及 `“\{}”` 输出

### 数组 array

数组一共有三种类型

1. Array 相当于 C++中的vector
2. FixedArray 相当于C++中的数组 性能较Array优秀
3. Arrayview

#### 数组 Array

数组是支持随机访问的值的集合，并且可以在大小上增长。

##### 内在函数

###### 基本操作类

1. Array::push[T]

   `Array::push[T](self : Array[T], value : T) -> Unit`

   将一个元素添加到数组的末尾。

   `Array::push_iter[T](self : Array[T], iter : Iter[T]) -> Unit`

   将迭代器中的所有元素添加到数组的末尾。该函数遍历所提供的迭代器中的每个元素，并使用push方法将它们添加到数组中。

2. Array::pop[T]

   `Array::pop[T](self : Array[T]) -> T?`

   从数组中移除最后一个元素并返回该元素，如果为空则返回None。

   这个 `pop` 很安全呀

3. Array::new[T]

   `Array::new[T](~capacity : Int = ..) -> Array[T]`

   Creates a new array.

4. Array::resize[T]

   `Array::resize[T](self : Array[T], new_len : Int, f : T) -> Unit`

   使用默认值将数组大小调整为新长度，保留原有元素，在末尾加上默认值

5. Array::clear[T]

   `Array::clear[T](self : Array[T]) -> Unit`

   清除数组，移除所有值。

   此方法对阵列的分配容量没有影响，只是将长度设置为0。

6. Array::length[T]

   `Array::length[T](self : Array[T]) -> Int`

   返回数组中元素的个数。

7. Array::dedup

   `Array::dedup[T : Eq](self : Array[T]) -> Unit`

   去重函数，和C++中的 `unique` 是一个东西，但是没有返回值

   其中泛型 `T` 必须实现了接口 `Eq` ，就是要重载运算符 `==`

   **目前这个函数有bug，等待修正**

8. Array::rev_inplace[T]

   `Array::rev_inplace[T](self : Array[T]) -> Unit`

   翻转整个数组

9. Array::rev[T]

   ` Array::rev[T](self : Array[T]) -> Array[T]`

   反转数组中元素的顺序并返回一个新数组。对原数组没有改变

10. Array::is_sorted[T]

    `Array::is_sorted[T : Compare + Eq](self : Array[T]) -> Bool`

    测试数组是否已排序。

    默认为升序，降序要自己改

    ```
    fn main {
      let arr = [1, 2, 3, 4, 5, 6]
      let c=arr.rev()
      println(c.is_sorted()) //false
      println(arr.is_sorted()) //true
    }
    ```

    

11. Array::sort[T : Compare + Eq]

    `Array::sort[T : Compare + Eq](self : Array[T]) -> Unit`

    快排，修改是 `in place`

    `Array::sort_by[T](self : Array[T], cmp : (T, T) -> Int) -> Unit`

    通过某个比较规则排序

    ` Array::sort_by_key[T, K : Compare + Eq](self : Array[T], map : (T) -> K) -> Unit`

    排序的依据变为了 `map(T)->K`

    此排序不稳定，相同的元素的顺序可能会被交换

12. Array::mapi[T, U]

    `Array::mapi[T, U](self : Array[T], f : (Int, T) -> U) -> Array[U]`

    将数组中的每一个元素通过 `f` 提供的映射关系进行转化，得到一个新的数组，新数组的元素种类可以不同

    `f` 中，第一个参数为下标，第二个为对应的元素

    ```
    fn main {
      let a:Array[Int]=[0,0,0,0,0,0]
      println(a)
      let a=a.mapi(fn(x,y){x+y});
      println(a)
    }
    //[0, 0, 0, 0, 0, 0]
    //[0, 1, 2, 3, 4, 5]
    ```

13. Array::map[T, U]

    `Array::map[T, U](self : Array[T], f : (T) -> U) -> Array[U]`

    和上一个一样，只是 `f` 少一个参数

14. Array::mapi_inplace[T]

    `Array::mapi_inplace[T](self : Array[T], f : (Int, T) -> T) -> Unit`

    和 `mapi` 一样，只不过是 `in_place` 修改

15. Array::insert[T]

    `Array::insert[T](self : Array[T], index : Int, value : T) -> Unit`

    插入元素，在给定的索引处插入元素

    ```
    fn main {
      let a:Array[Int]=[0,0,0,0,0,0]
      println(a)
      a.insert(1,2)
      println(a)
    }
    //[0, 0, 0, 0, 0, 0]
    //[0, 2, 0, 0, 0, 0, 0]
    ```

16. Array::remove[T]

    `Array::remove[T](self : Array[T], index : Int) -> T`

    删除下表对应的元素，并且返回他。

    注意：有返回值！

    ```
    fn main {
      let a:Array[Int]=[1,2,3,4,5,6,7]
      println(a)
      a.remove(0) |> ignore
      println(a)
    }
    //[1, 2, 3, 4, 5, 6, 7]
    //[2, 3, 4, 5, 6, 7]
    ```

17. Array::drain[T]

    `Array::drain[T](self : Array[T], begin : Int, end : Int)->Array[T]`

    删除 `self` 中 `[begin,end)` 的元素，并且返回他

    ```
    let v = [3, 4, 5]
    let vv = v.drain(1, 2) // vv = [4], v = [3, 5]
    ```

    

18. Array::binary_search[T]

    `Array::binary_search[T : Compare + Eq](self : Array[T], value : T) -> Result[Int, Int]`

    建议了解错误类型后来看

    在此升序数组中查找 `value` 并返回其索引

    | Result             | Return value                                            |
    | ------------------ | ------------------------------------------------------- |
    | 找到一个符合要求   | 返回OK变量，包含其索引                                  |
    | 找到多个个符合要求 | 返回OK变量，包含最左边那个的索引                        |
    | 没有找到符合要求的 | 返回Err变量，其中包含可以插入元素以保持排序顺序的索引。 |

    ```
    fn main {
      let v = [1,3, 4, 5]
      let result = v.binary_search(2)
      println(result) // Err(1)
      let result = v.binary_search(1)
      println(result) // Ok(0)
      let result = v.binary_search(3)
      println(result) // Ok(1)
    }
    ```

    **务必保持元素成升序排列**

19. Array::search[T : Eq]

    `Array::search[T : Eq](self : Array[T], value : T) -> Int?`

    结果和 `Array::binary_search[T]` 一样，但是不用保证升序

20. Array::swap[T]

    `Array::swap[T](self : Array[T], i : Int, j : Int) -> Unit`

    交换数组中的两个元素。

21. Array::filter[T]

    `Array::filter[T](self : Array[T], f : (T) -> Bool) -> Array[T]`

    根据 `f` 中提供的方法，对 `self` 实现过滤

    ```
    fn main {
      let arr = [1, 2, 3, 4, 5, 6]
      let b=arr.filter(fn (x) { x % 2 == 0 })  
      println(b)// [2, 4, 6]
    }
    ```

    这个不会改变 `self` 本身

22. Array::extract_if[T]

    `Array::extract_if[T](self : Array[T], f : (T) -> Bool) -> Array[T]`

    此函数功能与上一个一样，但是有点不同

    这个函数将从原始数组中删除元素并返回一个新数组。

    ```
    let v = [3, 4, 5]
    let vv = v.extract_if(fn(x) { x > 3 }) // vv = [4, 5], v = [3]
    ```

    

23. Array::to_string[T]

    `Array::to_string[T : Show](self : Array[T]) -> String`

    字面意思

24. Array::to_json[T]

    `Array::to_json[X : ToJson](self : Array[X]) -> Json`

25. Array::from_iter[T]

    `Array::from_iter[T](iter : Iter[T]) -> Array[T]`

    从一个迭代器构造数组

26. Array::make[T]

    `Array::make[T](len : Int, elem : T) -> Array[T]`

    用指定的长度[len]和元素[elem]创建一个新的数组。

    `Array::makei[T](length : Int, value : (Int) -> T) -> Array[T]`

    初始化一个长度为 `length` 的数组，其的值由 `value` 函数决定

27. Array::split_at[T]

    `Array::split_at[T](self : Array[T], index : Int) -> (Array[T], Array[T])`

    将数组分为两个，第一个包含 `[0,index-1]` 第二个包含 `[index,self.length()]`

28. Array::is_empty[T]

    `Array::is_empty[T](self : Array[T]) -> Bool`

    字面意思

29. Array::repeat[T]

    `Array::repeat[T](self : Array[T], times : Int) -> Array[T]`

    字面意思

30. Array::ends_with[T : Eq] && Array::starts_with[T : Eq]

    `Array::ends_with[T : Eq](self : Array[T], suffix : Array[T]) -> Bool`

    检查数组是否以给定后缀结尾。

    `Array::starts_with[T : Eq](self : Array[T], prefix : Array[T]) -> Bool`

    检查数组是否以给定的前缀开始。

31. Array::retain[T]

    `Array::retain[T](self : Array[T], f : (T) -> Bool) -> Unit`

    仅保留 `f` 指定的元素。

    ```
    fn main {
      let v = [3, 4, 5]
      v.retain(fn(x) { x > 3 })
      println(v) // [4, 5]
    }
    ```

32. Array::append[T]

    `Array::append[T](self : Array[T], other : Array[T]) -> Unit` 

    就是 `op_add[T]`

###### 操作符重载

| Op_name                                                      | Operation |
| ------------------------------------------------------------ | --------- |
| `Array::op_as_view[T](self : Array[T], ~start : Int, ~end? : Int) -> ArrayView[T]` | [:]       |
| `Array::op_add[T](self : Array[T], other : Array[T]) -> Array[T]` | +         |
| `Array::op_set[T](self : Array[T], index : Int, value : T) -> Unit` | []        |
| `Array::op_equal[T : Eq](self : Array[T], other : Array[T]) -> Bool` | ==        |

注意：`op_set` 有一个更安全的使用方式

`Array::get[T](self : Array[T], index : Int) -> T?`

从数组中检索指定索引处的元素，如果索引越界则为None

###### 莫名奇妙类

1. Array::reserve_capacity[T]

   `Array::reserve_capacity[T](self : Array[T], capacity : Int) -> Unit`

   保留容量以确保它至少可以容纳capacity参数指定的元素数量。

   没啥用，array的capacity似乎会自己增加

2. Array::fold_left

   `Array::fold_left[T, U](self : Array[T], f : (U, T) -> U, ~init : U) -> U`

   Fold out values from an array according to certain rules.

   @alert deprecated "Use fold instead."

3.  Array::each[T]

   ` Array::each[T](self : Array[T], f : (T) -> Unit) -> Unit`

   遍历数组中的所有元素，可以在 `f` 函数中进行一些处理，但是传入的参数是拷贝的，不是引用，感觉没啥用，不如循环
   
4. Array::eachi[T]

   `Array::eachi[T](self : Array[T], f : (Int, T) -> Unit) -> Unit`

   和上一个一样，只是 `f` 传入参数多了一个 `index`

5. Array::rev_eachi[T]

   `Array::rev_eachi[T](self : Array[T], f : (Int, T) -> Unit) -> Unit`

   和上面那个一样，只是顺序反了

6. Array::binary_search_by[T]

   `Array::binary_search_by[T](self : Array[T], cmp : (T) -> Int) -> Result[Int, Int]`

   没啥用

7. Array::chunks[T]

   `Array::chunks[T](self : Array[T], size : Int) -> Array[Array[T]]`

   将数组的元素分组为大小相同的块。

   最后不够分的元素会被放进最后一个块

   ```
   let v = [1, 2, 3, 4, 5, 6, 7, 8]
   let chunks = v.chunks(3) // chunks = [[1, 2, 3], [4, 5, 6], [7, 8]]
   ```

8. Array::split[T]

   `Array::split[T](self : Array[T], pred : (T) -> Bool) -> Array[Array[T]]`

   基于 `pred` 将数组拆成块

   ```
   fn main {
     let v = [1, 0, 2, 0, 3, 0, 4]
     let chunks = v.split(fn(x) { x == 0 })
     println(chunks)
   }
   ```

9. Array::flatten[T]

   `Array::flatten[T](self : Array[Array[T]]) -> Array[T]`

   理解为上两个函数的逆操作

   ```
   fn main {
     let arr = [1, 2, 3, 4, 5, 6]
     let b=arr.chunks(3)
     println(b)//[[1, 2, 3], [4, 5, 6]]
     let c=b.flatten()
     println(c)//[1, 2, 3, 4, 5, 6]
   }
   ```

   

10. Array::shrink_to_fit[T]

    `Array::shrink_to_fit[T](self : Array[T]) -> Unit`

    Shrinks the capacity of the array as much as possible.

11. Array::strip_prefix[T : Eq]

    `Array::strip_prefix[T : Eq](self : Array[T], prefix : Array[T]) -> Array[T]?`

    从数组中剥离前缀。如果数组以前缀开头，则返回前缀后面的数组，否则返回`None`。

12. Array::join[T]

    `Array::join[T : Show](self : Array[T], sep : String) -> String`

    使用指定的分隔符将数组的元素连接为单个字符串。

    ```
    fn main {
      let v = [4,3,3,4,4,5]
      println(v.join("OK")) // [4, 5]
    }//4OK3OK3OK4OK4OK5
    ```

#### FixedArray

大体和 `array` 相同，但是其会固定你的数组长度，性能较 `array` 优秀,具体有以下一些区别

1. FixedArray::from_array[T]

   `FixedArray::from_array[T](array : Array[T]) -> FixedArray[T]`

#### ArrayView

这是 `Array` 的一个切片，他对于 `Array` 来说是引用，修改 `ArrayView` 会影响 `Array`

```
fn main {
  let v = [4,3,3,4,4,5]
  println(v)//[4, 3, 3, 4, 4, 5]
  let b=v[0:1]
  b[0]=1;
  println(v)//[1, 3, 3, 4, 4, 5]
  println(b)//[1]
}
```

##### 自带函数

这个的自带函数就少很多，这里简单列举，用法与功能和 `array` 的同名函数一样

1. `ArrayView::length[T](self : ArrayView[T]) -> Int`
2. `ArrayView::iter[A](self : ArrayView[A]) -> Iter[A]`
3. `ArrayView::swap[T](self : ArrayView[T], i : Int, j : Int) -> Unit`
4. `ArrayView::to_string[X : Show](self : ArrayView[X]) -> String`
5. `ArrayView::rev_inplace[T](self : ArrayView[T]) -> Unit`
6. ` ArrayView::each[T](self : ArrayView[T], f:(Int)->Unit)->Unit`

### Map

1. `Map::is_empty[K, V](self : Map[K, V]) -> Bool`

   检查哈希映射是否为空。

2. 重载

   | Op_name                                                      | Operation |
   | ------------------------------------------------------------ | --------- |
   | `Map::op_equal[K : Eq, V : Eq](self : Map[K, V], that : Map[K, V]) -> Bool` | ==        |
   | `Map::op_set[K : Hash + Eq, V](self : Map[K, V], key : K, value : V) -> Unit` | Map[K]=V  |
   | `Map::op_get[K : Hash + Eq, V](self : Map[K, V], key : K) -> V?` | Map[K]    |

3. `Map::iter[K, V](self : Map[K, V]) -> Iter[(K, V)]`

   返回哈希映射的迭代器，按插入顺序提供元素。

   `Map::values[K, V](self : Map[K, V]) -> Iter[V]`

   `Map::iter2[K, V](self : Map[K, V]) -> Iter2[K, V]`

4. `Map::each[K, V](self : Map[K, V], f : (K, V) -> Unit) -> Unit`

   按插入顺序遍历映射的所有键值对。可以在 `f` 中对其进行一些处理，但是这个参数是拷贝的

   `Map::eachi[K, V](self : Map[K, V], f : (Int, K, V) -> Unit) -> Unit`

   多提供了一个参数

5. `Map::to_array[K, V](self : Map[K, V]) -> Array[(K, V)]`

   将哈希映射转换为数组。

   `Map::to_json[K : Show, V : ToJson](self : Map[K, V]) -> Json`

   将哈希映射转换为Json。

   `Map::to_string[K : Show, V : Show](self : Map[K, V]) -> String`

6. `Map::size[K, V](self : Map[K, V]) -> Int`

   获取映射中键值对的数量。

7. ` Map::get_or_default[K : Hash + Eq, V](self : Map[K, V], key : K, default : V) -> V`

   获取与键关联的值，如果键不存在则返回提供的默认值。

   `Map::get[K : Hash + Eq, V](self : Map[K, V], key : K) -> V?`

   获取与键相关联的值，不存在返回 None

8. `Map::remove[K : Hash + Eq, V](self : Map[K, V], key : K) -> Unit`

   从哈希映射中删除键值对。

9. `Map::capacity[K, V](self : Map[K, V]) -> Int`

   得到`Map`的容量。

10. `Map::of[K : Hash + Eq, V](arr : FixedArray[(K, V)]) -> Map[K, V]`

    从 `FixedArray` 转化为 `Map`

    `Map::from_iter[K : Hash + Eq, V](iter : Iter[(K, V)]) -> Map[K, V]`

    从` iter `转化为 `Map`

    `Map::from_array[K : Hash + Eq, V](arr : Array[(K, V)]) -> Map[K, V]`

    从 `Array` 转化为 `Map`

11. `Map::contains[K : Hash + Eq, V](self : Map[K, V], key : K) -> Bool`

    检查哈希映射是否包含键。

12. `Map::clear[K, V](self : Map[K, V]) -> Unit`

    清除映射，移除所有键值对。保留已分配的空间。

### 迭代器 Iter

相当于指针（简单理解），在函数间传参时建议使用

## 数据类型

### [结构体 struct](https://docs.moonbitlang.cn/#数据类型)

在 MoonBit 中，结构与元组类似，但它们的字段由字段名索引。 结构体可以使用结构体字面量构造，结构体字面量由一组带有标签的值组成，并用花括号括起来。 如果结构体字面量的字段完全匹配类型定义，则其类型可以被自动推断。 使用点语法 `s.f` 可以访问结构体字段。 如果一个字段使用关键字 `mut` 标记为可变，那么可以给它赋予新的值。

```
struct User {
  id: Int
  name: String
  mut email: String
}

fn main {
  let u = { id: 0, name: "John Doe", email: "john@doe.com" }
  u.email = "john@doe.name"
  println(u.id)
  println(u.name)
  println(u.email)
}

```

#### 创建结构体的简写形式

如果已经有和结构体的字段同名的变量，并且想使用这些变量作为结构体同名字段的值， 那么创建结构体时，可以只写字段名，不需要把同一个名字重复两次。例如：

```
fn main {
  let name = "john"
  let email = "john@doe.com"
  let u = { id: 0, name, email } // 等价于 { id: 0, name: name, email: email }
}
```

#### [更新结构体的语法](https://docs.moonbitlang.cn/#更新结构体的语法)

如果想要基于现有的结构体来创建新的结构体，只需修改现有结构体的一部分字段，其他字段的值保持不变， 可以使用结构体更新语法：

```
struct User {
  id: Int
  name: String
  email: String
} derive(Show)

fn main {
  let user = { id: 0, name: "John Doe", email: "john@doe.com" }
  let updated_user = { ..user, email: "john@doe.name" }
  println(user)          // 输出: { id: 0, name: "John Doe", email: "john@doe.com" }
  println(updated_user)  // 输出: { id: 0, name: "John Doe", email: "john@doe.name" }
}
```

### 枚举

看文档

### 新类型

建议不要用，因为他不会继承原有类型的函数，感觉有点麻烦

## 函数

### init

init 函数用于初始化，在程序最开始时使用

可以存在多个 init 函数

并且执行顺序不同

### main

main函数是主函数，和c++中的类似

没有参数列表以及返回值

main 函数只可以有一个

### Top-Level function && local function

#### Top-Level function 

有一个很形象的比喻叫一等公民，特点如下：

1. 必须有返回值
2. 必须有名称
3. 可以函数递归调用
4. 不支持函数重载
5. 函数名那一行必须顶格

#### local function 

特点：

1. 在函数内被定义的函数（没错，可以嵌套函数，无限套娃）

   ```
   fn add(a: Int, b: Int) -> Int {
   	let c:Int=a
   	fn add(a:Int,b:Int)->Unit{
   	fn (x:Int)->Unit{
   		ignore(println(a+b))
   	}(a)
   }
   ```

2. 两种定义方式
   1. 显示定义，显示调用
   就是在定义的时候加上函数名称，这种函数可以在定义后被作用域的其他地方调用。

   同时，这个函数名和参数表可以和这个非同级函数完全相同，但是这样做了过后会导致其他函数的作用域被覆盖

   例如：你在上面第8行调用 ```add``` 只会调用local function的 ```add``` 而非顶级函数的 ```add```

   2.  匿名定义，立即调用
   ```
    fn add(a:Int,b:Int)->Unit{
      fn (x:Int)->Unit{
        println(x);
      }(a);
      fn (x:Int)->Unit{
        println(x+x)
      }(b)//就是这个括号
    }
   ```

    这样定义函数没有名字，在定义后加上输入的参数列表直接调用，作用域仅限于定义完后的那个括号。

    这也意味着，匿名函数无法被这样连续调用
    ```
    fn add(a:Int,b:Int)->Unit{
      fn (x:Int)->Unit{
        println(x+x)
      }(b)(a)(a)//就是这个括号
    }
    ```
    3. 匿名定义，将函数和变量绑定
    说白了就是函数名约等于变量名，但是有区别
    ```
    fn get_mutiply(a:Int,b:Int)->Int{
    let c=fn (a:Int,b:Int)->Int{
        fn add(a,b){
            a+b
        }
        add(a,b)*a*b*a*b
    }
    c(a,b)
    }
    ```

    其中第一行不可写为 ```let c:Int=fn (a:Int,b:Int)->Int{``` 
    具体原因我也不知，实践发现会编译错误

    调用方式和一般函数相同，作用域为变量的作用域

    有一种特殊的调用方式，适用于在分支结构时统一输入参数
    ```
    let a=false;let c=false;let b=true;
    let rrr:Int=4;
    fn nothing(a:Int)->Unit{}
    let f = fn(x) {println(x+1); x + 1 }
    let g = fn(x) {println(x+2); x + 2 }
    let h = fn(x) {println(x+3); x + 3 }
    let i = fn(x) {println(x+4); x + 4 }
    (if c{
        f
    }
    else if  b{
        nothing(g(22))//写成 notthing(g) 会出错
        g
        //看这里！！！
    }
    else if c{
        h
    }
    else {
        i
    })(rrr)
    ```
    这个参数只会个这个孤零零的变量，不会给其他的变量
   
    **注意：** 整个分支结构都要被括号包起来

3. 支持递归（匿名函数不支持）
4. 不支持重载
5. 只可以在作用域内被调用
6. 不用指明参数变量类型和返回值类型，会自动匹配

### 参数列表的用法

在 $moonbit$ 中，参数列表的用法和C++类似，但有些区别

就比如一般的参数是不可以有默认值的！！！！（目前发现这个）

也有着一下几种牛马存在

#### Labelled arguments

1. 声明方式
   ```
    fn labelled(~arg1 : Int, ~arg2 : Int) -> Int {
    arg1 + arg2
    }
   ```
    就是在名字前加一个 ~ 
2. 传入参数
   ```
    fn labelled(~arg1 : Int, ~arg2 : Int) -> Int {
    arg1 + arg2
    }
    fn init {
    let arg1 = 1
    println(labelled(arg2=2, ~arg1)) // 3
    }
   ```

    这个参数传入也比较抽象，他是可以不按照顺序传入，但是必须要加上这个参数在定义时的变量名，而且每一个参数必须要有对应的值。

    这个传入顺序和他的处理顺序可能不同，处理顺序一定是按照函数定义时的参数列表的顺序来的

#### Optional arguments

这个说白了就是在 Labelled arguments 的基础上，让其有了一个默认值。如果传入参数时没有传入这个参数，那么其就会使用默认值。

默认值特点：

1. 值的内容可以是常量，也可以是变量计算得来
    ```
    let arg3:Int=33
    fn labelled(arg4 : Int,~arg1 : Int, ~arg2 : Int=arg1+arg3+arg4) -> Int {
        arg1 + arg2
    }
   ```
2. 默认值会在每次调用时重新计算

#### 在提供可选参数时让编译器自动插入 ``Some``



## 泛型

您可以在顶层的函数和数据结构定义中使用泛型。类型参数可以由方括号引入。其实很像 `C++` 中的 `template<typename T>`

在使用泛型的过程中，可以通过一些方法为泛型指定接口（看了接口再看这里，不然蒙蔽）

```
trait add{
  op_add(Self,Self)->Self
  op_mul(Self,Self)->Self
}

fn comput[T](a:T,b:T)->T{
  a*b
}
```

这样会报错，因为没有为泛型 $T$ 提供相乘的方法

现在有两个解决办法

1. 为泛型默认方法

   ```
   trait add{
     op_add(Self,Self)->Self
     op_mul(Self,Self)->Self
   }
   
   fn comput[T:add](a:T,b:T)->T{
     a*b
   }
   ```

   对与同一个泛型，可以使其使用多个接口，使用 `+` 连接

   ```
   trait add{
     op_add(Self,Self)->Self
     op_mul(Self,Self)->Self
   }
   
   trait apd{
     op_sub(Self,Self)->Self
   }
   
   fn comput[T:add+apd](a:T,b:T)->T{
     a-b+a*b
   }
   ```

   

2. 在使用时，指定接口

   ```
   trait add{
     op_add(Self,Self)->Self
     op_mul(Self,Self)->Self
   }
   
   fn comput[T](a:T,b:T)->T{
     add:op_add(a,b)
   }
   ```

   注意，如果接口重载了运算符，只可以写成运算符的函数形式

## [控制结构](https://docs.moonbitlang.cn/#控制结构)

这个文档上比较拟人，看文档吧

## 访问控制

见文档，和 C++ 中的类相似

## [方法系统](https://docs.moonbitlang.cn/#方法系统)

见文档

