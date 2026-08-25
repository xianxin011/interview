# JavaScript 核心基础知识点（必掌握）

## 一、JavaScript 核心基础知识点

### 1.1 数据类型（原始类型 + 引用类型）

JS 数据类型分为原始值类型和引用数据类型，是前端开发的基石。

- **原始类型（7 种）**：`Undefined`、`Null`、`Boolean`、`Number`、`String`、`Symbol`、`BigInt`（ES11 新增）  
- **引用类型**：`Object`（包含 `Array`、`Function`、`Date`、`RegExp` 等）

**核心区别**：

- 原始类型存栈内存，值不可变；引用类型存堆内存，栈中存储堆地址
- 原始类型赋值是值拷贝，引用类型赋值是地址拷贝
- 原始类型比较是值比较，引用类型比较是地址比较

**代码示例**：

```javascript
// 原始类型：值拷贝，互不影响
let a = 10;
let b = a;
b = 20;
console.log(a); // 10

// 引用类型：地址拷贝，修改会相互影响
let obj1 = { name: "掘金" };
let obj2 = obj1;
obj2.name = "前端开发";
console.log(obj1.name); // 前端开发

// 精准类型判断
Object.prototype.toString.call(null); // [object Null]
Object.prototype.toString.call([]); // [object Array]
```

**为什么要加 BigInt？**

Number 局限：只能精确表示 ±2⁵³−1 范围内的整数（约 9e15）。精度丢失问题：

```javascript
9007199254740992 === 9007199254740993; // true（错误）

// 1. 字面量（加 n）
const a = 123n;
const b = -456n;

// 2. 构造函数
const c = BigInt(789);
const d = BigInt("9007199254740992");

// 3. 类型判断
typeof a; // "bigint"

// 与 Number 不兼容：不支持小数、Math 方法、JSON.stringify
123n + 123; // TypeError（不能混合运算）
123n === 123; // false
```

BigInt 解决：支持任意精度整数，适合金融、区块链、大 ID、密码学。

---

### 1.2 变量声明：var / let / const

前端最基础的声明规则，也是面试必考、开发必用知识点。

| 特性    | var  | let     | const   |
| ----- | ---- | ------- | ------- |
| 变量提升  | ✅ 存在 | ❌ 暂时性死区 | ❌ 暂时性死区 |
| 块级作用域 | ❌ 无  | ✅ 有     | ✅ 有     |
| 重复声明  | ✅ 允许 | ❌ 不允许   | ❌ 不允许   |
| 重新赋值  | ✅ 允许 | ✅ 允许    | ❌ 不允许   |

**代码示例**：

```javascript
// var：变量提升 + 全局污染
console.log(num); // undefined
if (true) var num = 10;
console.log(num); // 10

// let：块级作用域隔离
let age = 20;
if (true) {
  let age = 30;
}
console.log(age); // 20

// const：必须初始化，引用类型可改属性
const PI = 3.14;
const user = { name: "张三" };
user.name = "李四"; // 合法
```

---

### 1.3 类型转换（显式 + 隐式）

JS 是弱类型语言，类型转换是开发高频操作。

- **显式转换**：`Number()`、`String()`、`Boolean()`、`parseInt()`
- **隐式转换**：`+`、`-`、`==`、`if` 判断等自动触发

**代码示例**：

```javascript
// 显式转换
Number("123"); // 123
String(true); // "true"
Boolean(0); // false

// 隐式转换
1 + "2"; // "12"（数字转字符串）
"12" - 0; // 12（字符串转数字）
if (1) {} // 1转true
```

---

### 1.4 运算符核心（== / === / 短路运算 / 空值合并）

```javascript
// ==：隐式转换后比较；===：严格比较（类型+值）
0 == ""; // true
0 === ""; // false

// 短路运算：&&（一假则假）、||（一真则真）
const name = null || "默认名称";
const age = 18 && "成年";

// 空值合并??：仅null/undefined时取默认值（开发推荐）
const obj = { age: 0 };
obj.age ?? 18; // 0
obj.height ?? 180; // 180
```

---

