# moonbit 学习笔录

## 内置数据结构

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