### 1.5 函数核心（普通函数 / 箭头函数 / this）

**箭头函数 vs 普通函数**：

- 箭头函数没有 `this`，继承父级作用域的 `this`
- 没有 `arguments`、不能用作构造函数、没有原型
- 简写语法，适合回调函数

**代码示例**：

```javascript
// 普通函数：this指向调用者
function fn() { console.log(this); }
fn(); // window/global

// 箭头函数：this继承外层
const obj = {
  fn: () => console.log(this)
};
obj.fn(); // window
```

---

### 1.6 数组高频方法（开发必备）

```javascript
const arr = [1,2,3];
// 遍历：forEach、map、filter、find、some、every
arr.map(item => item * 2); // [2,4,6]
arr.filter(item => item > 1); // [2,3]

// 增删改查：push/pop/unshift/shift/splice
arr.push(4); // [1,2,3,4]
arr.splice(1,1); // 删除索引1的元素 → [1,3,4]

// 高阶：reduce（求和、去重、扁平化）
arr.reduce((sum, cur) => sum + cur, 0); // 8
```

---

### 1.7 闭包（核心概念）

**定义**：函数嵌套函数，内部函数访问外部函数变量，形成闭包。  
**作用**：私有化变量、延长变量生命周期、实现柯里化  
**风险**：滥用会导致内存泄漏  

**代码示例**：

```javascript
function outer() {
  let num = 10;
  return function inner() {
    console.log(num); // 访问外部变量 → 闭包
  };
}
const fn = outer();
fn(); // 10
```

---

### 1.8 原型与原型链

JS 继承的核心机制，面试必考。

- 所有对象都有 `__proto__`，指向构造函数的 `prototype`
- 原型链：对象查找属性/方法的路径，终点是 `null`

**代码示例**：

```javascript
function Person(name) {
  this.name = name;
}
// 原型方法
Person.prototype.sayHi = function() {
  console.log(this.name);
};
const p = new Person("张三");
p.sayHi(); // 张三

// 原型链关系
p.__proto__ === Person.prototype;
Person.prototype.__proto__ === Object.prototype;
Object.prototype.__proto__ === null;
```

---

### 1.9 异步编程（回调 / Promise / async-await）

JS 是单线程语言，异步解决阻塞问题。

```javascript
// Promise 基础
const p = new Promise((resolve, reject) => {
  setTimeout(() => resolve("成功"), 1000);
});
p.then(res => console.log(res));

// async-await（语法糖，开发首选）
async function getData() {
  const res = await p;
  console.log(res);
}
getData();
```

---

### 1.10 事件循环（宏任务 / 微任务）

JS 执行机制，大厂面试必考题：

- 执行栈 → 微任务队列 → 宏任务队列
- **微任务**：`Promise.then/catch/finally`、`MutationObserver`
- **宏任务**：`setTimeout`、`setInterval`、AJAX、DOM 事件

**代码示例**：

```javascript
console.log(1);
setTimeout(() => console.log(2), 0); // 宏任务
Promise.resolve().then(() => console.log(3)); // 微任务
console.log(4);
// 执行顺序：1 → 4 → 3 → 2
```

---

## 二、JavaScript 开发高频踩坑汇总（99% 开发者都遇到过）

### 2.1 隐式类型转换踩坑（== 滥用）

**错误场景**：`==` 自动隐式转换，导致逻辑错误  

```javascript
console.log(0 == ''); // true
console.log('' == false); // true
```

**原因**：`==` 会先转换类型再比较  
**解决方案**：开发永远优先用 `===`，仅判断 `null/undefined` 用 `==`

```javascript
let a;
if (a == null) { // 等价于 a === null || a === undefined
  console.log("变量为空");
}
```

---

### 2.2 forEach 中使用 await 失效

**错误场景**：`forEach` 不支持异步，无法按顺序执行  

```javascript
const arr = [1,2,3];
arr.forEach(async item => {
  await new Promise(r => setTimeout(r,1000));
  console.log(item); // 1秒后同时输出1、2、3
});
```

**解决方案**：用 `for...of` / 普通 `for` 循环

```javascript
(async () => {
  for(let item of arr) {
    await new Promise(r => setTimeout(r,1000));
    console.log(item); // 每隔1秒输出
  }
})();
```

---

### 2.3 引用类型浅拷贝导致数据篡改

**错误场景**：对象/数组直接赋值，修改新变量污染原数据  

```javascript
let obj1 = { name: "张三" };
let obj2 = obj1;
obj2.name = "李四";
console.log(obj1.name); // 李四
```

**解决方案**：浅拷贝 `...`/`Object.assign`，深拷贝 `JSON.parse`/手写深拷贝

```javascript
// 浅拷贝
let obj2 = {...obj1};
// 深拷贝（无函数/undefined时）
let deepObj = JSON.parse(JSON.stringify(obj1));
```

---

### 2.4 this 指向丢失

**错误场景**：定时器/回调函数中 `this` 指向改变  

```javascript
const obj = {
  name: "张三",
  sayName() {
    setTimeout(function() {
      console.log(this.name); // undefined
    }, 100);
  }
};
```

**解决方案**：箭头函数 / 存 `this` / `bind`

```javascript
// 箭头函数
setTimeout(() => console.log(this.name), 100);
```

---

### 2.5 数组空位导致方法异常

**错误场景**：数组空位（empty）被 `forEach/map` 跳过  

```javascript
const arr = [1,,3];
arr.forEach(item => console.log(item)); // 只输出1、3
```

**解决方案**：初始化数组时避免空位，用 `fill` 填充

```javascript
const arr = [1, undefined, 3];
```

---

### 2.6 闭包导致内存泄漏

**错误场景**：闭包变量长期占用内存不释放  

```javascript
function leak() {
  let bigData = new Array(1000000).fill("数据");
  return () => bigData;
}
const fn = leak(); // bigData永远不被回收
```

**解决方案**：使用完手动置空

```javascript
fn = null; // 释放内存
```

---

### 2.7 异步同步混淆执行顺序错误

**错误场景**：直接获取异步函数返回值  

```javascript
function getData() {
  setTimeout(() => return "数据", 1000);
}
const res = getData();
console.log(res); // undefined
```

**解决方案**：用 `Promise/async-await` 接收

---

### 2.8 函数默认参数踩坑

**错误场景**：默认参数仅在 `undefined` 时生效  

```javascript
function fn(a = 10) { console.log(a); }
fn(null); // null
fn(undefined); // 10
```

---

## 三、大厂高频 JavaScript 面试题（附答案 + 解析）

### 3.1 数据类型相关（必考）

**题目 1：JS 有哪些数据类型？Symbol 和 BigInt 的特点？**

**答案**：  
JS 共 **8 种原始类型** + **引用类型（Object）**，其中：

- **7 种原始类型**：`Undefined`、`Null`、`Boolean`、`Number`、`String`、`Symbol`（ES2015）、`BigInt`（ES2020）
- **1 种引用类型**：`Object`（包含 `Array`、`Function`、`Date`、`RegExp` 等子类型）

**Symbol 特点**：

- 独一无二，不可重复：`Symbol('a') !== Symbol('a')`
- 可作为对象属性名，避免属性冲突
- 不能参与隐式类型转换，Symbol 转字符串需手动调用 `toString()`

**BigInt 特点**：

- 解决 Number 精度丢失问题（Number 仅能精确表示 ±2^53-1 范围内整数）
- 定义方式：`123n` / `BigInt('456')`
- 不可与 Number 混合运算，`1n + 2` 会抛错

---

**题目 2：typeof 和 instanceof 的区别？手写 instanceof 原理**

**答案**：

| 对比项 | typeof                             | instanceof                                  |
| --- | ---------------------------------- | ------------------------------------------- |
| 作用  | 判断原始类型（除 null）和引用类型                | 判断引用类型的继承关系                                 |
| 返回值 | 字符串（如 `'number'`、`'object'`）       | 布尔值（`true/false`）                           |
| 特殊点 | `typeof null === 'object'`（历史 bug） | 无法判断原始类型（如 `1 instanceof Number === false`） |

**手写 instanceof 原理**：

```javascript
/**
 * 手写instanceof
 * @param {*} left 待检测对象 
 * @param {*} right 构造函数 
 * @returns {boolean}
 */
function myInstanceof(left, right) {
  // 原始类型直接返回false
  if (typeof left !== 'object' || left === null) return false;
  // 获取右构造函数的原型对象
  let prototype = right.prototype;
  // 获取左对象的隐式原型
  left = left.__proto__;
  // 遍历原型链
  while (true) {
    // 原型链终点为null
    if (left === null) return false;
    // 原型匹配
    if (left === prototype) return true;
    // 向上遍历原型链
    left = left.__proto__;
  }
}

// 测试
console.log(myInstanceof([], Array)); // true
console.log(myInstanceof({}, Object)); // true
console.log(myInstanceof(123, Number)); // false
```

---

### 3.2 变量声明（var/let/const）

**题目**：var、let、const 的区别？暂时性死区是什么？

**答案**：核心差异体现在变量提升、块级作用域、重复声明、重新赋值四个维度：

- `var`：存在变量提升，无块级作用域，可重复声明，可重新赋值
- `let`：无变量提升（存在暂时性死区），有块级作用域，不可重复声明，可重新赋值
- `const`：无变量提升，有块级作用域，不可重复声明，不可重新赋值（引用类型属性可改）

**暂时性死区（TDZ）**：在代码块内，使用 `let/const` 声明变量前，变量处于“不可访问”状态，称为暂时性死区。

```javascript
console.log(a); // 报错：Cannot access 'a' before initialization
let a = 10;
```

---

### 3.3 作用域与作用域链

**题目 1：JS 的作用域有哪些？作用域链的作用？**

**答案**：  
JS 采用**词法作用域（静态作用域）**，作用域分为 3 类：

- **全局作用域**：代码最外层，全局可访问
- **函数作用域**：函数内部定义，仅函数内可访问
- **块级作用域**：`{}` 包裹（`let/const` 生效），如 `if/for/switch`

**作用域链**：当访问变量时，会从当前作用域向上查找，直到全局作用域，这条查找链条就是作用域链。作用域链决定了变量的访问权限和优先级。

---

**题目 2：手写实现块级作用域（用 var 模拟 let）**

**答案**：利用**立即执行函数（IIFE）**的函数作用域模拟块级作用域：

```javascript
// 原代码
for (let i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 100);
} // 输出 0 1 2

// 用var模拟
for (var i = 0; i < 3; i++) {
  (function(j) {
    setTimeout(() => console.log(j), 100);
  })(i);
} // 输出 0 1 2
```

---

### 3.4 闭包（核心难点）

**题目 1：什么是闭包？闭包的应用场景？优缺点？**

**答案**：  
**闭包定义**：内部函数访问外部函数的变量/参数，且内部函数被外部引用，形成闭包。

**应用场景**：

- 私有化变量：隐藏内部属性，仅暴露接口（如 JS 模块、单例模式）
- 防抖/节流：缓存定时器标识
- 柯里化函数：参数复用、延迟执行
- 模块模式：实现单例、封装私有属性

**优缺点**：

- **优点**：私有化变量、延长变量生命周期、实现函数柯里化
- **缺点**：闭包会占用内存，若未及时释放易导致内存泄漏（大量闭包 + 大对象）

---

**题目 2：手写闭包实现私有属性**

```javascript
/**
 * 闭包实现私有属性
 */
function Person(name) {
  // 私有属性
  let _age = 0;
  // 公有方法（闭包访问私有属性）
  this.getName = function() {
    return name;
  };
  this.getAge = function() {
    return _age;
  };
  this.setAge = function(val) {
    if (val >= 0) _age = val;
  };
}

// 测试
const p = new Person('张三');
console.log(p.getName()); // 张三
console.log(p.getAge()); // 0
p.setAge(20);
console.log(p.getAge()); // 20
console.log(p._age); // undefined（私有属性无法直接访问）
```

---

**题目 3：闭包导致的内存泄漏如何解决？**

**答案**：

- **及时解除引用**：闭包函数不再使用时，将其赋值为 `null`，释放对内部变量的引用
- **避免滥用闭包**：减少闭包嵌套层级，避免缓存大对象
- **使用弱引用**：ES6 的 `WeakMap`/`WeakSet` 存储闭包数据，垃圾回收时自动释放（无引用限制）

---

### 3.5 原型基础

**题目 1：原型、原型对象、构造函数的关系？**

**答案**：

- **构造函数**：通过 `new` 创建实例的函数（如 `function Person() {}`）
- **原型对象**：每个函数都有 `prototype` 属性，指向原型对象；每个实例都有 `__proto__` 属性，指向构造函数的原型对象
- **关系**：`实例.__proto__ === 构造函数.prototype`，原型对象的 `constructor` 属性指向构造函数

---

**题目 2：JS 的继承方式有哪些？手写 ES6 类继承**

**答案**：  
JS 常见继承方式：原型链继承、构造函数继承、组合继承、原型式继承、寄生式继承、寄生组合式继承（最优）、ES6 class 继承。

**手写 ES6 class 继承**：

```javascript
/**
 * ES6 class继承
 */
class Parent {
  constructor(name) {
    this.name = name;
  }
  // 原型方法
  sayHi() {
    console.log(`Hello, ${this.name}`);
  }
  // 静态方法
  static create() {
    return new Parent('Static');
  }
}

class Child extends Parent {
  constructor(name, age) {
    // 必须调用super，初始化父类构造函数
    super(name);
    this.age = age;
  }
  // 重写原型方法
  sayHi() {
    // 调用父类方法
    super.sayHi();
    console.log(`I'm ${this.age} years old`);
  }
}

// 测试
const c = new Child('李四', 18);
c.sayHi(); // Hello, 李四 → I'm 18 years old
console.log(Child.create()); // Parent { name: 'Static' }
```

---

### 3.6 原型链深入

**题目**：手写实现寄生组合式继承（最优继承方式）

**答案**：  
寄生组合式继承解决了组合继承（调用两次父类构造函数）的效率问题，是 ES6 之前的最优方案：

```javascript
/**
 * 寄生组合式继承
 * @param {Function} Child 子类 
 * @param {Function} Parent 父类 
 */
function inheritPrototype(Child, Parent) {
  // 创建父类原型的浅拷贝，避免修改父类原型
  const prototype = Object.create(Parent.prototype);
  // 修正constructor指向
  prototype.constructor = Child;
  // 子类原型指向拷贝的父类原型
  Child.prototype = prototype;
}

// 父类
function Parent(name) {
  this.name = name;
}
Parent.prototype.sayHi = function() {
  console.log(`Hi, ${this.name}`);
};

// 子类
function Child(name, age) {
  // 调用父类构造函数，初始化属性
  Parent.call(this, name);
  this.age = age;
}

// 实现继承
inheritPrototype(Child, Parent);

// 子类添加方法
Child.prototype.sayAge = function() {
  console.log(`Age: ${this.age}`);
};

// 测试
const c = new Child('王五', 20);
c.sayHi(); // Hi, 王五
c.sayAge(); // Age: 20
console.log(c instanceof Child); // true
console.log(c instanceof Parent); // true
```

---

### 3.7 Promise（核心）

**题目 1：Promise 的三种状态？状态能否逆转？then 方法的执行机制？**

**答案**：

- **三种状态**：
  
  - `pending`：初始状态，未完成
  - `fulfilled（resolved）`：成功状态
  - `rejected`：失败状态

- **状态逆转**：状态一旦改变，不可逆转（`pending→fulfilled` 或 `pending→rejected`，不可逆）

- **then 执行机制**：
  
  - `then` 是微任务（异步执行），返回新的 Promise，支持链式调用
  - 若 `then` 回调返回非 Promise 值，会包装为 `resolved` 状态的 Promise；若返回 Promise，会等待其状态改变

---

**题目 2：手写实现 Promise（简易版，含 resolve/reject/then）**

```javascript
/**
 * 简易版Promise实现
 */
class MyPromise {
  // 状态
  #state = 'pending';
  #value = undefined;
  #reason = undefined;
  // 回调队列（处理异步resolve/reject）
  #onFulfilledCallbacks = [];
  #onRejectedCallbacks = [];

  constructor(executor) {
    // 绑定this，避免执行时this丢失
    const resolve = (value) => {
      if (this.#state === 'pending') {
        this.#state = 'fulfilled';
        this.#value = value;
        // 执行成功回调
        this.#onFulfilledCallbacks.forEach(cb => cb());
      }
    };

    const reject = (reason) => {
      if (this.#state === 'pending') {
        this.#state = 'rejected';
        this.#reason = reason;
        // 执行失败回调
        this.#onRejectedCallbacks.forEach(cb => cb());
      }
    };

    try {
      // 执行执行器
      executor(resolve, reject);
    } catch (err) {
      // 执行器抛错，触发reject
      reject(err);
    }
  }

  // then方法
  then(onFulfilled, onRejected) {
    // 处理参数默认值（值穿透）
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : (v) => v;
    onRejected = typeof onRejected === 'function' ? onRejected : (r) => { throw r };

    // 返回新的Promise，实现链式调用
    return new MyPromise((resolve, reject) => {
      // 执行成功回调
      const handleFulfilled = () => {
        try {
          const result = onFulfilled(this.#value);
          // 处理返回Promise的情况
          if (result instanceof MyPromise) {
            result.then(resolve, reject);
          } else {
            resolve(result);
          }
        } catch (err) {
          reject(err);
        }
      };

      // 执行失败回调
      const handleRejected = () => {
        try {
          const result = onRejected(this.#reason);
          if (result instanceof MyPromise) {
            result.then(resolve, reject);
          } else {
            resolve(result);
          }
        } catch (err) {
          reject(err);
        }
      };

      // 同步状态时直接执行
      if (this.#state === 'fulfilled') {
        handleFulfilled();
      } else if (this.#state === 'rejected') {
        handleRejected();
      } else {
        // 异步状态时，存入回调队列
        this.#onFulfilledCallbacks.push(handleFulfilled);
        this.#onRejectedCallbacks.push(handleRejected);
      }
    });
  }

  // catch方法（等价于then(null, onRejected)）
  catch(onRejected) {
    return this.then(null, onRejected);
  }

  // 静态方法：resolve
  static resolve(value) {
    return new MyPromise(resolve => resolve(value));
  }

  // 静态方法：reject
  static reject(reason) {
    return new MyPromise((resolve, reject) => reject(reason));
  }
}

// 测试
new MyPromise((resolve) => {
  setTimeout(() => resolve('Promise测试'), 1000);
}).then(res => {
  console.log(res); // 1秒后输出 Promise测试
  return 123;
}).then(res => {
  console.log(res); // 输出 123
});
```

---

### 3.8 事件循环（Event Loop）

**题目 1：JS 的事件循环机制？宏任务与微任务的区别？执行顺序？**

**答案**：  
JS 是单线程语言，事件循环是解决异步操作的核心机制，流程如下：

1. **执行栈**：先执行同步代码
2. **微任务队列**：同步代码执行完，清空所有微任务
3. **宏任务队列**：微任务清空后，取一个宏任务执行
4. **循环往复**：微任务→宏任务→微任务→宏任务
- **宏任务**：`script` 整体代码、`setTimeout`、`setInterval`、AJAX 请求、DOM 事件、UI 渲染
- **微任务**：`Promise.then/catch/finally`、`MutationObserver`、`queueMicrotask`、`process.nextTick`（Node.js）

---

**题目 2：分析以下代码的执行顺序（大厂经典题）**

```javascript
console.log('1');
setTimeout(() => {
  console.log('2');
  Promise.resolve().then(() => {
    console.log('3');
  });
}, 0);
Promise.resolve().then(() => {
  console.log('4');
  setTimeout(() => {
    console.log('5');
  }, 0);
});
console.log('6');
```

**答案**：执行顺序：`1 → 6 → 4 → 2 → 3 → 5`
